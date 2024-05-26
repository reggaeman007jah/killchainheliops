/*
Set Captive Area FNC 
Purpose: takes a position and radius, and makes applies T or F to setCaptive for all inside 
Updated: 25 May 24 
Author: Reggs 

_anchor: position anchor 
_radius: how far out the effect should apply (to all units inside)
_setCap: Boolean, true makes all inside setCaptive, False removes and makes them fight 
*/

params ["_anchor", "_radius", "_setCap"];

_setCap = createMarker [(str _anchor), _anchor];
_setCap setMarkerShape "ELLIPSE";
_setCap setMarkerSize [_radius, _radius];

_affected = allUnits inAreaArray _setCap;

{
	_x setCaptive _setCap;
} forEach _affected;

deleteMarker _setCap;