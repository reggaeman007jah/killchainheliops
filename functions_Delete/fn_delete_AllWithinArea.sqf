/*
Delete all things FNC 
Updated: 17 Dec 23
Purpose: Takes a position and radius, and destroys all objects within - also retrigs another mission    
Author: Reggs 

_anchor: anchor pos for action 
_rad: radius for deleting all 
_plrDist: min dist all players must be beofre this can happen 
_cycle: check freq 
*/

params ["_anchor", "_rad", "_plrDist", "_cycle"];


_chk = true;
while {_chk} do {
	_data = [];
	{
		_playerPos = getPos _x;
		_distance = _playerPos distance _anchor;
		if (_distance < _plrDist) then {
			_data pushBack _x;
		};
	} forEach allPlayers;

	_cnt = count _data;
	if (_cnt == 0) then {
		systemChat format ["DEBUG - - - DELETING IN-FIELD UNITS AT %1 FOLLOWING ZERO PLAYER FOUND NEARBY", _anchor];
		{ 
			deleteVehicle _x;
		} forEach nearestObjects [_anchor, ['all'], _rad];

		sleep 2;

		// new mission 
		// if (RGG_MISSIONLIVE == false) then {
		// 	[] spawn RGGm_fnc_mission_manager;
		// 	RGG_MISSIONLIVE = true;
		// } else {
		// 	systemChat "mission is already live";
		// };

		[] spawn RGGm_fnc_mission_manager;
		_chk = false;
	};

	sleep _cycle;
};


