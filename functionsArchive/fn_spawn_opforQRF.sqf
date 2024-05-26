/*
spawn opforQRF FNC 
Updated: 22 Dec 2023 
Purpose: Spawns and sends in opfor units to try to re-take the point after ARVN have captured it. First wave is VC, second is NVA. 
Author: Reggs
*/

params ["_objPos"];

for "_i" from 1 to (patrolPointsTaken + 1) do {
	_randomEnemySpawnPos = [_objPos, 150, 200, 3, 0, 0, 0, ["spawnBlacklist"]] call BIS_fnc_findSafePos; 
	_2dSpawnPosX = [_randomEnemySpawnPos, 500, 15] call RGGg_fnc_get_nearestBushes; 
	_2dSpawnPos = _2dSpawnPosX select 0;
	_opforGroup = createGroup [east, true];
	_opforTeam = []; 
	{
		_unit = _opforGroup createUnit [[2] call RGGg_fnc_get_randomOpforClassname, _x, [], 0.1, "none"];
		_unit doMove _objPos;
		_opforTeam pushBack _unit;
		bluforZeus addCuratorEditableObjects [[_unit], true];
		sleep 0.1;	
	} forEach _2dSpawnPosX;
	[_opforGroup, _objPos] spawn RGGu_fnc_utilities_chkIfMoved;
	[_opforTeam] execVM "eventHandlers\addMP_Killed_Eh.sqf";
	sleep 30;
};

_check = true;
_iter = 0;
while {_check} do {
	_iter = _iter + 1;
	_data = [] call RGGg_fnc_get_RFCHECK;
	_redzoneOpfor = _data select 1; 
	if ((_redzoneOpfor < 20) or (_iter > 10)) then {
		_check = false;
	};
	sleep 10;
};

for "_i" from 1 to (patrolPointsTaken + 2) do {
	_NVASpawnPos = [_objPos, 200, 300, 3, 0, 0, 0, ["spawnBlacklist"]] call BIS_fnc_findSafePos; 
	_opforGroup = createGroup [east, true];	
	_opforTeam = []; 
	for "_i" from 1 to 15 do {
		_className = [1] call RGGg_fnc_get_randomOpforClassname;
		_unit = _opforGroup createUnit [_className, _NVASpawnPos, [], 0.1, "none"];
		_opforTeam pushBack _unit;
		bluforZeus addCuratorEditableObjects [[_unit], true];
		sleep 0.1;
		sleep (random 3);
	};
	_opforGroup setSpeedMode "full";
	_opforGroup setFormation "line";
	[_opforTeam] execVM "eventHandlers\addMP_Killed_Eh.sqf";
	[_opforGroup, _objPos] spawn RGGu_fnc_utilities_chkIfMoved;
	_opforGroup move _objPos;
	sleep 60;  
};
RGG_QRF = false; 

/*
Notes 
This needs improving 
Spawn in constant groups until a ceiling is reached 
If, say, spawn limit overall is 50 (and this can be affected by pp taken) 
Then, spawn in a group and have them attack, then watch the numbers, and when low enough, spawn in another batch 
so, spawn in units in groups of 20, but when group one gets to under 10, spawn in another 20 - hardcode this for three batches 
