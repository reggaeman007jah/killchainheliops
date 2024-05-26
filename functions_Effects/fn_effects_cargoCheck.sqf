/*
Heli Full FNC 
Updated: 19 Oct 23 
Purpose: Alerts pilot when heli is full up so can leave quickly - eventually this will trigger audio alerts for the pilot 
Author: Reggs 
*/

params ["_heli", "_flag", "_cargoCnt"];

_chk = true;
_it = 0;
switch (_flag) do {

	case 0: {

	};

	case 1: {

		_initSeats = _heli emptyPositions "cargo"; 
		_diffNum = _initSeats - _cargoCnt; 
		while {_chk} do {
			_it = _it + 1;
			_seats = _heli emptyPositions "cargo";			
			if (_seats == 0) then {
				systemChat "CHOPPER IS TOTALLY FULL - GO GO GO";
				_chk = false;
			} else {
				if (_seats == _diffNum) then { 
					systemChat "YOU HAVE WHAT YOU ARE EXPECTING - GO GO GO";
					_chk = false;
				} else {
					systemChat format ["Available free seats: %1", _seats]; 
				};				
			};
			if (_it == 90) then {
				_chk = false;
			};
			sleep 1;	
		};		
	};
	default { systemChat "cargo checker error" };
};





