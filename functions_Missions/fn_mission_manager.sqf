/*
Mission Manager FNC 
Purpose: Will act as the tasking system for the server - triggers on completion of any given mission, and randomly selects another 
Updated: 03 June 24 
Author: Reggs 

Notes 
This is called from an init.sqf CBA keybind and hopefully is able to relay the raptor name, so enable raptor-heli-specific audio (rap 1 rap 2 etc)
There will be five regions A B C D E, each with 9 LZ locations A1, A2 etc 
*/

params ["_heli"];
// if this works, we can dectate specific missions based on the heli type passed - slick, gun, scout etc 

// _patrol = selectRandom ["a", "b", "c", "d", "e"];
_patrol = selectRandom ["a"]; // testing only 
_patrolLz = selectRandom ["1","2","3","4","5","6","7","8","9"];

// _lzRef = selectRandom [1,2,3,4,5,6,7,8,9,10];
_lzRef = ("lz" + _patrol + _patrolLz);

sleep 5;

_target = getMarkerPos _lzRef;

// RGG_currentObjR3 = _target;

_testHeli = str _heli;

switch (_testHeli) do {
	case "raptor1": { RGG_currentObjR1 = _target; publicVariable "RGG_currentObjR1"; };
	case "raptor2": { RGG_currentObjR2 = _target; publicVariable "RGG_currentObjR2"; };
	case "raptor3": { RGG_currentObjR3 = _target; publicVariable "RGG_currentObjR3"; };
	case "raptor4": { RGG_currentObjR4 = _target; publicVariable "RGG_currentObjR4"; };
	case "raptor5": { RGG_currentObjR5 = _target; publicVariable "RGG_currentObjR5"; };
	case "raptor6": { RGG_currentObjR6 = _target; publicVariable "RGG_currentObjR6"; };
	default { systemChat "switch error mission_manager obj"};
};

systemChat format ["DelWhenDone: _target: %1", _target];
// publicVariableServer "RGG_currentObjR1";
// publicVariableServer "RGG_currentObjR2";
// publicVariableServer "RGG_currentObjR3";
// publicVariableServer "RGG_currentObjR4";
// publicVariableServer "RGG_currentObjR5";
// publicVariableServer "RGG_currentObjR6";
// systemChat format ["DelWhenDone: RGG_currentObjR1: %1", RGG_currentObjR1];
// systemChat format ["DelWhenDone: RGG_currentObjR2: %1", RGG_currentObjR2];
// systemChat format ["DelWhenDone: RGG_currentObjR3: %1", RGG_currentObjR3];
// systemChat format ["DelWhenDone: RGG_currentObjR4: %1", RGG_currentObjR4];
// systemChat format ["DelWhenDone: RGG_currentObjR5: %1", RGG_currentObjR5];
// systemChat format ["DelWhenDone: RGG_currentObjR6: %1", RGG_currentObjR6];

_missionType = selectRandom ["MEDIVAC"]; // make more here 
[_target, 3000, _lzRef, _missionType, _heli] spawn RGGm_fnc_mission_extractInjured; // only mission we have rn 

