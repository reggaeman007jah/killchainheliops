/*
Echo FNC - unitPlay paths for Echo Patrol  
Updated: 22 Nov 2023

Purpose: runs the unitPlay system for Echo Patrol insertion - AI only.

Params: 
- _numCargo / numerical value / sets number of AI to be inserted via heli 

Notes:
- for now this is only used for AI, not for respawns or mass insertions at mission start 

Actions:
- rename this to be more generic, and not patrol-specific 
- vary the heli skin 
*/

params ["_numCargo"];

systemChat "running: RGGh_fnc_heli_runEchoPaths"; 

// safety check here - prevents overlapping spawns (I hope) -----------------------------------
_chk = true;
while {_chk} do {
	if (RGG_heliRunning == false) then {
		_chk = false;
	} else {
		_chk = true; // do we really need this reaffirmed?
	};
	systemChat "checking";
	sleep 1;
};
// safety check here - prevents overlapping spawns (I hope) ----------------------------------- end 


// heli setup 
_heliX = [[15135,113.244,200], 180, "vn_b_air_uh1d_02_07", west] call BIS_fnc_spawnVehicle;
_heli = _heliX select 0;

switch (patrolPointsTaken) do {
	// initial LZ 
	case 0: {
		if (RFCHECK == true) then {
			systemChat "running Echo 0";
			[_heli] execVM "unitCapture\echo0.sqf"; // attacking point 1 - LZ is base 
		};
		if (RFCHECK2 == true) then {
			systemChat "running Echo 1";
			[_heli] execVM "unitCapture\echo1.sqf"; // defending point 1 - point 1 is base
		};
		if ((RFCHECK == false) && (RFCHECK2 == false)) then {
			systemChat "running Echo 0";
			[_heli] execVM "unitCapture\echo0.sqf"; // attacking point 1 - LZ is base - i.e. default init state before bools have set in 
		};	

	}; 
	case 1: { 
		if (RFCHECK) then {
			[_heli] execVM "unitCapture\echo1.sqf"; // attacking point 2 - point 1 is base 
		};
		if (RFCHECK2 == true) then {
			[_heli] execVM "unitCapture\echo2.sqf"; // defending point 2 - point 2 is base
		};
	}; 
	case 2: { 
		if (RFCHECK) then {
			[_heli] execVM "unitCapture\echo2.sqf"; // attacking point 3 - point 2 is base 
		};
		if (RFCHECK2 == true) then {
			[_heli] execVM "unitCapture\echo3.sqf"; // defending point 3 - point 3 is base
		};
	}; 
	default { systemChat "switch error - ECHO PATHS"; };
};


// AI Only 
_indiCargo = [];
for "_i" from 1 to _numCargo do {
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