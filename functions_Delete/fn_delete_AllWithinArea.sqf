/*
Delete all things FNC 
Updated: 03 June 24
Purpose: Takes a position and radius, and destroys all objects within - also retrigs another mission    
Author: Reggs 

_anchor: anchor pos for action 
_rad: radius for deleting all 
_plrDist: min dist all players must be beofre this can happen 
_cycle: check freq 
_raptorNum: variable name e.g. raptor6 
*/

params ["_anchor", "_rad", "_plrDist", "_cycle", "_raptorNum"];


_chk = true;
while {_chk} do {

	// here we check whether any players are near to the given anchor, using _plrDist as the threshold distance 
	_data = [];
	{
		if (((getPos _x) distance _anchor) < _plrDist) then {
			_data pushBack _x;
		};
	} forEach allPlayers;
	// if this ^^ is used elswehere, make into a FNC 

	if ((count _data) == 0) then {

		// TO DO - have an audio completion effect here 

		{ 
			deleteVehicle _x;
		} forEach nearestObjects [_anchor, ['all'], _rad];

		// TO DO - determine why some boarding markers don't delete, and consider uising this FNC as a way to clear up 

		// Here, we free up the given raptor for new tasking 		
		_numb = (str _raptorNum) select [6, 1]; // extracts the Raptor Number from the var name passed via _raptorNum
		switch (_numb) do {
			case "1": { 
				if (RGG_rap1onTask == true) then {
					RGG_rap1onTask = false;
					[_raptorNum] spawn RGGm_fnc_mission_manager;	
				} else {
					systemChat "DEBUG - Raptor 1 is already tasked - complete current task before taking another";
				};
				deleteMarker "raptor1";
			};
			case "2": { 
				if (RGG_rap2onTask == true) then {
					RGG_rap2onTask = false;
					[_raptorNum] spawn RGGm_fnc_mission_manager;	
				} else {
					systemChat "DEBUG - Raptor 2 is already tasked - complete current task before taking another";
				};
				deleteMarker "raptor2";
			};
			case "3": { 
				if (RGG_rap3onTask == true) then {
					RGG_rap3onTask = false;
					systemChat "delete_allWithinArea - RGG_rap3onTask is true, now changed to false, sending new mission";
					[_raptorNum] spawn RGGm_fnc_mission_manager;	
				} else {
					systemChat "DEBUG - Raptor 3 is already tasked - complete current task before taking another";
					systemChat "delete_allWithinArea - RGG_rap3onTask is false, taking no action - if there is no live mission then this is a bug!";
					[_raptorNum] spawn RGGm_fnc_mission_manager;
				};
				deleteMarker "raptor3";
			};
			case "4": { 
				if (RGG_rap4onTask == true) then {
					RGG_rap4onTask = false;
					[_raptorNum] spawn RGGm_fnc_mission_manager;	
				} else {
					systemChat "DEBUG - Raptor 4 is already tasked - complete current task before taking another";
				};
				deleteMarker "raptor4";
			};
			case "5": { 
				if (RGG_rap5onTask == true) then {
					RGG_rap5onTask = false;
					[_raptorNum] spawn RGGm_fnc_mission_manager;	
				} else {
					systemChat "DEBUG - Raptor 5 is already tasked - complete current task before taking another";
				};
				deleteMarker "raptor5";
			};
			case "6": { 
				if (RGG_rap6onTask == true) then {
					RGG_rap6onTask = false;
					[_raptorNum] spawn RGGm_fnc_mission_manager;	
				} else {
					systemChat "DEBUG - Raptor 6 is already tasked - complete current task before taking another";
				};
				deleteMarker "raptor6";
			};
			default { systemChat "raptor tasking switch error"};
		};
		_chk = false;
	};

	sleep _cycle;
};


