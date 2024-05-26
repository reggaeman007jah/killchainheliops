/*
Heli - Respawn Player FNC 
Updated: 16 Nov 2023

Purpose: Takes respwning players back to the AO, or back to base if no mission running 

Notes:
- these respawn flightpaths will be hardcoded, so we must be sure we like the patrol route before comitting to a flightpath 
- redundant paths could be used for other things perhaps? Side missions of random insertion patrols outside of KC?

Logic:
Alpha has 2 points / 3 insertion paths needed 
if points taken is 0, then insertion path LZ is used 
if points taken is 0, but they have control of the redzone, then insertion is obj 1 
if points tekan is 1 and they dont have control of obj2 then inertion is obj1 
If points taken is 1 but they have control of the redzone, then insertion is obj 2

Snippets:
cutText ["LOOKING FOR A HELI TO TAKE YOU BACK INTO THE AO", "BLACK IN", 10];

Actions:
- randomise classname of heli 
- do better base respawn path 
*/

params ["_player"];

// cutText [
// 	"SEACHING FOR A HELI - STAND BY",
// 	"BLACK",
// 	10
// ];
cutText ["", "BLACK IN", 1];

_chk = true;
while {_chk} do {
	if (RGG_heliRunning == false) exitWith {};
	sleep 1;
	systemChat "checking";
};

// [1, "BLACK", 3, 1] spawn BIS_fnc_fadeEffect; // fade-out to black 

// create crewed heli with engine already on 
_heliX = [[15135,113.244,200], 180, "vn_b_air_uh1d_02_07", west] call BIS_fnc_spawnVehicle;
_heli = _heliX select 0;
_heli allowDamage false;

// initiate flight path 
/*
As we are respawning, we need to know firstly whetehr to respawn at PF, in in-field 
And, if in-field, where 
*/
if (KILLCHAINMISSIONSTART) then {

	// // _calcBestPlace = {
	// 	// RGG_PatrolPoints
	// 	// patrolPointsTaken
	// // };

	switch (RGG_Route) do {
		case 1: {
			// Alpha 
			switch (patrolPointsTaken) do {
				// initial LZ 
				case 0: {
					// systemChat "switching Alpha Route,7
					if (RFCHECK == true) then {
						[_heli] execVM "unitCapture\alpha0.sqf"; // attacking point 1 - LZ is base 
					};
					if (RFCHECK2 == true) then {
						[_heli] execVM "unitCapture\alpha1.sqf"; // defending point 1 - point 1 is base
					};
				}; 
				// Point 1 Taken ^^
				case 1: { 
					if (RFCHECK) then {
						[_heli] execVM "unitCapture\alpha1.sqf"; // attacking point 2 - point 1 is base 
					};
					if (RFCHECK2 == true) then {
						[_heli] execVM "unitCapture\alpha2.sqf"; // defending point 2 - point 2 is base
					};
				}; 
				// Point 2 Taken ^^
			};
		};
		case 2: { };
		case 3: { };
		case 4: { };
		case 5: {
			// Echo 
			switch (patrolPointsTaken) do {
				// initial LZ 
				case 0: {
					if (RFCHECK == true) then {
						[_heli] execVM "unitCapture\echo0.sqf"; // attacking point 1 - LZ is base 
						systemChat "DEBUG - Respawn Path - Case 0 RFCHECK true";
					};
					if (RFCHECK2 == true) then {
						[_heli] execVM "unitCapture\echo1.sqf"; // defending point 1 - point 1 is base
						systemChat "DEBUG - Respawn Path - Case 0 RFCHECK2 true";
					};
				}; 
				case 1: { 
					if (RFCHECK) then {
						[_heli] execVM "unitCapture\echo1.sqf"; // attacking point 2 - point 1 is base 
						systemChat "DEBUG - Respawn Path - Case 1 RFCHECK true";
					};
					if (RFCHECK2 == true) then {
						[_heli] execVM "unitCapture\echo2.sqf"; // defending point 2 - point 2 is base
						systemChat "DEBUG - Respawn Path - Case 1 RFCHECK2 true";
					};
				}; 
				case 2: { 
					if (RFCHECK) then {
						[_heli] execVM "unitCapture\echo2.sqf"; // attacking point 3 - point 2 is base 
						systemChat "DEBUG - Respawn Path - Case 2 RFCHECK true";
					};
					if (RFCHECK2 == true) then {
						[_heli] execVM "unitCapture\echo3.sqf"; // defending point 3 - point 3 is base
						systemChat "DEBUG - Respawn Path - Case 2 RFCHECK2 true";
					};
				}; 
			};		
		};
		case 6: { };
		case 7: { };
		case 9: { };
		case 9: { };
		default { };
	};

} else {
	[_heli] execVM "unitCapture\playerRespawnBase.sqf";
};


// add the player in cargo 
_player moveInCargo _heli;

// cutText ["", "BLACK IN", 1];

// eject player once they land 
[_heli, [_player]] spawn RGGe_fnc_effects_ejectPlayer;

RGG_heliRunning = true;
publicVariable "RGG_heliRunning";
sleep 10;
RGG_heliRunning = false;
publicVariable "RGG_heliRunning";