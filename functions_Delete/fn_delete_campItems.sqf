/*
Delete Camp Items FNC 
Updated: 27 Nov 2023 
Purpose: This will manage deletion of camp items and allDead when no players are near
Author: Reggs 
*/

params ["_anchor"]; 

_campItems = [];  
_RGG_AmmoCache = []; 
{
	_campItems pushBack _x;
} forEach RGG_CampItems;
{
	_RGG_AmmoCache pushBack _x;
} forEach RGG_AmmoCache;
RGG_CampItems = [];  
RGG_AmmoCache = []; 
_playersAreNear = true;
while {_playersAreNear} do {
	_dataStore = [];
	{
		_playerPos = getPos _x;
		_dist = _anchor distance _playerPos;
		if (_dist < 300) then {
			_dataStore pushback _x;
		}; 
	} forEach ([] call RGGg_fnc_get_allPlayersOnGround); 

	if ((count _dataStore) == 0) then {
		_playersAreNear = false;
		{ deleteVehicle _x } forEach _RGG_AmmoCache;
		{ deleteVehicle _x } forEach _campItems;
		{ deleteVehicle _x } forEach allDead;
	};
	sleep 60; 
};
