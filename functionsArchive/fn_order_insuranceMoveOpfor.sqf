/*
Opfor Insurance Move Order FNC 
Updated: 03 Nov 2023 

Purpose: This is used to ensure opfor is always presenting a target, and avoids lack of movement from preventing the mission from progressing
*/

params ["_objPos"];

_east = [];
{
	if ((side _x) == EAST) then {_east pushBack _x};
} forEach allUnits;

// consider adding a distance check here, sending to a new array 

{
	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
	_unitDest = [_objPos, 5, 20] call BIS_fnc_findSafePos;
	_endPoint1 = _unitDest getPos [_randomDist,_randomDir];
	sleep 2;
	_x setBehaviour "COMBAT";
	_x doMove _endPoint1;
} forEach _east;
