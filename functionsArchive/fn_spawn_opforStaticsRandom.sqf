/*
spawn_opforStaticsRandom FNC 
Updated: 04 Dec 2023
Purpose: Spawns-in random statics in given marker area  
Author: Reggs
*/

params ["_markerZone", "_num", "_pointTo"];

for "_i" from 1 to _num do {
	_grp = createGroup [east, true];
	_manned = [1] call RGGg_fnc_get_randomOpforClassname; 
	_class = [1] call RGGg_fnc_get_randomOpforStaticClassname; 
	_pos = [(_markerZone call BIS_fnc_randomPosTrigger), 0, 50] call BIS_fnc_findSafePos;
	_unit = _grp createUnit [_manned, _pos, [], 1, "none"];
	_static = _class createVehicle _pos;
	RGG_staticsToDel pushBack _static;
	_unit moveInGunner _static;
	_unit setBehaviour "COMBAT";
	_unit setDir (_pos getDir _pointTo);
	bluforZeus addCuratorEditableObjects [[_static, _unit], true]; 	
};