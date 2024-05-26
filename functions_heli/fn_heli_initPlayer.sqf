/*
Init Player Heli FNC 
Updated: 15 Nov 2023 

Purpose: brings in joining players to base via heli 

Notes:
- instantiated from initPlayerLocal.sqf .. ie in player's nameSpace

*/

params ["_player"];

// debug 
systemChat "running init player heli";
systemChat format ["_player inbound: %1", _player];
systemChat format ["RGG_initHeliRunning: %1", RGG_initHeliRunning];

// safety checks 
_chk = true;
while {_chk} do {
	if (RGG_initHeliRunning == false) exitWith {};
	sleep 1;
	systemChat "checking";
};

// create crewed heli with engine already on 
_heli = [[15135,113.244,200], 180, "vn_b_air_oh6a_01", west] call BIS_fnc_spawnVehicle;
_heli1 = _heli select 0;
_heli1 allowDamage false;

// initiate flight path 
[_heli1] execVM "unitCapture\initPlayerLanding.sqf";

// add the player in cargo 
systemChat "moving player into heli here";
// [_player, _heli1] remoteExec ["moveInCargo", _player];
_player moveInCargo _heli1;

cutText ["", "BLACK IN", 1];

sleep 4;
[[
	["Incoming Telex", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
	["Welcome to Operation Killchain:", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
	["You are en-route to FOB Pathfinder", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
	["Prepare your patrol loadout and get ready for deployment", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
	["Telex End", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>", 30]
]] remoteExec ["BIS_fnc_typeText", 0]; 

// eject player once they land 
[_heli1, [_player]] spawn RGGe_fnc_effects_eject;

RGG_initHeliRunning = true;
publicVariable "RGG_initHeliRunning";
sleep 10;
RGG_initHeliRunning = false;
publicVariable "RGG_initHeliRunning";