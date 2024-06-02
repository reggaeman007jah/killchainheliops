/*
Mission Manager FNC 
Purpose: Will act as the tasking system for the server - triggers on completion of any given mission, and randomly selects another 
Updated: 26 May 24 
Author: Reggs 

notes: this is called from an init.sqf CBA keybind and hopefully is able to relay the raptor name, so enable raptor-heli-specific audio (rap 1 rap 2 etc)
*/

params ["_heli"];
// if this works, we can dectate specific missions based on the heli type passed - slick, gun, scout etc 

// _patrol = selectRandom ["a", "b", "c", "d", "e"];
_patrol = selectRandom ["a"];
_patrolLz = selectRandom ["1","2","3","4","5","6","7","8","9"];




// _lzRef = selectRandom [1,2,3,4,5,6,7,8,9,10];
_lzRef = ("lz" + _patrol + _patrolLz);
// _lzRefStr = str _lzRef;
systemChat format ["_lzRef: %1", _lzRef];

sleep 5;



// _marker = "lz" + _lzRefStr;
// _marker = "lz" + _patrol + Lz;
_target = getMarkerPos _lzRef;

RGG_currentObj = _target;

_missionType = selectRandom ["MEDIVAC"]; // make more here 
// systemChat "sending the following to RGGm_fnc_mission_extractInjured:";
// systemChat format ["%1 %2 %3 %4 %5", _target, 3000, _lzRef, _missionType, _heli];
[_target, 3000, _lzRef, _missionType, _heli] spawn RGGm_fnc_mission_extractInjured; // only mission we have rn 

