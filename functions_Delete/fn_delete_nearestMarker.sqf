/*
Delete Nearest Marker 
Updated: 7 May 2024 
Purpose: Deletes marker nearest to given position 
Author: Reggs 

Notes:
- Currently used as part of the ammo-cache destruction system, triggered by a player 
*/

params ["_target"];

_nrMkr = [allMapMarkers, (getPos _target)] call BIS_fnc_nearestPosition;
deleteMarker _nrMkr;