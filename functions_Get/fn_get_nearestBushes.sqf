/*
Get Nearest Bushes FNC 
Updated: 30 Oct 2023 

Purpose: 
Returns (nearest) 2D positions of elephant grass from given location, within a given distance, used for spawning without breaking immersion
Number of results is set by _results param  
Takes an anchor point and distance limiter 

Takes:
- _anchor / core position to calculate from 
- _radius / radius os search area 
- _results / a limiter, safety valve for performance reasons, breaks out when you have what you need 

Action:
Expand to other classnames, of other relevant trees and bushes e.g. Land_vn_b_arundod3s_f
*/

params ["_anchor", "_radius", "_results"];

_data = nearestTerrainObjects [_anchor, [], _radius, true]; // true here means it is sorted by distance in the results 

_grass = [];
_count = 0;
{
    
	if ("vn_elephant_grass_01" in str _x) then {
		_count = _count + 1;
		_pos = getPos _x;
		_grass pushBack _pos;
    };

	if (_count == _results) exitwith {
		systemChat "breaking out - got enough data";
	};
} forEach _data;

systemChat format ["Grass Results: %1", _grass];

// now convert to 2D 
_data = [];
{
	_xPos = _x select 0;
	_yPos = _x select 1;
	_2dSpawnPos = [_xPos, _yPos];
	_data pushBack _2dSpawnPos;
} forEach _grass;

_data



