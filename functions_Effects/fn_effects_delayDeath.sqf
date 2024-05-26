/*
Delay Death FNC 
Updated: 17 Dec 23 
Purpose: Takes a unit and kills them within a given time range 
Author: Reggs 
*/

params ["_unit", "_wait"];

sleep _wait;
_unit setDamage 1;