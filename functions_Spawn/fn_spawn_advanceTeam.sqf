/*
spawn_advanceTeam FNC 
Updated: 03 June 2024 
Purpose: Spawns in a friendly team on designated pos (LZ) 
Author: Reggs 
*/

params ["_spawnPoint", "_trigDist"];

systemChat "spawning in advance team";

_smoke = createVehicle ["G_40mm_smokeYELLOW", _spawnPoint, [], 0, "none"]; 

for "_i" from 1 to (15 + (random 20)) do {
	_grp = createGroup [west, true];
	_class = [] call RGGg_fnc_get_randomArmyClassname;  
	_dir = random 359;
	_pos = _spawnPoint getPos [(20 + (random 60)), _dir];
	_unit = _grp createUnit [_class, _pos, [], 1, "none"]; 
	_unit setUnitPos "MIDDLE";
	_unit setCaptive true;
	{
		_x addCuratorEditableObjects [[_unit], false];
	} forEach allCurators;
	sleep 1; 
};



// actions:
// make all units face random directions 
