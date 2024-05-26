/*
spawn_opforRandomThreats FNC 
Updated: 30 Oct 2023
Purpose: Creates random groups in the AO, running on each stageLoop, at the attack stage. 
Author: Reggs 
*/

params ["_anchor"];

_randomEnemySpawnPos = [_anchor, 200, 400, 3, 0, 0, 0] call BIS_fnc_findSafePos; 
_enemyNear1 = [_randomEnemySpawnPos, 200, "west"] call RGGf_fnc_find_nearbyUnits;
_enemyNear2 = [_randomEnemySpawnPos, 200, "independent"] call RGGf_fnc_find_nearbyUnits; 
_locs = [];
_it = 0;
while {(count _locs) < 1} do {
	_it = _it + 1;
	if (_it > 100) exitWith {systemChat "too many fails, breaking out"};
	_randomEnemySpawnPos = [_anchor, 200, 400, 3, 0, 0, 0] call BIS_fnc_findSafePos; 
	_enemyNear1 = [_randomEnemySpawnPos, 200, "west"] call RGGf_fnc_find_nearbyUnits;
	_enemyNear2 = [_randomEnemySpawnPos, 200, "indi"] call RGGf_fnc_find_nearbyUnits; 
	if ((_enemyNear1 == false) && (_enemyNear2 == false)) then {
		_locs pushBack _randomEnemySpawnPos;
	} else {
		systemChat "";
	};
	sleep 1;
};
_testCnt = [_randomEnemySpawnPos, 500, 5] call RGGc_fnc_count_nearestBushes;
_2dSpawnPosX = [_randomEnemySpawnPos, 1000, 1] call RGGg_fnc_get_nearestBushes; 
_2dSpawnPos = _2dSpawnPosX select 0;
_opforGroup = createGroup [east, true];
_opforGroup setSpeedMode "full";
_opforTeam = []; 
_base = 10;
_random = random 10;
_size = _base + _random + patrolPointsTaken; 
_initMove = getMarkerPos "zone2";
for "_i" from 1 to _size do {
	_className = [2] call RGGg_fnc_get_randomOpforClassname; 
	_unit = _opforGroup createUnit [_className, _2dSpawnPos, [], 0.1, "none"];
	_unit doMove _initMove;
	_opforTeam pushBack _unit;
	bluforZeus addCuratorEditableObjects [[_unit], true];
	sleep 3;
	sleep (random 6);
};
[_opforTeam] execVM "eventHandlers\addMP_Killed_Eh.sqf";
_roam = true;
while {_roam} do {
	if (count (units _opforGroup) > 0) then { 
		_randomMovePos = [["zone2"]] call BIS_fnc_randomPos;
		_opforGroup move _randomMovePos;
		_opforGroup setSpeedMode "limited";
	} else {
		_roam = false;
	};
	sleep 180
};
