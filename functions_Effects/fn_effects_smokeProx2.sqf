/*
Smoke on player prox 
Updated: 16 May 2022 
Purpose: This is a re-write of the older smokeOnProx function, that used scripted triggers  
Author: Reggs 
*/

params ["_pos", "_prox", "_freq", "_numSmokes"];

_data = [];
_chk = true;
while { _chk } do {
	{
		_dist = _x distance _pos;
		if (_dist < _prox) then {
			_data pushBack _x;
		};
	} forEach allPlayers;
	_cnt = count _data;
	if (_cnt > 0) then {
		// a player is near 
		for "_i" from 1 to _numSmokes do {
			_smoke = createVehicle ['G_40mm_smokeYELLOW', _pos, [], 0, 'none'];
			sleep 45;
		};
		_chk = false;
	};
	sleep _freq;
};
