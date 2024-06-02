/*
Declare On Station FNC 
Purpose: When run, it informs KC Command that the given heli is open for tasking 
Updated: 31 May 24
Author: Reggs 

Notes:
This should also kick off the mission time clock for the DB 
// systemChat format ["Hello %1", _player];
// test - can we derive the player's heli from the player themelves? this is being triggered from init.sqf, so can I use 'player' here reliably? 

*/


params ["_player"];

_heli = vehicle _player;
// how do you know which raptor this is? 
systemChat format ["RAP: %1", _heli];

_heliStr = str _heli;
_numb = _heliStr select [6, 1];
systemChat format ["_numb: %1", _numb];

if !(isNull objectParent _player) then {

	switch (_numb) do {
		case "1": { 
			if (RGG_rap1onTask == false) then {
				RGG_rap1onTask = true;
				[_heli] spawn RGGm_fnc_mission_manager;	
			} else {
				systemChat "Raptor 1 is already tasked - complete current task before taking another";
			};
		};
		case "2": { 
			if (RGG_rap2onTask == false) then {
				RGG_rap2onTask = true;
				[_heli] spawn RGGm_fnc_mission_manager;	
			} else {
				systemChat "Raptor 2 is already tasked - complete current task before taking another";
			};
		};
		case "3": { 
			if (RGG_rap3onTask == false) then {
				RGG_rap3onTask = true;
				[_heli] spawn RGGm_fnc_mission_manager;	
			} else {
				systemChat "Raptor 3 is already tasked - complete current task before taking another";
			};
		};
		case "4": { 
			if (RGG_rap4onTask == false) then {
				RGG_rap4onTask = true;
				[_heli] spawn RGGm_fnc_mission_manager;	
			} else {
				systemChat "Raptor 4 is already tasked - complete current task before taking another";
			};
		};
		case "5": { 
			if (RGG_rap5onTask == false) then {
				RGG_rap5onTask = true;
				[_heli] spawn RGGm_fnc_mission_manager;	
			} else {
				systemChat "Raptor 5 is already tasked - complete current task before taking another";
			};
		};
		case "6": { 
			if (RGG_rap6onTask == false) then {
				RGG_rap6onTask = true;
				[_heli] spawn RGGm_fnc_mission_manager;	
			} else {
				systemChat "Raptor 6 is already tasked - complete current task before taking another";
			};
		};
		default { systemChat "raptor tasking switch error"};
	};

	// // check if given raptor is already tasked 
	// if (RGG_rap1onTask == false) then {
	// 	systemChat format ["%1 Ready for tasking", _heli];
	// 	switch (_numb) do {
	// 		case "1": { RGG_rap1onTask = true };
	// 		case "2": { RGG_rap2onTask = true };
	// 		case "3": { RGG_rap3onTask = true };
	// 		case "4": { RGG_rap4onTask = true };
	// 		case "5": { RGG_rap5onTask = true };
	// 		case "6": { RGG_rap6onTask = true };
	// 		default { };
	// 	};
		
	// 	[_heli] spawn RGGm_fnc_mission_manager;	
	// } else {
	// 	systemChat "your raptor is already tasked, complete current task before taking another";
	// };

} else {
	systemChat "you should get in a heli before asking for task..";
};