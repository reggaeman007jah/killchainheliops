/*
Patrol Core FNC 
Updated: 06 Nov 2023

Purpose: Runs on a cycle as makes any indifor in the core zone, move around
*/

// runs on each unit, having them move, then crouch 
_RGG_moveAround = {
	params ["_unit"];

	// get random pos in zone 
	_movePos = [["missionCore"]] call BIS_fnc_randomPos;

	// stand 
	_unit setUnitPos "up";

	// walk
	_unit setSpeedMode "limited";

	// move to pos 
	_unit doMOve _movePos;

	_chk = true;
	while {true} do {
		_dist = (getPos _unit) distance _movePos;
		if (_dist < 2) then {
			_unit setUnitPos "middle";
			_chk = false;
		} else {
			_chk = true;
			_unit setUnitPos "auto";
		};
		sleep 10;
	};
	
};

while {true} do {

	_coreUnits = allUnits inAreaArray "missionCore";
	// _indiCoreUnits = [];
	
	// {			
	// 	if ((side _x) == independent) then {
	// 		_indiCoreUnits pushBack _x;		
	// 	};
	// } forEach _coreUnits;		
	

	_cnt = count _coreUnits;
	if (_cnt > 0) then {
		{
			[_x] spawn _RGG_moveAround;	
			sleep (random 1);		
		} forEach _coreUnits;		
	};

	sleep 120;
};