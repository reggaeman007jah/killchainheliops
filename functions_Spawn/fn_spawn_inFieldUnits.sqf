/*
spawn_inFieldUnits FNC 
Purpose: Spawns in fresh blufor units in the field 
Updated: 04 June 24 
Author: Reggs 

_anchor: point at which units are created 
_num: number of units to be created 
_radFrom: closest random dist from _anchor units are spawned in 
_radTo: furthest random dist from _anchor units are spawned in 
_type: number / 1 = normal solders, 2 = LRRP Spec Ops 
*/

params ["_anchor", "_num", "_radFrom", "_radTo", "_type"];

for "_i" from 1 to _num do {
	_grp = createGroup [west, true];
	_class = [_type] call RGGg_fnc_get_randomArmyClassname;  
	_dir = random 359;
	_pos = _anchor getPos [(_radFrom + _radTo), _dir];
	_unit = _grp createUnit [_class, _pos, [], 1, "none"]; 
	_unit setUnitPos "MIDDLE";
	{
		_x addCuratorEditableObjects [[_unit], false];
	} forEach allCurators;
	sleep 0.2; 
};



