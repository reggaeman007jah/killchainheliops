/*
spawn_opforWelcomParty FNC 
Updated: 30 Oct 2023 
Purpose: TBC 
Author: Reggs 
*/

params ["_initStartPos", "_objPos"];

_diffLevel = 2; 
_ehUnits = [];
for "_i" from 1 to _diffLevel do {
	_grp = createGroup [east, true];
	_rndOp1 = selectRandom [5, 10, 15];
	for "_i" from 1 to _rndOp1 do {
		_pos = [_objPos, 0, 30] call BIS_fnc_findSafePos; 
		_rndtype = [1] call RGGg_fnc_get_randomOpforClassname; 
		_unit = _grp createUnit [_rndtype, _pos, [], 1, "none"]; 
		_ehUnits pushBack _unit;
		_unit setBehaviour "COMBAT";
		_unit doMove _initStartPos; 
		bluforZeus addCuratorEditableObjects [[_unit], true];	
		sleep 2;						
	};
	sleep 60;
};
[_ehUnits] execVM "eventHandlers\addMP_Killed_EH.sqf";
