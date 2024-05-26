/*
Alpha 1 unitPlay MAIN FNC 
Updated: 13 Nov 2023 

Purpose: Manages the set up of the unitPlay system for Alpha 1 insertion on mission start 

Notes:
- this differs from the respawn as it is meant to house all players, and also deliver a second heli of ARVN units 
- need two iterations of the same path, one for players one for AI 
- runs in server nameSpace

- STILL BROKEN 
*/

//  params ["_players"]; // tried this, didn;t seem to work 

// heli setup and message 
_heli = [[15135,113.244,200], 180, "vn_b_air_uh1d_02_07", west] call BIS_fnc_spawnVehicle;
_heli1 = _heli select 0;
sleep 4;
["<t size='1' color='#ffffff' font='PuristaMedium' >OPERATION KILLCHAIN IS NOW LIVE</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", 0];
sleep 4;

// second heli setup 
_heli = [[15135,113.244,200], 180, "vn_b_air_uh1d_02_07", west] call BIS_fnc_spawnVehicle;
_heli2 = _heli select 0;

// run heli 1 path for players 
[_heli1] execVM "unitCapture\alpha1.sqf";

// move players into cargo 

// {
// 	_x moveInCargo _heli1;
// } forEach allPlayers; 
// private _getInFnc = {
//     params ["_unit", "_heli"];
// 	_unit moveInCargo _heli;
// };

_cattle = [];
{
	// if pos in PF 
	_cattle pushBack _x;
} forEach allPlayers;

{
	// [[_x, _heli1], _getInFnc] remoteExec ['bis_fnc_call', _x];  
	// [[_x, _heli1], _getInFnc] remoteExec ['bis_fnc_call', 0]; 
	// [[_x, _heli1], _getInFnc] remoteExec ['bis_fnc_call', 2]; 
	// [[_x, _heli1]] remoteExec ['moveInCargo', 2]; 
	_x moveInCargo _heli1;
	systemChat format ["moving %1 into %2", _x, _heli1];
} forEach _cattle;

// manage eject on landing - probably needs changing too once you work out why the above is broken 
[_heli1, allPlayers] spawn RGGe_fnc_effects_eject;

sleep 10; // safety gap 

// indifor taxi unboarding - seems to work fine 
[_heli2] execVM "unitCapture\alpha0.sqf";
_indiCargo = [];
for "_i" from 1 to 8 do {
	_indiGroup = createGroup [independent, true];
	_unit = _indiGroup createUnit [[1] call RGGg_fnc_get_randomIndiforClassname, [0,0,100], [], 0.1, "none"];
	_unit moveInCargo _heli2;
	_indiCargo pushBack _unit;
	bluforZeus addCuratorEditableObjects [[_unit], true];
};
[_heli2, _indiCargo] spawn RGGe_fnc_effects_eject;



