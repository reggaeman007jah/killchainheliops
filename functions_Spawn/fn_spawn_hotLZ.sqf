/*
Hot LZ FNC 
Purpose: Spawns in opfor when helis are on approach to a designated LZ 
Updated: 25 May 24  
Author: Reggs 

_anchor: central point of activity for FNC 
_minEnemy: min amount 
_maxEnemy: max amount spawned 
_minDist: closest they could be 
_maxDist: furthest away they could be 
_playerProxTrig: how close players needd to be before they become a threat 
_moveIn: boolean, if true they move into the anchor point on activation 
_grouped: true or false - if true they will be grouped closeby as a unit, if false they are randomly surrounding the point - not used currently default is to surround 
*/

params ["_anchor", "_minEnemy", "_maxEnemy", "_minDist", "_maxDist", "_playerProxTrig", "_grouped"];

_opfor = [];
_gunners = ["vn_o_men_vc_local_11", "vn_o_men_vc_local_25", "vn_o_men_vc_local_32"]; // make better 
for "_i" from _minEnemy to _maxEnemy do {
	_grp = createGroup [east, true];
	_pos = [_anchor, _minDist, _maxDist, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	_unit = _grp createUnit [(selectRandom _gunners), _pos, [], 0.1, "none"];
	_unit setCaptive true;
	_unit setUnitPos "DOWN";
	// _unit disableAI "MOVE";
	// bluforZeus addCuratorEditableObjects [[_unit], true];
	_opfor pushBack _unit;
	sleep 0.1;
};

_it = 0;
_checkCycle = true;
while {_checkCycle} do {	

	_it = _it + 1;
	{
		if ((_anchor distance (getPos _x)) < _playerProxTrig) exitWith {
			_checkCycle = false;
		};
		sleep 0.5;
	} forEach allPlayers; 

	if (_it == 30) then {
		_checkCycle = false;
	};
	sleep 10;
}; 

{
	_x setCaptive false;;
} forEach _opfor;

if (_moveIn) then {
	
};



{
	_dir = _x getDir _anchor;
	_x setDir _dir;
} forEach _opfor;
{
	_x allowDamage false;
} forEach _allUnits;
_chance = selectRandom [1];
if (_chance == 1) then {

	for "_i" from 1 to (selectRandom [10,11,12,13,14]) do {
		_grp = createGroup [civilian, true];
		_unit = _grp createUnit [ [] call RGGg_fnc_get_randomCivClass, [["zone1"]] call BIS_fnc_randomPos, [], 0.1, "none"];
		_unit setDir (random 359);
		_unit setUnitPos "MIDDLE";
		_unit disableAI "MOVE";
		bluforZeus addCuratorEditableObjects [[_unit], true];
		_allUnits pushBack _unit;
		_opfor pushBack _unit;
		sleep 0.1;
	};
};
_randomMovePos = [["zone1"]] call BIS_fnc_randomPos;
sleep 20; 
{
	_x allowDamage true;
} forEach _allUnits;
sleep 60;
[_allUnits, _anchor, 300, 10] spawn RGGd_fnc_delete_whenNoPlayers;
