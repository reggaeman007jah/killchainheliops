/*
Get All Helis FNC 
Updated: 04 Nov 2023 

Purpose: Gathers all helis in the mission and returns them in an array 

Notes:
- Used to apply or remove EHs en-mass 
*/

_helis = [];
{
	if (_x isKindOf "helicopter") then {
		_helis pushBack _x;
	};
} forEach vehicles;
_helis