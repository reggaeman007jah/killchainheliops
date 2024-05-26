/*
spawn_ord FNC 
Updated: 17 Dec 23 
Purpose: Spawns in explosions 
Author: Reggs 
*/

params ["_pos", "_type", "_delay"];

sleep _delay;
_type createVehicle _pos;
[_pos, 40] call RGGe_fnc_effects_bombBlast;