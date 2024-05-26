/*
Repair and rearm system
Updated: 20 May 2022 

Create anchor object, check in a cycle for helis .. repair and rearm if yes 

NOTE - does not work in MP 

*/


while { TRUE } do {
	
	systemchat "pit check";
	_vic = [];
	_vics = vehicles inAreaArray "repairRearm";
	_cnt = count _vics;
	if (_cnt == 1) then {
		_heli = _vics select 0;
		systemChat format ["Heli: %1", _heli];
		_pilot = currentPilot _heli;
		systemChat format ["_pilot: %1", _pilot];
		_pilot setDamage 0;
		_pilot setfuel 1;
		_pilot setVehicleAmmo 1;
		systemchat "have stuff";
	};
	sleep 5;
};



// 	if (_cnt == 1) then {
// 		_chk = true;


// 		{
// 			if (_x isKindOf "helicopter") then {
// 				systemchat "DEBUG - we have a heli in the pit";
// 				_vic pushBack _x;
				
// 				while {_chk} do {
// 					_vics = vehicles inAreaArray "repairRearm";
// 					_cnt = count _vics;
// 					if (_cnt == 0) then {
// 						_chk == false;
// 					} else {
// 						// get pilot of heli - remoteexec on that pilot 
// 						_heli = _vic select 0;
// 						_pilot = currentPilot _heli;
// 						// [0] remoteExec ["setVehicleAmmo", _pilot]; // does this work??
// 						[0] remoteExec ["setVehicleAmmo", 0]; // does this work??

// 						// _x Setdamage 0;
// 						// _x Setfuel 1;
// 						// _x setVehicleAmmo 1;
// 						systemchat "all the things";
// 						sleep 20; // to allow for flyAway 
// 					};
// 				};
// 			} else {
// 				_chk = false;
// 			};
// 		} forEach _vics;
// 	};

// 	sleep 5;
// };