/*
Eject FNC 
Updated: 27 Nov 2023 
Purpose: Ejects player cargo when near ground, then teleports them to the nearest friendly unit  
Author: Reggs 
*/

params ["_heli", "_cargo"];

{
	_x allowDamage false;
} forEach _cargo;


_chk = true;
while {_chk} do {
	if (((getPosATL _heli) select 2) < 1.8) then {
		{
			unassignVehicle _x;
			moveOut _x;
			1.1;
		} forEach _cargo;
		_chk = false;
	};
	sleep 0.8;
};

sleep 2;
{
	_x allowDamage true;
} forEach _cargo;

if (RFCHECK) then {

	_z2indi = 0;
	_z3indi = 0;
	{
		if ((side _x) == independent) then { _z2indi = _z2indi + 1 };
	} forEach (allUnits inAreaArray "zone2");
		{
		if ((side _x) == independent) then { _z3indi = _z3indi + 1 };
	} forEach (allUnits inAreaArray "zone3");

	
	if ((count allPlayers) == 1) then {

		if ((_z2indi > 0) or (_z3indi > 0)) then {
			if (_z2indi > _z3indi) then {

				_indiUnits = [];
				{
					if (side _x == independent) then { _indiUnits pushBack _x };
				} forEach (allUnits inAreaArray "zone2");

				sleep 2;
				
				{ _x allowDamage false } forEach _cargo;

				[0, "BLACK", 3, 1] remoteExec ["BIS_fnc_fadeEffect", (_cargo select 0)]; 

				sleep 4;

				[(_cargo select 0), (getPos (selectRandom _indiUnits))] remoteExec ["setPos", (_cargo select 0)];
				["Moving up to the front line", (_cargo select 0), 3] spawn RGGi_fnc_information_dyText;

				sleep 3;
				[1, "BLACK", 5, 1] remoteExec ["BIS_fnc_fadeEffect", (_cargo select 0)]; 	
				sleep 5;
				{ _x allowDamage true } forEach _cargo;

			} else {
				_indiUnits = [];
				{
					if (side _x == independent) then { _indiUnits pushBack _x };
				} forEach (allUnits inAreaArray "zone3");

				sleep 2;
				
				{ _x allowDamage false } forEach _cargo;

				[0, "BLACK", 3, 1] remoteExec ["BIS_fnc_fadeEffect", (_cargo select 0)];  

				sleep 4;

				[(_cargo select 0), (getPos (selectRandom _indiUnits))] remoteExec ["setPos", (_cargo select 0)];
				["Moving up to the front line", (_cargo select 0), 3] spawn RGGi_fnc_information_dyText;

				sleep 3;
				[1, "BLACK", 5, 1] remoteExec ["BIS_fnc_fadeEffect", (_cargo select 0)];	
				sleep 5;
				{ _x allowDamage true } forEach _cargo;
			};
		};

	} else {

	};

};



