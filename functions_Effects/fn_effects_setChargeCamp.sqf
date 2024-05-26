/*
Set Charge Camp FNC 
Updated: 15 Nov 2023 
Purpose: Initiates burn-down for an explosion - used for in-camp ammo caches 
Author: Reggs 
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

sleep 3;

private _ps2 = "#particlesource" createVehicleLocal _pos;
_ps2 setParticleParams [
	["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 7, 1, 1], "", "Billboard",
	1, 5, [0, 0, 1], [0, 0, 1.5], 0, 1, 1, 0.5, [1.75,2,3,4.5], 
	[[1,1,1,0], [1,1,1,0.5], [1,1,1,0.4], [1,1,1,0.2], [1,1,1,0]],
	[0.5,0.5], 0, 0, "", "", _ps2];
_ps2 setParticleRandom [0.5, [1, 1, 0.4], [0, 0, 0.5], 0, 0.125, [0, 0, 0, 0], rad 30, 0];
_ps2 setDropInterval 0.1;

sleep 10;
sleep (random 5);

_exp = "ammo_Bomb_SDB" createVehicle _pos;
deleteVehicle _target;
deleteVehicle _ps1;
deleteVehicle _ps2;
