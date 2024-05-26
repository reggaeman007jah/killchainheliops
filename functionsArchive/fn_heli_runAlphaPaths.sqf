/*
Alpha FNC - unitPlay paths for Alpha Patrol  
Updated: 16 Nov 2023

Purpose: runs the unitPlay system for Alpha Patrol insertion.

Params: 
- _cargoType / numerical value / can be 1 (players), or 2 (AI)
- _cargo / optional / array that holds a player, or array of players

Notes:
- can be set to hold / disembark AI, or players 
- for now this is only used for AI, not for respawns or mass insertions at mission start 

Actions:
- rename this to be more generic, and not patrol-specific 
*/

params ["_cargoType", "_cargo"];

systemChat "running: RGGh_fnc_heli_runAlphaPaths"; 

// safety chack here - prevents overlapping spawns (I hope) -----------------------------------
_chk = true;
while {_chk} do {
	if (RGG_heliRunning == false) then {
		_chk = false;
	} else {
		_chk = true; // do we really need this reaffirmed?
	};
	sleep 1;
	systemChat "checking";
};
// safety chack here - prevents overlapping spawns (I hope) ----------------------------------- end 


// heli setup 
_heliX = [[15135,113.244,200], 180, "vn_b_air_uh1d_02_07", west] call BIS_fnc_spawnVehicle;
_heli = _heliX select 0;
// [_heli] execVM "unitCapture\alpha0.sqf";

switch (patrolPointsTaken) do {
	// initial LZ 
	case 0: {
		systemChat "IMPORTANT - ALPHA PATROL PATHS HERE";
		systemChat format ["RFCHECK: %1", RFCHECK];
		systemChat format ["RFCHECK2: %1", RFCHECK2];
		if (RFCHECK == true) then {
			[_heli] execVM "unitCapture\alpha0.sqf"; // attacking point 1 - LZ is base 
		};
		if (RFCHECK2 == true) then {
			[_heli] execVM "unitCapture\alpha1.sqf"; // defending point 1 - point 1 is base
		};
		if ((RFCHECK == false) && (RFCHECK2 == false)) then {
			[_heli] execVM "unitCapture\alpha0.sqf"; // attacking point 1 - LZ is base - i.e. default init state before bools have set in 
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
	default { systemChat "switch error - ALPHA PATHS"; };
	// Point 2 Taken ^^
};


// AI Only 
_indiCargo = [];
for "_i" from 1 to 6 do {
	_indiGroup = createGroup [independent, true];
	_unit = _indiGroup createUnit [[1] call RGGg_fnc_get_randomIndiforClassname, [0,0,100], [], 0.1, "none"];
	_unit moveInCargo _heli;
	_indiCargo pushBack _unit;
	bluforZeus addCuratorEditableObjects [[_unit], true];
	sleep 0.1;
};

[_heli, _indiCargo] spawn RGGe_fnc_effects_eject;



// safety valve -----------------------------------------------------------------------------------------------
RGG_heliRunning = true;
publicVariable "RGG_heliRunning";
sleep 10;
RGG_heliRunning = false;
publicVariable "RGG_heliRunning";
// safety valve ----------------------------------------------------------------------------------------------- end 