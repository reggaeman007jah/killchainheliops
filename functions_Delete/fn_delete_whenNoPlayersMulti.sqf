/*
Delete when no players near - Multi 
Updated: 22 May 2022 

This function will take an array of objects, and a time value, and will check (per time value) whether any players are nearby, and 
if false, will delete everything in the array - used mainly for safe despawning of objects and mission items 

*/

params ["_toDel", "_gap", "_cycle"];

_data = _toDel select 0;

_chk = true;
while { _chk } do {	
	{
		_chkPos = getPos _x;
		_nearP = [];
		{
			_dist = _chkPos distance _x;

			if (_dist < _gap) then {
				_nearP pushBack _x;
			};
		} forEach allPlayers;
	} forEach _data;
	_cnt = count _nearP;
	if (_cnt == 0) then {
		{
			deleteVehicle _x;
		} forEach _data;
	};

	sleep _cycle;
};
