/*
Smoke / Fire FNC 
Updated: 17 Dec 23 
Purpose: creates smoke and fire - used after bomb runs  
Author: Reggs 
*/

params ["_pos"];

private _ps1 = "#particlesource" createVehicle _pos;
_ps1 setParticleParams [
	["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 10, 32], "", "Billboard",
	1, 1, [0, 0, 0], [0, 0, 0.5], 0, 1, 1, 3, [0.5,1.5],
	[[1,1,1,0.4], [1,1,1,0.2], [1,1,1,0]],
	[0.25,1], 1, 1, "", "", _ps1];
_ps1 setParticleRandom [0.2, [0.5, 0.5, 0.25], [0.125, 0.125, 0.125], 0.2, 0.2, [0, 0, 0, 0], 0, 0];
_ps1 setDropInterval 0.05;

private _ps2 = "#particlesource" createVehicle _pos;
_ps2 setParticleParams [
	["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 7, 1, 1], "", "Billboard",
	1, (2 + (random 12)), [0, 0, 1], [0, 0, 0.1], 0, 1, 1, 0.5, [1.75,2,3,4.5], 
	[[1,1,1,0], [1,1,1,0.5], [1,1,1,0.4], [1,1,1,0.2], [1,1,1,0]],
	[0.5,0.5], 0, 0, "", "", _ps2];
_ps2 setParticleRandom [0.5, [1, 1, 0.2], [0, 1, 0.2], 0, 0.125, [0, 0, 0, 0], rad 30, 0];
_ps2 setDropInterval 0.1;

sleep 10;
sleep random 80;
deleteVehicle _ps1;
sleep 2;
sleep random 10;
deleteVehicle _ps2;
