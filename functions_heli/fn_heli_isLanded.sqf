/*
Heli Is Landed FNC 
Updated: 04 Nov 2023

Purpose: Runs on a loop, while a mission Bool is true, and checks for isLanded state 

Notes: 
- Will trigger a FNC based on whether they are in base or in-field 
- uses passed _checkBool as a cycleCheck 
- ensure this won't run forever!!
*/

params ["_heli", "_checkBool"];

while {_checkBool} do {
	
	if (isTouchingGround) then {
		_wait = true;

		while {_wait} do {
			
			if (!isTouchingGround) then {
				_wait = false;
			};
			sleep 5;
		};
	};

	sleep 2;
};


	_pos = getPos _plane;
	_inPathfinder = player inArea "pathfinderBase";

	_wait = true;
	if (_inPathfinder) then {
		// get out 
	} else {
		// get in 
	};

	sleep 2;
};


