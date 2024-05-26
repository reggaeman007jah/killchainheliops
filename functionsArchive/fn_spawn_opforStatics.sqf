/*
spawn_opforSttatics FNC 
Updated: 16 Nov 2023
Purpose: Spawns-in random statics and mortars around a given position 
Author: Reggs 
*/

params ["_objPos", "_enemyDir"];

for "_i" from 1 to ((selectRandom [2,3,4,5]) + patrolpointstaken) do {
	_grp = createGroup [east, true];
	_manned = [1] call RGGg_fnc_get_randomOpforClassname; 
	_class = [3] call RGGg_fnc_get_randomOpforStaticClassname; 
	_pos = [_objPos, 0, 50] call BIS_fnc_findSafePos;
	_unit = _grp createUnit [_manned, _pos, [], 1, "none"];
	_static = _class createVehicle _pos;
	RGG_staticsToDel pushBack _static;
	_unit moveInGunner _static;
	_unit setBehaviour "COMBAT";
	_testDirection = _unit getDir _enemyDir;
	_unit setDir _testDirection;
	bluforZeus addCuratorEditableObjects [[_static, _unit], true]; 								
};
for "_i" from 1 to (selectRandom [2,3,4]) do {
	_grp = createGroup [east, true];
	_manned = [1] call RGGg_fnc_get_randomOpforClassname; 
	_classes = [
		"vn_o_nva_65_static_mortar_type53",
		"vn_o_nva_65_static_mortar_type63"
	];
	_class = selectRandom _classes;
	_startPos = _this select 0;
	_pos = [_startPos, 50, 150] call BIS_fnc_findSafePos;
	_unit = _grp createUnit [_manned, _pos, [], 1, "none"];
	_static = _class createVehicle _pos;
	RGG_staticsToDel pushBack _static;
	_unit moveInGunner _static;
	_unit setBehaviour "COMBAT";
	_testDirection = _unit getDir _enemyDir;
	_unit setDir _testDirection;	
	bluforZeus addCuratorEditableObjects [[_static, _unit], true];								
};
