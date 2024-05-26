/*
Delay Blast FNC 
Updated: 07 May 2024
Purpose: Manages a delayed explosion and destroyes passed object  
Author: Reggs 

Params:
	Delay to detonate eg: 10
	Object to destroy 
	Explosion type to use eg: "ammo_Bomb_SDB"
*/

params ["_delay", "_target", "_ord"];

sleep _delay;
_pos = getPos _target;
_exp = _ord createVehicle _pos;

// format ["Sleeping for %1 seconds", _delay] remoteExec ["systemChat", 0]; 
// format ["Deleting %1 at pos: %2", _target, _pos] remoteExec ["systemChat", 0]; 


// _boom = [
// 	"ammo_Bomb_SDB",
// 	"BombCluster_02_Ammo_F",
// 	"ammo_Missile_HARM",
// 	"R_80mm_HE"
// ];

// _exp = "ammo_Bomb_SDB" createVehicle _pos;
// deleteVehicle _target;

