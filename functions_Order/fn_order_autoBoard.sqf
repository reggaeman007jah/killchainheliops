/*
Order Autoboard FNC 
Updated: 23 May 24
Purpose: Orders given AI unit to auto-board any heli nearby  
Author: Reggs

Notes:
If there are 3 units to be picked up, each unit will have this process running, to ensure each unit (which is in their own group) will take 
decisions independent of others, and always go to the nearest heli - which is important as this is an MP experience, ie pickup scripts must work 
in MP, without bugs!!

How do we manage the heli never landing - process must be time-limited! Can this be done via a separate process, as a pass/fail assessment for the pickup mission?

*/

params ["_unitToBoard"]; 

systemChat format ["running autoboard on %1", _unitToBoard];
// RGG_MISSIONLIVE = false;
/*
Run a check for nearby helis that are landed, and once one is found, end check and go to it 
but when moving to heli, have another check running, so if that chosen heli leaves, then the unit will look for another heli to board 
*/

_name = str _unitToBoard;
_objective1 = createMarker [_name, (getPos _unitToBoard)];
_objective1 setMarkerShape "ELLIPSE";
_objective1 setMarkerColor "ColorBlue";
_objective1 setMarkerSize [100, 100];
_objective1 setMarkerAlpha 0.2; // debug
// _objective1 setMarkerAlpha 0;

_helis = []; // to hold any heli data 

_check1 = true;
while {_check1} do {

	_vics = vehicles inAreaArray _name;
	if ((count _vics) > 0) then {
		{
			if (_x isKindOf "helicopter") then {

				// has it landed?
				_pos = getPos _x;
				_alt = _pos select 2;

				if (_alt < 1.5) then {
					
					// enough seats?
					_seats = _x emptyPositions "cargo";
					systemChat format ["DEBUG - seats free: %1", _seats];
					if (_seats > 0) then {
						_helis pushBack _x;
						systemChat format ["DEBUG - pushing back %1 heli", _x];
						_check1 = false;
						deleteMarker _name;
					};
				};
			};
		} forEach _vics;
	};
	sleep 3;
};

_chosenHeli = _helis select 0; // note, this ^^ should be improved to be the closest one, but will do for now, and give the unit 'something' to move to 

// order boarding here 
_unitToBoard assignAsCargo _chosenHeli;
systemChat format ["%1 assigned to %2", _unitToBoard, _chosenHeli];
[_unitToBoard] orderGetIn true;
// _unitToBoard forcespeed (2 + (selectRandom [0.1, 0.2]));


// now check if chosen heli has taken off without passenger 
_check2 = true;
while {_check2} do {

	// is heli still landed or has unit actually boarded?

	_isInHeli = _unitToBoard in _chosenHeli;
	if (_isInHeli == true) then {
		// unit is on board, end process 
		// send unit to alt check jump trig 
		[_chosenHeli, _unitToBoard, 0.4, "medicalZone", [9220.78,6243.92,0]] spawn RGGo_fnc_order_autoUnboard;
		_check2 = false;
	} else {
		_posHeli = getPos _chosenHeli;
		_posUnit = getPos _unitToBoard;	
		_altHeli = _posHeli select 2;
		if (_altHeli > 2) then {
			// heli took off, restart process 
			_check2 = false;
			[_unitToBoard] spawn RGGo_fnc_order_autoBoard; 
		};
	};

	sleep 3;
};




/*


























// get unit pos  
// get pos of any heli nearby 
// confirm is landed 
// get in 
// stage autoGetOut FNC 
// delete marker 

// _chk = true;
// // _cyc = 0; // iteration .. used to limit time to complete  
// while {_chk} do {

	// _cyc = _cyc + 1;

	_vics = vehicles inAreaArray "LZ";
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
		_smoke = createVehicle ["G_40mm_smokeYELLOW", _anchor, [], 0, "none"]; 
		// _pilot = _passed select 0;
		// _heli = vehicle _pilot;
		if (_cntH == 1) then {
			_exfil = _helis select 0; 
			{
				_x assignAsCargo _exfil;
				systemChat format ["%1 assigned to %2", _x, _exfil];
				[_x] orderGetIn true;
				sleep 1;
			} forEach _unitsToBoard;
		};

		// } else {
		// 	_altCheck = true;
		// 	while { _altCheck } do {
		// 		{
		// 			_pos = getPos _x;
		// 			_alt = _pos select 2;
		// 			if (_alt < 5) then {
		// 				_exfil = _x; 
		// 				_unit assignAsCargo _exfil;
		// 				systemChat format ["%1 assigned to %2", _unit, _exfil];
		// 				[_unit] orderGetIn true;
		// 				systemChat "DEBUG unit ordered to getIn";	
		// 				_altCheck = false;	
		// 			};
		// 		} forEach _helis;
		// 		sleep 10;
		// 	};
		// };

		// _chk = false; // close cycle 
		deleteMarker "LZ"; 
		// deleteMarker "pilotExtract"; 
	};
	

// 	sleep 5;
// };

