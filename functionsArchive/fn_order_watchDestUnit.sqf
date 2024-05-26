/*
Destination Position FNC 
Updated: 03 Dec 23
Author: Reggs
Purpose: Takes a unit, watches their distance to given position, and carries out an action on prox-trigger  

Params:
* _unit		/ unit 		/ unit to issue action on   
* _dest		/ position 	/ anchor to calc distance trigger  
* _dist		/ number 	/ at what distance in m to trigger the action  
* _freq		/ number 	/ how often in seconds to cycleCheck the loop 
* _limit	/ number 	/ how many iterations (of given freq) to run before giving up  
* _action	/ string 	/ short-code to describe what they are to do on activation  

Example: [_protector, (getPos _player), 15, 2, 45, "smokeOut"] spawn RGGo_fnc_order_watchDestUnit;

Notes:
- trying to make this more generic, and have it run different systems, not just a stance change 
- create another version, or change this one, so we can manage units as well as groups 
- usage must be aware that if limit is reached, the given action will not happen 
*/

params ["_unit", "_dest", "_dist", "_freq", "_limit", "_action"];

_it = 0;
_chk = true;
while {_chk} do {
	_it = _it + 1;
	if (((getPos _unit) distance _dest) < _dist) then {
		switch (_action) do {
			case "stanceProne": { _unit setUnitPos "down" };
			case "stanceMiddle": { _unit setUnitPos "middle" };
			case "stanceUp": { _unit setUnitPos "up" };
			case "stanceAuto": { _unit setUnitPos "auto" };
			case "stanceRandom": { _unit setUnitPos (selectRandom ["down", "middle", "up"]) };
			case "smokeOut": {
				systemChat "running SMOKES";
				_unit addMagazine "vn_m18_white_mag";
				[_unit, "vn_m18_white_Muzzle"] call BIS_fnc_fire;
				systemChat "smoke OUT";
			};
			default { systemChat "switch error - watchDest" };
		};
		_chk = false;
	};
	if (_it > _limit) then {
		_chk = false; // limiter - exit with no action 
	};
	sleep _freq;
};