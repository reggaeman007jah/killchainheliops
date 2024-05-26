/*
TINMAN BASIC - Remain with PL 
Updated: 31 Oct 2023 

Purpose: One off order - all indi groups to fall back to PL position and remain with him 
*/

// {playSound "fallbackremain"} remoteExec ["call",-2];
// _initStartPos = _this select 0; // origin point 
// _objPos = _this select 1; // obj point 

FALLBACKREMAIN = true;
while {FALLBACKREMAIN} do {
	
	_commPos = [] call RGGg_fnc_get_tinmanPos; // get PL position 
	_inRed = _commPos inArea "redzone";
	if (_inRed) then {
		_selection = allGroups select {side _x isEqualTo independent};
		{
			_clientID = groupOwner _x;
			if (_clientID != 2) then {
				_localityChanged = _x setGroupOwner 2;
			};

			{
				_x setUnitPos "up";
				sleep (selectRandom [0.1, 0.2, 0.3]);					
			} forEach (units _x);

			_dist = _commPos distance (getPos leader _x);
			if (_dist > 21) then {
				_randomDir = random 359;
				_randomDist = selectRandom [15, 20, 25];
				_endPoint1 = _commPos getPos [_randomDist,_randomDir];
				_x move _commPos;
				// systemChat format ["DEBUG - MOVE ORDER / Group %1 moving to %2", _x, _commPos];
			};
		} forEach _selection;
	} else {
		FALLBACKREMAIN = false;
	};
	sleep 20;
};
