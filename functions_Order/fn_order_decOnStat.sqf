/*
Declare On Station FNC 
Purpose: When run, it informs KC Command that the given heli is open for tasking 
Updated: 31 May 24
Author: Reggs 

Notes:
This should also kick off the mission time clock for the DB 
// systemChat format ["Hello %1", _player];
// test - can we derive the player's heli from the player themelves? this is being triggered from init.sqf, so can I use 'player' here reliably? 

*/


params ["_player"];

_heli = vehicle _player;
if !(isNull objectParent _player) then {
	systemChat format ["%1 Ready for tasking", _heli];
	[_heli] spawn RGGm_fnc_mission_manager;
} else {
	systemChat "you should get in a heli..";
};