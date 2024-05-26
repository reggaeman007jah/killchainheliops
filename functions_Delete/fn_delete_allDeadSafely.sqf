/*
Delete all dead safely 
Purpose: 	This deletes dead bodies safely, when no players are near 
Updated: 	17 Nov 2023
Author: 	Reggs 
*/

while { KILLCHAINISLIVE } do {
	_z1check = ["zone1"] call RGGc_fnc_count_playersClose;
	_z2check = ["zone2"] call RGGc_fnc_count_playersClose;
	_z3check = ["zone3"] call RGGc_fnc_count_playersClose;
	if (_z1check == false) then {
		{
			if ((getPos _x) inArea "zone1") then { deleteVehicle _x };
		} forEach allDead inAreaArray "zone1";
	};
	if (_z2check == false) then {
		{
			if ((getPos _x) inArea "zone2") then { deleteVehicle _x };
		} forEach allDead inAreaArray "zone2";
	};
	if (_z3check == false) then {
		{
			if ((getPos _x) inArea "zone3") then { deleteVehicle _x };
		} forEach allDead inAreaArray "zone3";
	};
	sleep 180;
};