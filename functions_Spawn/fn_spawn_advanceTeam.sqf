/*
spawn_advanceTeam FNC 
Updated: 07 June 2022 
Purpose: Spawns in a friendly team on designated pos (LZ) 
Author: Reggs 
*/

params ["_spawnPoint", "_trigDist"];

for "_i" from 1 to (10 + (random 20)) do {
	_grp = createGroup [independent, true];
	_class = [] call RGGg_fnc_get_randomArmyClassname;  
	_dir = random 359;
	_pos = _spawnPoint getPos [(120 + (random 20)), _dir];
	_unit = _grp createUnit [_class, _pos, [], 1, "none"]; 
	_unit setUnitPos "MIDDLE";
	{
		_x addCuratorEditableObjects [[_unit], false];
	} forEach allCurators;
	sleep 1; 
};

_smoke = createVehicle ["G_40mm_smokeYELLOW", _spawnPoint, [], 0, "none"]; 

// actions:
// make all units face random directions 
