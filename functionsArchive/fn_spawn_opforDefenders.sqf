/*
spawn_opforDefenders FNC 
Updated: 03 Nov 2023
Purpose: Creates opfor base-camp defenders 
Author: Reggs 
*/

params ["_objPos"]; 

_chk = true;
while {_chk} do {	
	_units = allUnits inAreaArray "zone3";
	{
		if (((side _x == west) or (side _x == independent)) && (((getPos _x) select 2) < 2)) exitWith {
			_chk = false;
		}
		
	} forEach _units;
	sleep 10;
};
_grp = createGroup [east, true];
_ehUnits = []; 
for "_i" from 1 to ((selectRandom [10]) + 10) do {
	_rndtype = [1] call RGGg_fnc_get_randomOpforClassname; // NVA
	_pos = [_objPos, 0, 40] call BIS_fnc_findSafePos;
	_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
	_unit addMPEventHandler ["MPKilled", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		if (RGG_indiRF) then {
			if (isPlayer _killer) then {
				RGG_bluforKills = RGG_bluforKills + 1;
				publicVariable "RGG_bluforKills";
			} else {
				RGG_indiforKills = RGG_indiforKills + 1;
				publicVariable "RGG_indiforKills";
				RGG_availableIndifor = RGG_availableIndifor + 1;
				publicVariable "RGG_availableIndifor";
			};				
		} else {
			if (isPlayer _killer) then {
				RGG_bluforKills = RGG_bluforKills + 1;
				publicVariable "RGG_bluforKills";
				RGG_availableIndifor = RGG_availableIndifor + 1;
				publicVariable "RGG_availableIndifor";
				profileNamespace setVariable ["RGG_availableIndifor", RGG_availableIndifor];
			} else {
				RGG_indiforKills = RGG_indiforKills + 1;
				publicVariable "RGG_indiforKills";
			};				
		};
	}];
	bluforZeus addCuratorEditableObjects [[_unit], true];
	_randomDir = selectRandom [270, 290, 01, 30, 90];
	_randomDist = selectRandom [5, 25, 50, 75]; 
	_endPoint = _objPos getPos [_randomDist, _randomDir];
	_unit setBehaviour "COMBAT";
	_unit doMove _endPoint;
 	sleep 0.2;									
};

for "_i" from 1 to 2 do {
	systemChat "this?? what is this?";
	_pos = [_objPos, 0, 40] call BIS_fnc_findSafePos;
	_unit = _grp createUnit ["vn_o_men_nva_13", _pos, [], 30, "none"]; 
	_unit addMPEventHandler ["MPKilled", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		if (RGG_indiRF) then {
			if (isPlayer _killer) then {
				RGG_bluforKills = RGG_bluforKills + 1;
				publicVariable "RGG_bluforKills";
			} else {
				RGG_indiforKills = RGG_indiforKills + 1;
				publicVariable "RGG_indiforKills";
				RGG_availableIndifor = RGG_availableIndifor + 1;
				publicVariable "RGG_availableIndifor";
			};				
		} else {
			if (isPlayer _killer) then {
				RGG_bluforKills = RGG_bluforKills + 1;
				publicVariable "RGG_bluforKills";
				RGG_availableIndifor = RGG_availableIndifor + 1;
				publicVariable "RGG_availableIndifor";
			} else {
				RGG_indiforKills = RGG_indiforKills + 1;
				publicVariable "RGG_indiforKills";
			};				
		};
	}];
	bluforZeus addCuratorEditableObjects [[_unit], true];
	_randomDir = selectRandom [270, 290, 01, 30, 90];
	_randomDist = selectRandom [5, 25, 50, 75]; 
	_endPoint = _objPos getPos [_randomDist, _randomDir];
	_unit setBehaviour "COMBAT";
	_unit doMove _endPoint;
 	sleep 1;									
};
