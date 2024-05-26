/*
effects_bleedOut FNC 
Updated: 01 Jan 24 
Purpose: Will bleed out a unit's health over time intervals 
Author: Reggs 
*/

params ["_unit","_freq","_amt"];

while {alive _unit} do {
	_health = damage _unit; 
	_newHealth = _health + _amt;
	_unit setDamage _newHealth;
	_reducedHealth = damage _unit; 
	sleep _freq;
	
	if (!alive _unit) then {
		_mkr = str _unit;
		deleteMarker _mkr;
	};
};
