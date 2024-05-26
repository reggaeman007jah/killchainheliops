/*
Mission Manager FNC 
Purpose: Will act as the tasking system for the server - triggers on completion of any given mission, and randomly selects another 
Updated: 26 May 24 
Author: Reggs 
*/

_lzRef = selectRandom [1,2,3,4,5,6,7,8,9,10];
_lzRefStr = str _lzRef;
_marker = "lz" + _lzRefStr;
_target = getMarkerPos _marker;

RGG_currentObj = _target;

_missionType = selectRandom ["MEDIVAC"];
_currentHeat = selectRandom ["COLD"];
[_target, 3000, _lzRefStr, _missionType, _currentHeat] spawn RGGm_fnc_mission_extractInjured; // only mission we have rn 


