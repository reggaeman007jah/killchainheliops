/*
Get All Players On Ground FNC 
Updated: 13 Nov 2023

Purpose: This will return all players deemed to be on the ground 
*/

_data = [];
{
	_pos = getPos _x;
	_alt = _pos select 2;
	if (_alt < 2) then {
		_data pushBack _x;
	};
} forEach allPlayers;
_data;