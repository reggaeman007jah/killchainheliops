/*
Extract Pilot 
Updated: 23 May 2022 

This will enable players to conduct a pilot extract mission, and if successful will enable rewards (CAS/Guns)

23 May Notes: I am trying to fix the issue where ambient helis land and try to extract the pilot - but overall I think this needs 
more testing. What happens if there are more than 1 heli in the area? What happens if one is assigned then needs to leave? etc 



Action: Update these notes as they're old 

Ideas:
Pilot can have variable health - may bleed out (currently 0.9 damage, consider variation in v2)
May be opfor nearby (note, in testing I have seen roamers spawn very close, so this may be enough)
Consider using setCaptive to generate a surprise attack when exfil happens (maybe v2)
Need to trial usage of isFlatEmpty for suitable LZs (current system seems to work ok)
Pilot will always be near an LZ, to enable good extract (currently pilot will be in the open)
Pilot system will gen flares in the daytime (maybe also at night) to alert players of their location (currently not day/night-specific)
Logic for flares depends on units in the LZ area 
Consider lifespan of pilot in jungle - can last for whole mission? TODO - despawn pilots if a patrol point progresses - use delete camp maybe?
Consider use of panels to assist landing (v2)

v1 - get suitable zones working reliably - done 
v2 - get spawning working and auto-baording 
v3 - get opfor ambush system working 
v4 - get bools managed well - ?
v5 - bleedout system 

So mission starts, and straight away we find a good location .. needs to be away from the beaten track, past point 1, and has landing zone 
Once location is found, run a check for players in the area - forget height for now, just check for prox 
If players are within params, pop a flare - run this check every 3 minutes 
Flare should spawn roughly over LZ 

Set up a marker zone, so that if a heli lands .. pilot will try to get in.
toDo: check that the 'ony once' system is run before we get to this stage 

// think about - should flare be over LZ, or over pilot pos?
*/

// consider - do we want to make it so that point 1 never has this mission? 

systemChat "DEBUG - RUNNING: missions_extractPilot";

params ["_anchor"]; // parsed mission obj pos  

// get spawn anchor based off patrol obj 
_pos = _anchor getPos [(selectRandom [400,500,600]), (random 359)];

// debug marker for _pos 
// _objective1 = createMarker ["pilotExtract", _pos];
// _objective1 setMarkerShape "ELLIPSE";
// _objective1 setMarkerColor "ColorRed";
// _objective1 setMarkerSize [100, 100];
// _objective1 setMarkerAlpha 0;

// now find suitable area 
_lz = _pos findEmptyPosition [1,200,"B_Heli_Transport_03_unarmed_F"];


// if (_lz == []) exitwith {}; // did not work - check how to manage nil results


// debug marker for _lz 
_objective1 = createMarker ["lz", _lz];
_objective1 setMarkerShape "ELLIPSE";
_objective1 setMarkerColor "ColorBlue";
_objective1 setMarkerSize [80, 80];
// _objective1 setMarkerAlpha 0.2; // debug
_objective1 setMarkerAlpha 0;


// create pilot 
private _grp = createGroup [west, true];
// _unit = _grp createUnit ["vn_b_men_aircrew_02", _lz, [], 0.1, "none"]; 
_unit = _grp createUnit ["vn_b_men_jetpilot_10", _lz, [], 0.1, "none"]; 
_unit removeItem "vn_b_item_firstaidkit";
_unit setDamage 0.9;
bluforZeus addCuratorEditableObjects [[_unit], true];


// cycleCheck 
_chk = true;
_cyc = 0; // iteration .. used to prevent flares spawning on every checkCycle  
while {_chk} do {

	// iteration 
	_cyc = _cyc + 1;

	// flares based on results of LZ count 
	_units = allUnits inAreaArray "lz";
	_cnt = count _units;

	// toDo - ensure only Blufor units are counted here - otherwise Roamers might affect flares being popped 
	// leave as is for now - maybe you don't pop a flare if Opfor are near?

	if (_cnt == 0) then {
		// either pilot is dead or gone - either way, kill cycleCheck here 
		_chk = false;
		deleteMarker "lz"; 
		// deleteMarker "pilotExtract"; 
	};

	if (_cnt == 1) then {
		// do flares as only pilot is in area 
		// _flr = true;
		// params ["_pos", "_col", "_upper", "_lower", "_sleep", "vel"];
		if (_cyc == 5) then {
			systemChat "DEBUG - spawning flare FNC";
			[_lz,"red",100,50,60,-4] spawn RGGe_fnc_effects_sosFlare;
			_cyc = 0;
		};
	};

	if (_cnt > 1) then {
		// no flares as players / opfor are nearby 
		_vics = vehicles inAreaArray "lz";
		_cnt = count _vics;
		_helis = []; // to hold any heli data 
		if (_cnt > 0) then {
			// pushback only helis 
			{
				if (_x isKindOf "helicopter") then {

					// is the pilot a player?
					_pilot = driver _x;
					if (isPlayer _pilot) then {
						systemchat "DEBUG - we have a heli close to the pilot";
						systemChat "DEBUG - but .. are there any spaces free?";
						_seats = _x emptyPositions "cargo";
						systemChat format ["_seats free: %1", _seats];
						if (_seats > 0) then {
							_helis pushBack _x;
							systemChat format ["DEBUG - pushing back %1 heli", _x];
						};					
					};
				};
			} forEach _vics;
		};
		// now we check for _helis - if any in there, we send message to pilot to help them out 
		// we should also do this in case there are more than one heli being caught here - keep it simple , select 0 
		_cntH = count _helis;
		if (_cntH > 0) then {
			systemChat format ["Number of helis - with space - near pilot: %1", _cnt];
			// send message to pilot - you have space, and there is someone on the ground closeby 
			titletext ["Check for smoke ...", "PLAIN DOWN"];
			_pPos = getPos _unit; 
			_smoke = createVehicle ["G_40mm_smokeYELLOW", _pPos, [], 0, "none"]; 
			// _pilot = _passed select 0;
			// _heli = vehicle _pilot;
			if (_cntH == 1) then {
				_exfil = _helis select 0; 
				_unit assignAsCargo _exfil;
				systemChat format ["%1 assigned to %2", _unit, _exfil];
				[_unit] orderGetIn true;
				systemChat "DEBUG unit ordered to getIn";
			} else {
				_altCheck = true;
				while { _altCheck } do {
					{
						_pos = getPos _x;
						_alt = _pos select 2;
						if (_alt < 5) then {
							_exfil = _x; 
							_unit assignAsCargo _exfil;
							systemChat format ["%1 assigned to %2", _unit, _exfil];
							[_unit] orderGetIn true;
							systemChat "DEBUG unit ordered to getIn";	
							_altCheck = false;	
						};
					} forEach _helis;
					sleep 10;
				};
			};

			_chk = false; // close cycle 
			deleteMarker "lz"; 
			// deleteMarker "pilotExtract"; 
		};
	};

	sleep 20;
};

