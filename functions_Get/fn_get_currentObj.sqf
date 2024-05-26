/*
Get Current Obj FNC 
Updated: 13 Nov 2023 

Purpose: Returns position of current objective 

Notes:
- this should be expanded, to be used where needed (I think this is ofgten calc's locally)
*/

_objPos = [0,0]; // init dec
switch (patrolPointsTaken) do {
	case 0: {
		_objPos = RGG_PatrolPoints select 0;
	};
	case 1: {
		_objPos = RGG_PatrolPoints select 1;
	};
	case 2: {
		_objPos = RGG_PatrolPoints select 2;
	};
	case 3: {
		_objPos = RGG_PatrolPoints select 3;
	};
	case 4: {
		_objPos = RGG_PatrolPoints select 4;
	};
	case 5: {
		_objPos = RGG_PatrolPoints select 5;
	};
	default {
		systemChat "error: Patrol Point switch";
	};
};
_objPos;