/*
Check Deploy FNC 
Updated: 27 Oct 2023 
Purpose: This FNC checks for altitude of the given heli, and if in redzone, will automatically deploy troops off heli onto 
the ground. Runs as part of the main mission - i.e. an active patrol is needed for this to work.

This system has evolved over some time, but essentially tries to manage the boardng and unboarding of troops without any 
direct control from the pilot/player. As a design rule, I wanted to avoid using any addAction, or dialog, and have things 
just 'happen'. I realise that this sometimes may lead to unwanted outcomes, so knowing how this system works will assist 
any pilot in doing their job. 

The Pathfinder base has a designated Pickup Zone for independent troops. If a player lands at this PZ, the system will 
assess how many free cargo seats there are, it will then spawn the same number of units (behind some sort of cover so you 
don't see them 'appear'), and have them board the heli. 

If independent units are picked up, they will auto-disembark if the pilot lands in the 'red zone'. This zone is created 
when the mission starts, so work is needed to explore whether to enable a system that works regardless of a live mission.
But for now, the indi unit system is 'mission-specific'. 
*/

params ["_heli", "_cargo"];

_redCheck = true; // this cycleCheck monitors whether the heli is in the redzone, and progresses the script if yes 
_altCheck = false; // this secondary cycleCheck monitors height and is used to make unboarding decisions 

while {_redCheck} do {

	systemChat "running redcheck";
	// _cnt = count _cargo;
	// systemChat format ["cargo _cnt: %1", _cnt];
	
	if ({alive _x} count crew _heli == 0) then {
		_redCheck = false;
	};
	// // not in redzone
	// if (isEngineOn _heli) then {
	// 	_pos = getPos _heli; // get heli position 
	// 	_inRed = _pos inArea "redzone";
	// 	if (_inRed) then {
	// 		_redCheck = false;
	// 		_altCheck = true; // heli is in redzone - switching to alt-check
	// 	};
	// } else {
	// 	_redCheck = false; // this should shut everything down if the engine is turned off
	// };
	// the above code bugged if the engine was switched off before units were disembarked, code below attempts to fix this 

	// not in redzone

	_inRed = (getPos _heli) inArea "redzone";
	if (_inRed) then {
		_redCheck = false;
		_altCheck = true; // heli is in redzone - switching to alt-check
	};
	// seems to work, but what if heli is destroyed? Will this loop still run? yes 
	sleep 10;
};

while {_altCheck} do {

	// heli is in redzone
	if (isEngineOn _heli) then {
		_atl1 = (getPosATL _heli) select 2; // height 

		if ((_atl1) < 4) then {
			if ((speed _heli) < 25) then {
				_grps = [];
				{
					_grp = group _x;
					_grps pushBackUnique _grp;
					unassignVehicle _x;
					moveOut _x;
					sleep 0.7;
				} forEach _cargo;

				{
					_x setFormation "diamond";
				} forEach _grps;

				_altCheck = false;
			};
		};
	} else {
		// this should shut everything down if the engine is turned off
		_altCheck = false;
		// there could be reasons for shutting down - so how do you deal with cargo here? More work needed to finish this bit!
	};

	sleep 2;
};

// consider a separate script to manage auto-bording of injured units - maybe using a smoke marker?
