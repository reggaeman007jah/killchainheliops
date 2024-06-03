/*
get_allPlrsInHeli FNC 
Purpose: Returns an array of all players that are currently in the given heli, so common audio effects can be heard 'over the net' 
Updated: 03 June 24 
Author: Reggs 

Returns: An array of players in the given heli 

Note:
FNC is called 'heli' but actually applies to all vic types 
*/

params ["_heli"];

_data = [];
{
	if !(isNull objectParent _x) then {
		if vehicle _x == _heli then {
			_data pushBack _x;	
		}
	};
} forEach allPlayers;
_data;