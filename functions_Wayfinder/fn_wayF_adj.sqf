/*
Note: Make sure to check height before running - if heli is on ground, or rather speed is very slow, then always give theb OC 
The adjust left/right only makes sense when moving 

Note: Make sure this only runs if the player is in the heli 

{playSound "Left01"} remoteExec ["call", _player];
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

// _coP say3D ["squelch", _loud, 1, true]; sleep 0.3;
{playSound "squelch"} remoteExec ["call", _player];
switch (true) do {
	case (_rel == 0): { 
		systemChat format ["Debug - Do not adjust, Target is dead ahead at %1 degrees", _rel]; // needs sound for this
		{playSound "deadAhead"} remoteExec ["call", _player];
	};
	case (_rel >= 340): { 
		systemChat "DEBUG - _rel heading must be between 340 and 359";
		_diff = 360 - _rel;
		_new = _facing - _diff;
		switch (_diff) do {
			// case 1: 	{ _coP say3D ["Left01", _loud, 1, true] }; 
			// case 2: 	{ _coP say3D ["Left02", _loud, 1, true] }; 
			// case 3: 	{ _coP say3D ["Left03", _loud, 1, true] };
			// case 4: 	{ _coP say3D ["Left04", _loud, 1, true] };
			// case 5: 	{ _coP say3D ["Left05", _loud, 1, true] };
			// case 6: 	{ _coP say3D ["Left06", _loud, 1, true] };
			// case 7: 	{ _coP say3D ["Left07", _loud, 1, true] };
			// case 8: 	{ _coP say3D ["Left08", _loud, 1, true] };
			// case 9: 	{ _coP say3D ["Left09", _loud, 1, true] };
			// case 10: 	{ _coP say3D ["Left10", _loud, 1, true] };
			// case 11: 	{ _coP say3D ["Left11", _loud, 1, true] };
			// case 12: 	{ _coP say3D ["Left12", _loud, 1, true] };
			// case 13: 	{ _coP say3D ["Left13", _loud, 1, true] };
			// case 14: 	{ _coP say3D ["Left14", _loud, 1, true] };
			// case 15: 	{ _coP say3D ["Left15", _loud, 1, true] };
			// case 16: 	{ _coP say3D ["Left16", _loud, 1, true] };
			// case 17: 	{ _coP say3D ["Left17", _loud, 1, true] };
			// case 18: 	{ _coP say3D ["Left18", _loud, 1, true] };
			// case 19: 	{ _coP say3D ["Left19", _loud, 1, true] };
			// case 20: 	{ _coP say3D ["Left20", _loud, 1, true] };
			case 1: 	{ {playSound "Left01"} remoteExec ["call", _player]; }; 
			case 2: 	{ {playSound "Left02"} remoteExec ["call", _player]; }; 
			case 3: 	{ {playSound "Left03"} remoteExec ["call", _player]; };
			case 4: 	{ {playSound "Left04"} remoteExec ["call", _player]; };
			case 5: 	{ {playSound "Left05"} remoteExec ["call", _player]; };
			case 6: 	{ {playSound "Left06"} remoteExec ["call", _player]; };
			case 7: 	{ {playSound "Left07"} remoteExec ["call", _player]; };
			case 8: 	{ {playSound "Left08"} remoteExec ["call", _player]; };
			case 9: 	{ {playSound "Left09"} remoteExec ["call", _player]; };
			case 10: 	{ {playSound "Left10"} remoteExec ["call", _player]; };
			case 11: 	{ {playSound "Left11"} remoteExec ["call", _player]; };
			case 12: 	{ {playSound "Left12"} remoteExec ["call", _player]; };
			case 13: 	{ {playSound "Left13"} remoteExec ["call", _player]; };
			case 14: 	{ {playSound "Left14"} remoteExec ["call", _player]; };
			case 15: 	{ {playSound "Left15"} remoteExec ["call", _player]; };
			case 16: 	{ {playSound "Left16"} remoteExec ["call", _player]; };
			case 17: 	{ {playSound "Left17"} remoteExec ["call", _player]; };
			case 18: 	{ {playSound "Left18"} remoteExec ["call", _player]; };
			case 19: 	{ {playSound "Left19"} remoteExec ["call", _player]; };
			case 20: 	{ {playSound "Left20"} remoteExec ["call", _player]; };
			default 	{ systemChat "switch error left diff" };
		};
	};
	case ((_rel > 0) && (_rel < 21)): { 
		_diff = 0 + _rel;
		_new = _facing + _diff;		
		switch (_diff) do {
			// case 1:		{ _coP say3D ["Right01", _loud, 1, true] }; 
			// case 2: 	{ _coP say3D ["Right02", _loud, 1, true] }; 
			// case 3: 	{ _coP say3D ["Right03", _loud, 1, true] };
			// case 4: 	{ _coP say3D ["Right04", _loud, 1, true] };
			// case 5: 	{ _coP say3D ["Right05", _loud, 1, true] };
			// case 6: 	{ _coP say3D ["Right06", _loud, 1, true] };
			// case 7: 	{ _coP say3D ["Right07", _loud, 1, true] };
			// case 8: 	{ _coP say3D ["Right08", _loud, 1, true] };
			// case 9: 	{ _coP say3D ["Right09", _loud, 1, true] };
			// case 10: 	{ _coP say3D ["Right10", _loud, 1, true] };
			// case 11: 	{ _coP say3D ["Right11", _loud, 1, true] };
			// case 12: 	{ _coP say3D ["Right12", _loud, 1, true] };
			// case 13: 	{ _coP say3D ["Right13", _loud, 1, true] };
			// case 14: 	{ _coP say3D ["Right14", _loud, 1, true] };
			// case 15: 	{ _coP say3D ["Right15", _loud, 1, true] };
			// case 16: 	{ _coP say3D ["Right16", _loud, 1, true] };
			// case 17: 	{ _coP say3D ["Right17", _loud, 1, true] };
			// case 18: 	{ _coP say3D ["Right18", _loud, 1, true] };
			// case 19: 	{ _coP say3D ["Right19", _loud, 1, true] };
			// case 20: 	{ _coP say3D ["Right20", _loud, 1, true] };
			case 1: 	{ {playSound "Right01"} remoteExec ["call", _player]; }; 
			case 2: 	{ {playSound "Right02"} remoteExec ["call", _player]; }; 
			case 3: 	{ {playSound "Right03"} remoteExec ["call", _player]; };
			case 4: 	{ {playSound "Right04"} remoteExec ["call", _player]; };
			case 5: 	{ {playSound "Right05"} remoteExec ["call", _player]; };
			case 6: 	{ {playSound "Right06"} remoteExec ["call", _player]; };
			case 7: 	{ {playSound "Right07"} remoteExec ["call", _player]; };
			case 8: 	{ {playSound "Right08"} remoteExec ["call", _player]; };
			case 9: 	{ {playSound "Right09"} remoteExec ["call", _player]; };
			case 10: 	{ {playSound "Right10"} remoteExec ["call", _player]; };
			case 11: 	{ {playSound "Right11"} remoteExec ["call", _player]; };
			case 12: 	{ {playSound "Right12"} remoteExec ["call", _player]; };
			case 13: 	{ {playSound "Right13"} remoteExec ["call", _player]; };
			case 14: 	{ {playSound "Right14"} remoteExec ["call", _player]; };
			case 15: 	{ {playSound "Right15"} remoteExec ["call", _player]; };
			case 16: 	{ {playSound "Right16"} remoteExec ["call", _player]; };
			case 17: 	{ {playSound "Right17"} remoteExec ["call", _player]; };
			case 18: 	{ {playSound "Right18"} remoteExec ["call", _player]; };
			case 19: 	{ {playSound "Right19"} remoteExec ["call", _player]; };
			case 20: 	{ {playSound "Right20"} remoteExec ["call", _player]; };
			default 	{ systemChat "switch error right diff" };
		};		
	};
	default { 
		switch (true) do {
			// case ((_rel > 345) or (_rel <= 15)):   	{ _coP say3D ["12OC", _loud, 1, true] }; 
			// case ((_rel > 15)  && (_rel <= 45)):   	{ _coP say3D ["1OC", _loud, 1, true] }; 
			// case ((_rel > 45)  && (_rel <= 75)):   	{ _coP say3D ["2OC", _loud, 1, true] }; 
			// case ((_rel > 75)  && (_rel <= 105)):  	{ _coP say3D ["3OC", _loud, 1, true] }; 
			// case ((_rel > 105) && (_rel <= 135)):  	{ _coP say3D ["4OC", _loud, 1, true] }; 
			// case ((_rel > 135) && (_rel <= 165)):  	{ _coP say3D ["5OC", _loud, 1, true] }; 
			// case ((_rel > 165) && (_rel <= 195)):  	{ _coP say3D ["6OC", _loud, 1, true] }; 
			// case ((_rel > 195) && (_rel <= 225)):  	{ _coP say3D ["7OC", _loud, 1, true] }; 
			// case ((_rel > 225) && (_rel <= 255)):  	{ _coP say3D ["8OC", _loud, 1, true] }; 
			// case ((_rel > 255) && (_rel <= 285)):  	{ _coP say3D ["9OC", _loud, 1, true] }; 
			// case ((_rel > 285) && (_rel <= 315)):  	{ _coP say3D ["10OC", _loud, 1, true] }; 
			// case ((_rel > 315) && (_rel <= 345)):	{ _coP say3D ["11OC", _loud, 1, true] };
			case ((_rel > 345) or (_rel <= 15)):   	{ {playSound "12OC"} remoteExec ["call", _player]; }; 
			case ((_rel > 15)  && (_rel <= 45)):   	{ {playSound "1OC"} remoteExec ["call", _player]; }; 
			case ((_rel > 45)  && (_rel <= 75)):   	{ {playSound "2OC"} remoteExec ["call", _player]; }; 
			case ((_rel > 75)  && (_rel <= 105)):  	{ {playSound "3OC"} remoteExec ["call", _player]; }; 
			case ((_rel > 105) && (_rel <= 135)):  	{ {playSound "4OC"} remoteExec ["call", _player]; }; 
			case ((_rel > 135) && (_rel <= 165)):  	{ {playSound "5OC"} remoteExec ["call", _player]; }; 
			case ((_rel > 165) && (_rel <= 195)):  	{ {playSound "6OC"} remoteExec ["call", _player]; }; 
			case ((_rel > 195) && (_rel <= 225)):  	{ {playSound "7OC"} remoteExec ["call", _player]; }; 
			case ((_rel > 225) && (_rel <= 255)):  	{ {playSound "8OC"} remoteExec ["call", _player]; }; 
			case ((_rel > 255) && (_rel <= 285)):  	{ {playSound "9OC"} remoteExec ["call", _player]; }; 
			case ((_rel > 285) && (_rel <= 315)):  	{ {playSound "10OC"} remoteExec ["call", _player]; }; 
			case ((_rel > 315) && (_rel <= 345)):	{ {playSound "11OC"} remoteExec ["call", _player]; };
			default 								{ systemChat "error, wayfinder clock switch" };
		};
	};
};
// _coP say3D ["squelch", _loud, 1, true]; sleep 0.3;
{playSound "squelch"} remoteExec ["call", _player];

