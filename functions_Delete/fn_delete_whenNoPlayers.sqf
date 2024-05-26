/*
Delete when no players near 
Updated: 22 May 2022 

_toDel: array to cycle through 
_pos: anchor pos to check against each player pos  
_gap: given distance trigger to action the delete 
_cycle: how often to check 
*/

params ["_toDel", "_pos", "_gap", "_cycle"];

_chk = true;
while { _chk } do {	
	_nearP = [];
	{
		_dist = _pos distance _x;

		if (_dist < _gap) then {
			_nearP pushBack _x;
		};
	} forEach allPlayers;
	_cnt = count _nearP;
	if (_cnt == 0) then {
		{
			deleteVehicle _x;
		} forEach _toDel;
	};
	sleep _cycle;
};