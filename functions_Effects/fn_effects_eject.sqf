/*
Eject FNC 
Updated: 23 May 24 
Purpose: Ejects cargo when near ground  
Author: Reggs 

Notes:
_heli is the given heli that is being watched 
_cargo is known cargo that needs to be ejected on landing 
_jumpTrig is the numerical value that determines what height kicks the units out 
_zone is the markername str of the area that will enable the checking of the alt trig 

cycle will check whether heli is in area, and only if yes will is check for height 

*/

params ["_heli", "_cargo", "_jumpTrig", "_zone"];



// _playerIsInside = player inArea _myTrigger;

_check = true;
while {_check} do {
	_inZone = _heli inArea _zone;
	if (_inZone) then {
		_pos = getPos _heli;
		_alt = _pos select 2;
		if (_alt >= _jumpTrig) then {
			{
				unassignVehicle _x;
				moveOut _x;
				_x setUnitPos "MIDDLE";
				_pos = getPos _x;
				_goTo = _pos getPos [((random 30) + 15), (random 359)];
				_x doMove _goTo; 
			} forEach _cargo;
			_check = false;
		};
	};
	sleep 10;
};

{
	_pos = getPos _x;
	_goTo = _pos getPos [((random 30) + 15), (random 359)];
	_x doMove _goTo; 
	sleep 0.2;
} forEach _cargo;

/*





// {
// 	_x allowDamage false;
// } forEach _cargo;


_chk = true;
while {_chk} do {
	if (((getPosATL _heli) select 2) < 1.7) then {
		{
			unassignVehicle _x;
			moveOut _x;
			_x setUnitPos "MIDDLE";
			1.1;
		} forEach _cargo;
		_chk = false;
	};
	sleep 0.7;
};

sleep 2;
{
	_x allowDamage true;
} forEach _cargo;

sleep 1;

{
	_pos = getPos _x;
	_goTo = _pos getPos [((random 30) + 15), (random 359)];
	_x doMove _goTo; 
	sleep 0.2;
} forEach _cargo;

sleep 20;

if (KILLCHAINISLIVE) then {
	_tinmanPos = [] call RGGg_fnc_get_tinmanPos;
	{
		if (((getPos _x) distance _tinmanPos) > 60) then {
			// add anotherr check for dist to obj - only move these units if tinman is closer to obj 

			_tinAlt = _tinmanPos select 2;

			if (((_tinmanPos distance ([] call RGGg_fnc_get_currentObj)) < 2000) && (_tinAlt < 10)) then {
				(leader _x) move ((_tinmanPos getPos [50, (_tinmanPos getDir ([] call RGGg_fnc_get_currentObj))]) getPos [((random 15) + 5), (random 359)]); 
				_x setSpeedMode "full";			
				_x setUnitPos "up";
				_x forceSpeed 4;
				sleep (selectRandom [0.1,0.2,0.3]);			
			} else {
				systemChat "tinman too far away, or is in the air, holding position at LZ";
			};	
		};
		sleep 0.2;
	} forEach _cargo;
};


