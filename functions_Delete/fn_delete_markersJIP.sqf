/*
Delete Markers JIP 
Updated: 02 Oct 2023 
Purpose: This deletes all unused and irrelevant map markers for a JIP player
Author: Reggs 
*/

sleep 10;
_route = RGG_Route;
_rStr = str _route; 
_knownRoutes = ["kcRoute"] call BIS_fnc_getMarkers; 
_chosenRoute = [0,0]; 
{
	_num = _x select [7,1];  
	if (_rStr isNotEqualTo _num) then {
		deleteMarker _x; 
	} else {
		_x setMarkerColor "ColorBlue";
		_x setMarkerAlpha 0.3;
		_chosenRoute = _x;
	};
} forEach _knownRoutes;  
_allRouteIcons = ["Patrol "] call BIS_fnc_getMarkers;  
{
	_num = _x select [7,1]; 
	deleteMarker _x; 
} forEach _allRouteIcons; 
_allLZIcons = ["LZ "] call BIS_fnc_getMarkers;  
RGG_triggerLZ = [];  
{
	_num = _x select [3,1];  
	if (_rStr isNotEqualTo _num) then {
		deleteMarker _x;  
	} else {
		RGG_triggerLZ pushBack _x;
	};
} forEach _allLZIcons;  
publicVariableServer "RGG_triggerLZ"; 
_objMarkers = [];  
{
	_hook = _x select [2,3]; 
	if (_hook == "OBJ") then {
		_objMarkers pushBack _x;
	};
} forEach allMapMarkers;
RGG_PatrolPoints = [];
{
	_num = _x select [1,1]; 
	if (_rStr isNotEqualTo _num) then {
		deleteMarker _x; 
	} else {
		RGG_PatrolPoints pushBack (getMarkerPos _x);
	};
} forEach _objMarkers;
_lzMarkers = [];
{
	_hook = _x select [0,2]; 
	if (_hook == "LZ") then {
		_lzMarkers pushBack _x;
	};
} forEach allMapMarkers;
_anchor = getMarkerPos _chosenRoute; 
{
	_pos = getMarkerPos _x; 
	_dist = _anchor distance2D _pos;
		if (_dist > 3000) then {
		deleteMarker _x;
	};
	sleep 0.2;
} forEach _lzMarkers;

