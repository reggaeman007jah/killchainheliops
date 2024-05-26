/*
spawn_opforHKOneShot FNC 
Updated: 03 November 2023 
Purpose: TBC 
Author: Reggs 
*/

params ["_pos"];

_delay = selectRandom [60,120,180,240,300];
sleep _delay; 
_specOps = [];
for "_i" from 0 to 3 do {
	_className = [2] call RGGg_fnc_get_randomOpforClassname; 
	_specOps pushBack _className;
};
_dataStore = [];
{
	_playerPos = getPos _x;

	if ((_playerPos select 2) < 2) then {
		_dataStore pushback _x;
	};
} forEach allPlayers;
_dataStore2 = [];
{
	_dist = ammo1 distance _x;
	if (_dist > 1000) then {
		_dataStore2 pushback _x;
	};
} forEach _dataStore;

if ((count _dataStore2) > 0) then {
	_ranTarget = selectRandom _dataStore2;
	_targetPos = getPos _ranTarget;
	_spawnAnchor = _targetPos getPos [50, (random 359)];
	_spawnPos = [_spawnAnchor, 1000, 1] call RGGg_fnc_get_nearestBushes; 
	_opGroup = createGroup [east, true];
	_opGroup setSpeedMode "limited";
	_opforTeam = [];
	{
		_unit = _opGroup createUnit [_x, _spawnPos, [], 0.1, "none"]; 
		_unit setCombatMode "GREEN";
		bluforZeus addCuratorEditableObjects [[_unit], true];
		_target = getPos _ranTarget;
		_unit doMove _target;
		_opforTeam pushBack _unit;
		sleep 5;
	} forEach _specOps;
	[_opforTeam] execVM "eventHandlers\addMP_Killed_Eh.sqf";
	_hunt = true;
	while {_hunt} do {
		_target = getPos _ranTarget;
		_opGroup move _target;
		if (count (units _opGroup) < 1) then { 
			_hunt = false;
		};
		sleep 30;
	};

};

