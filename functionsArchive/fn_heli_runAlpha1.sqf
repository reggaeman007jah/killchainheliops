/*
Alpha 1 unitPlay FNC 
Updated: 13 Nov 2023 

Purpose: manages the set up of the unitPlay system for Alpha 1 insertion 

Notes:
- this currently triggers from each player's onPlayerRespawn instruction
- as such, I assume this is all run on the players nameSpace 
- we can improve this - switches will enable multi-paths to be done from here 


*/

params ["_player"];

// create crewed heli with engine already on 
_heli = [[15135,113.244,200], 180, "vn_b_air_uh1d_02_07", west] call BIS_fnc_spawnVehicle;
_heli1 = _heli select 0;
_heli1 allowDamage false;

// initiate flight path 
[_heli1] execVM "unitCapture\alpha1.sqf";

// add the player in cargo 
_player moveInCargo _heli1;

// cutText ["", "BLACK IN", 1]; 

// eject player once they land 
[_heli1, [_player]] spawn RGGe_fnc_effects_eject;

