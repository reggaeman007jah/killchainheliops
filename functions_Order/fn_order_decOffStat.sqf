/*
Declare On Station FNC 
Purpose: When run, it informs KC Command that the given heli is standing down, and not open for tasking 
Updated: 31 May 24
Author: Reggs 

Notes:
This should also close down the mission time clock for the DB, and send update 
*/

params ["_player"];

_heli = vehicle _player;
if !(isNull objectParent _player) then {
	systemChat format ["%1 Standing Down", _heli];
};