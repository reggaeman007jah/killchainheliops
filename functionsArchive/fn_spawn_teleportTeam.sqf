/*
spawn_teleportTeam FNC 
Updated: 06 Nov 2023
Purpose: Spawns two teams alongside the teleported player, so testing can be done without needing to Zeus units in 
Author: Reggs 
*/

params ["_spawnPoint", "_trigDist"];

if (_spawnPoint inArea "pathfinderbase") exitWith {};
_classData = [
	"vn_i_men_sf_01",
	"vn_i_men_sf_02",
	"vn_i_men_sf_03",
	"vn_i_men_sf_04",
	"vn_i_men_sf_05",
	"vn_i_men_sf_06",
	"vn_i_men_sf_07",
	"vn_i_men_sf_08",
	"vn_i_men_sf_09",
	"vn_i_men_sf_10",
	"vn_i_men_sf_11",
	"vn_i_men_sf_12"
];
_data = [] call RGGg_fnc_get_RFCHECK;
_redzoneIndi = _data select 0; 
_redzoneOpfor = _data select 1; 
_coreIndi = _data select 2; 
_coreOpfor = _data select 3; 
_redzonePlrs = _data select 4;
_spawn = 1; 
if (_redzoneIndi < 5) then {
	_spawn = 8;
};
if ((_redzoneIndi >= 5) && (_redzoneIndi < 25)) then {
	_spawn = 4;
};
_units = [];
for "_i" from 1 to _spawn do {
	_grp = createGroup [independent, true];
	_class = selectRandom _classData; 
	_dir = random 359;
	_pos = _spawnPoint getPos [20, _dir];
	_unit = _grp createUnit [_class, _pos, [], 1, "none"]; 
	_units pushBack _unit;
	_unit setUnitPos "MIDDLE";
	bluforZeus addCuratorEditableObjects [[_unit], true];
	sleep 0.1;
};
sleep 7;
{
	_x setUnitPos "AUTO";
} forEach _units;
