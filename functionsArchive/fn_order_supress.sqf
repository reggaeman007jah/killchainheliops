/*
Orders a group to supress a position 
*/

params ["_chosenGroup", "_supPos", "_time"];

systemChat format ["group: %1 / pos: %2 / time: %3", _chosenGroup, _supPos, _time];


_latData = _supPos select 0;
_lonData = _supPos select 1;
_group = _chosenGroup select 0;

_lat = format ["%1%2%3%4%5", (_latData select 0), (_latData select 1), (_latData select 2), (_latData select 3), (_latData select 4)]; 
_lon = format ["%1%2%3%4%5", (_lonData select 0), (_lonData select 1), (_lonData select 2), (_lonData select 3), (_lonData select 4)]; 

_supressionPos = [];
_parsedLat = parseNumber _lat;
_parsedLon = parseNumber _lon;

_supressionPos pushBack _parsedLat;
_supressionPos pushBack _parsedLon;

systemChat format ["Group: %1 is planning to suppress position %2 for %3 seconds", _group, _supressionPos, _time];

_opforVic = [[0,0], 180, "O_Quadbike_01_F", east] call BIS_fnc_spawnVehicle;
_vic = _opforVic select 0; 
_vic allowDamage false;
_vic setFuel 0;
_crew = _opforVic select 1; 
_crewMan = _crew select 0;
_crewMan allowDamage false;

removeAllWeapons _crewMan;

hideObject _vic;
hideObject _crewMan;
_vic setPos _supressionPos;
_crewMan setPos _supressionPos;

{
	_handle = _x fireAtTarget [_crewMan];
} forEach units _group;

sleep _time;

deleteVehicle _vic;
deleteVehicle _crewMan;