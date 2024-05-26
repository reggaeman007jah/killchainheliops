/*
Set Charge FNC 
Updated: 07 May 2024  
Purpose: Initiates burn-down for an explosion 
Author: Reggs 

Notes: 
- Runs on each client 
*/

params ["_chargeSetter", "_target"];

_pos = getPos _target;

private _ps1 = "#particlesource" createVehicleLocal _pos;
_ps1 setParticleParams [
	["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 10, 32], "", "Billboard",
	1, 1, [0, 0, 0], [0, 0, 0.5], 0, 1, 1, 3, [0.5,1.5],
	[[1,1,1,0.4], [1,1,1,0.2], [1,1,1,0]],
	[0.25,1], 1, 1, "", "", _ps1];
_ps1 setParticleRandom [0.2, [0.5, 0.5, 0.25], [0.125, 0.125, 0.125], 0.2, 0.2, [0, 0, 0, 0], 0, 0];
_ps1 setDropInterval 0.05;

sleep 5;

private _ps2 = "#particlesource" createVehicleLocal _pos;
_ps2 setParticleParams [
	["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 7, 1, 1], "", "Billboard",
	1, 5, [0, 0, 1], [0, 0, 1.5], 0, 1, 1, 0.5, [1.75,2,3,4.5], // timerPeriod → size
	[[1,1,1,0], [1,1,1,0.5], [1,1,1,0.4], [1,1,1,0.2], [1,1,1,0]],
	[0.5,0.5], 0, 0, "", "", _ps2];
_ps2 setParticleRandom [0.5, [1, 1, 0.4], [0, 0, 0.5], 0, 0.125, [0, 0, 0, 0], rad 30, 0];
_ps2 setDropInterval 0.1;

sleep 12;

// _boom = [
// 	"ammo_Bomb_SDB",
// 	"BombCluster_02_Ammo_F",
// 	"ammo_Missile_HARM",
// 	"R_80mm_HE"
// ];

// _exp = "ammo_Bomb_SDB" createVehicle _pos;
// deleteVehicle _target;
deleteVehicle _ps1;
deleteVehicle _ps2;

_surround = [
	"Land_vn_vineyardfence_01_f",
	"Land_vn_o_shelter_01",
	"Land_vn_sacks_goods_f",
	"Land_vn_stand_meat_ep1",
	"Land_vn_woodencrate_01_stack_x5_f",
	"Land_vn_woodencrate_01_f"
];
_destroy = nearestObjects [_pos, _surround, 30];
{
	deleteVehicle _x;
} forEach _destroy;

// _nrMkr = [allMapMarkers, _pos] call BIS_fnc_nearestPosition;
// deleteMarker _nrMkr;



