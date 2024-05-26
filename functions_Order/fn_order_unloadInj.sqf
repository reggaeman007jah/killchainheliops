/*
Unload Injured 
Updated: 11 May 2022

This function will unload any injured AI automatically if in the designated medical LZ, and send them for processing at the medic station.
It manages the getting out and moving away elements, but spawns the deleteWhenNoPlayersNear system separately.

Note: as of 11 May 2022, this only manages BLUFOR unloads.

Note: We need to be able to ID which units are sent in; we will use this for both blufor and indifor units, maybe even opfor one day , so 
depending on their classname / faction, different things could happen.

Note: BLUFOR reward system is spawned from here also, and we need to add a noPlayerNear system to that, to prevent spawnInFrontOfEyes 

Todo: If we return injured indifor AI, then we can be rewarded with x2 units in return 

Note: currently runs on whileTrue20 - so think about how this can be more performant without having a player action to trigger stuff 

Old notes:
We need to furnish this function with an array of names // no 
We need to run a check so that once any heli has landed with injured, then everything will just happen 
keyword search: processInjured - this will show how I did the other system - civvies in Anizay 
use: b_med marker for just blufor rescues 
what if you want to deploy AI here but they've been healed?? 
We need to make it so that any AI dropped off here will be taken in regardless of health 
AND - different LZs for different things - so here we have  set LZ just for blufor AI extracted (pilots LRRP) etc 
while/true - always runs, even if no mission 
cycle every 20 seconds 
check for helis in area 
if yes, run check for cargo - checking for injured that is not a player 
if any found, then order disembark and order move to medical 
in current system, to keep this lean, do not put any helis or vics in the checking area 

toDo - remove ambient helis from this, by either using alt, or checkint that a player is near 
*/

sleep 30; // let init happen first 

while { TRUE } do {
	
	_vics = vehicles inAreaArray "bluMedTrig";
	_helis = []; // to hold any heli data 
	_getOutB = []; // to hold Blufor AI passengers ready to disembark 
	_getOutI = []; // to hold Indifor AI passengers .. 

	_cnt = count _vics;
	if (_cnt > 0) then {
		// pushback only helis 
		{
			if (_x isKindOf "helicopter") then {
				systemchat "DEBUG - we have a heli close to the medic LZ";
				systemChat "DEBUG - but .. are there any AI in cargo?";

				_list = fullCrew _x;
				systemChat format ["fullCrew: %1", _list];

				{
					_check = _x select 0;
					systemChat format ["_check: %1", _check];
					if (isPlayer _check == false) then {
						systemChat "not a player, continue to check";
						switch (side _check) do {
							case WEST: { 
								systemChat "we have a westy";
								_check = _x select 0;
								systemChat format ["checking: %1", _check];
								_typeOf = typeOf _check;
								systemChat format ["_typeOf: %1", _typeOf];
								if (_typeOf == "vn_b_men_jetpilot_10") then {
									_getOutB pushBackUnique _x;
									[] spawn RGGs_fnc_spawn_pilotRewards;
								} else {
									systemChat format ["westy found, not unloading: %1", _x];
								};
							};
							case INDEPENDENT: { _getOutI pushBackUnique _x };
						};
					};
				} forEach _list;

				_cBlu = count _getOutB;
				_cInd = count _getOutI;
				systemChat format ["Debug - Blufor ready for disembark: %1", _cBlu];
				systemChat format ["Debug - Indifor ready for disembark: %1", _cInd];
			};
		} forEach _vics;

		_cBlu = count _getOutB; // repeated, i know
		if (_cBlu > 0) then {
			{
				_check = _x select 0;
				_heli = assignedVehicle _check;
				unassignVehicle _check;
				[_check] orderGetIn false;
				_moveTo = getMarkerPos "processInjured";
				_check doMove _moveTo; // medical hanger pos  
				[_check] spawn RGGd_fnc_delete_processInjured;
				systemChat format ["_check being sent for unloadDelete: %1", _check];
			} forEach _getOutB;
		};
	} else {
		// no helis - do nothing?
	};

	sleep 20; // would it be better to track dist of all known helis to LZ here? What is cheaper?
};

// we should fix this and ensure delete happens properly 