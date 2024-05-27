/*
Note: Make sure to check height before running - if heli is on ground, or rather speed is very slow, then always give theb OC 
The adjust left/right only makes sense when moving 

Note: Make sure this only runs if the player is in the heli 
*/

systemChat "DEBUG - running f_wayF_adj";

private _fnc_getCoPilots = {
	private _copilotTurrets = allTurrets _this select { getNumber ([_this, _x] call BIS_fnc_turretConfig >> "isCopilot") > 0 };
	private _copilots = _copilotTurrets apply { _this turretUnit _x };
	_copilots;
};

// _marker = str player;  

_player = player; 
_pos = RGG_currentObj;  
_heli = vehicle _player;  
_cp = (_heli call _fnc_getCoPilots);
_coP = _cp select 0; 
_loud = 30; 
_new = 0;
_diff = 0;
_gap = 0.8; 
_facing = floor (getdir _heli); 
_rel = floor (_heli getRelDir _pos);
_target = floor (_heli getDir _pos); 

_coP say3D ["squelch", _loud, 1, true]; sleep 0.3;
switch (true) do {
	case (_rel == 0): { 
		systemChat format ["Debug - Do not adjust, Target is dead ahead at %1 degrees", _rel]; // needs sound for this
	};
	case (_rel >= 340): { 
		systemChat "DEBUG - _rel heading must be between 340 and 359";
		_diff = 360 - _rel;
		_new = _facing - _diff;
		switch (_diff) do {
			case 1: 	{ _coP say3D ["Left01", _loud, 1, true] }; 
			case 2: 	{ _coP say3D ["Left02", _loud, 1, true] }; 
			case 3: 	{ _coP say3D ["Left03", _loud, 1, true] };
			case 4: 	{ _coP say3D ["Left04", _loud, 1, true] };
			case 5: 	{ _coP say3D ["Left05", _loud, 1, true] };
			case 6: 	{ _coP say3D ["Left06", _loud, 1, true] };
			case 7: 	{ _coP say3D ["Left07", _loud, 1, true] };
			case 8: 	{ _coP say3D ["Left08", _loud, 1, true] };
			case 9: 	{ _coP say3D ["Left09", _loud, 1, true] };
			case 10: 	{ _coP say3D ["Left10", _loud, 1, true] };
			case 11: 	{ _coP say3D ["Left11", _loud, 1, true] };
			case 12: 	{ _coP say3D ["Left12", _loud, 1, true] };
			case 13: 	{ _coP say3D ["Left13", _loud, 1, true] };
			case 14: 	{ _coP say3D ["Left14", _loud, 1, true] };
			case 15: 	{ _coP say3D ["Left15", _loud, 1, true] };
			case 16: 	{ _coP say3D ["Left16", _loud, 1, true] };
			case 17: 	{ _coP say3D ["Left17", _loud, 1, true] };
			case 18: 	{ _coP say3D ["Left18", _loud, 1, true] };
			case 19: 	{ _coP say3D ["Left19", _loud, 1, true] };
			case 20: 	{ _coP say3D ["Left20", _loud, 1, true] };
			default 	{ systemChat "switch error left diff" };
		};
	};
	case ((_rel > 0) && (_rel < 21)): { 
		_diff = 0 + _rel;
		_new = _facing + _diff;		
		switch (_diff) do {
			case 1:		{ _coP say3D ["Right01", _loud, 1, true] }; 
			case 2: 	{ _coP say3D ["Right02", _loud, 1, true] }; 
			case 3: 	{ _coP say3D ["Right03", _loud, 1, true] };
			case 4: 	{ _coP say3D ["Right04", _loud, 1, true] };
			case 5: 	{ _coP say3D ["Right05", _loud, 1, true] };
			case 6: 	{ _coP say3D ["Right06", _loud, 1, true] };
			case 7: 	{ _coP say3D ["Right07", _loud, 1, true] };
			case 8: 	{ _coP say3D ["Right08", _loud, 1, true] };
			case 9: 	{ _coP say3D ["Right09", _loud, 1, true] };
			case 10: 	{ _coP say3D ["Right10", _loud, 1, true] };
			case 11: 	{ _coP say3D ["Right11", _loud, 1, true] };
			case 12: 	{ _coP say3D ["Right12", _loud, 1, true] };
			case 13: 	{ _coP say3D ["Right13", _loud, 1, true] };
			case 14: 	{ _coP say3D ["Right14", _loud, 1, true] };
			case 15: 	{ _coP say3D ["Right15", _loud, 1, true] };
			case 16: 	{ _coP say3D ["Right16", _loud, 1, true] };
			case 17: 	{ _coP say3D ["Right17", _loud, 1, true] };
			case 18: 	{ _coP say3D ["Right18", _loud, 1, true] };
			case 19: 	{ _coP say3D ["Right19", _loud, 1, true] };
			case 20: 	{ _coP say3D ["Right20", _loud, 1, true] };
			default 	{ systemChat "switch error right diff" };
		};		
	};
	default { 
		switch (true) do {
			case ((_rel > 345) or (_rel <= 15)):   	{ _coP say3D ["12OC", _loud, 1, true] }; 
			case ((_rel > 15)  && (_rel <= 45)):   	{ _coP say3D ["1OC", _loud, 1, true] }; 
			case ((_rel > 45)  && (_rel <= 75)):   	{ _coP say3D ["2OC", _loud, 1, true] }; 
			case ((_rel > 75)  && (_rel <= 105)):  	{ _coP say3D ["3OC", _loud, 1, true] }; 
			case ((_rel > 105) && (_rel <= 135)):  	{ _coP say3D ["4OC", _loud, 1, true] }; 
			case ((_rel > 135) && (_rel <= 165)):  	{ _coP say3D ["5OC", _loud, 1, true] }; 
			case ((_rel > 165) && (_rel <= 195)):  	{ _coP say3D ["6OC", _loud, 1, true] }; 
			case ((_rel > 195) && (_rel <= 225)):  	{ _coP say3D ["7OC", _loud, 1, true] }; 
			case ((_rel > 225) && (_rel <= 255)):  	{ _coP say3D ["8OC", _loud, 1, true] }; 
			case ((_rel > 255) && (_rel <= 285)):  	{ _coP say3D ["9OC", _loud, 1, true] }; 
			case ((_rel > 285) && (_rel <= 315)):  	{ _coP say3D ["10OC", _loud, 1, true] }; 
			case ((_rel > 315) && (_rel <= 345)):	{ _coP say3D ["11OC", _loud, 1, true] };
			default 								{ systemChat "error, wayfinder clock switch" };
		};
	};
};
_coP say3D ["squelch", _loud, 1, true]; sleep 0.3;

