/*
Destination Position FNC 
Updated: 03 Dec 23
Author: Reggs
Purpose: Takes a group leader, watches their distance to given position, and carries out an action on prox-trigger  

Params:
- _group	/ unit to manage action  
- _dest		/ anchor to calc distance trigger  
- _dist		/ at what distance to trigger the action  
- _freq		/ how often to cycleCheck the loop 
- _limit	/ how many iterations (of set freq) before giving up  
- _action	/ What they are to do on activation  

Example: [_x, _movePos, 10, 2, 30, "stanceMiddle"] spawn RGGo_fnc_order_watchDest;

Notes:
- trying to make this more generic, and have it run different systems, not just a stance change 
- create another version, or change this one, so we can manage units as well as groups 
- usage must be aware that if limit is reached, the given action will not happen 
*/

params ["_group", "_dest", "_dist", "_freq", "_limit", "_action"];

_it = 0;
_chk = true;
while {_chk} do {
	_it = _it + 1;
	_unitPos = getPos (leader _group);
	_distance = _unitPos distance _dest;
	if (_distance < _dist) then {
		{
			switch (_action) do {
				case "stanceProne": { _x setUnitPos "down" };
				case "stanceMiddle": { _x setUnitPos "middle" };
				case "stanceUp": { _x setUnitPos "up" };
				case "stanceAuto": { _x setUnitPos "auto" };
				case "stanceRandom": { _x setUnitPos (selectRandom ["down", "middle", "up"]) };
				case "smokeOut": {
					_x addItem "vn_m18_white_mag";
					[_x, "vn_m18_white_Muzzle"] call BIS_fnc_fire;
					sleep (random 3); // this could be a param, but only if needed, leave as hardcoded for now 
				};
				default { systemChat "switch error - watchDest" };
			};
		} forEach (units _group);
		_chk = false;
	};
	if (_it > _limit) then {
		_chk = false; // limiter - exit with no action 
	};
	sleep _freq;
};