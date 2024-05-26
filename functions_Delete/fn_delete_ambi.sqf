/*
This deletes ambient units of INDI class wandering around at the main base 
*/

params ["_pos", "_rad"];

_stampToString = str _pos;
_objective1 = createMarker ["_stampToString", _pos];
_objective1 setMarkerShape "ELLIPSE";
_objective1 setMarkerColor "ColorRed";
_objective1 setMarkerSize [10, 10];
_objective1 setMarkerAlpha 0.2;
_toProcess = allUnits inAreaArray "_stampToString";
{
	if ((side _x) == INDEPENDENT) then {
		deleteVehicle _x;
	};
} forEach _toProcess;

deleteMarker "_stampToString"; 