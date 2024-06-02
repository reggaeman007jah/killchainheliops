/*
Auto Unboard 
Last Updated: 23 May 24
Purpose: Orders a unit to auto-disembark when the given heli reaches a given alt while in a given marker zone 

_heli: the given heli transferring troops 
_cargo: the unit (singular) this applies to 
_jumpTrig: number value that determines when unit is kicked out of heli 
_zone: marker area name 
_TTL: time to live ie number of cycles before process should end 
this ^^ does not handle mission pass of failure, this only prevents this from being an infinite loop ie this is a failsafe 
_moveTo: position the unit should move to when they can move 
*/

params ["_heli", "_cargo", "_jumpTrig", "_zone", "_moveTo", "_TTL"];

_cargo allowDamage false;

_check = true;
while {_check} do {
	_inZone = _heli inArea _zone;
	if (_inZone) then {
		_pos = getPos _heli;
		_alt = _pos select 2;
		if (_alt <= _jumpTrig) then {
			unassignVehicle _cargo;
			moveOut _cargo;
			_cargo setUnitPos "MIDDLE";
			_cargo setBehaviourStrong "careless";
			// apply points to player, per unit delivered!
			_pos = getPos _cargo;
			_goTo = _pos getPos [((random 2) + 1), (random 359)];
			_cargo doMove _goTo; 
			_check = false;
		};
	};
	sleep 5;
};

sleep 2;
_cargo allowDamage true;
sleep (random 4);

_cargo setUnitPos "UP";
_cargo doMove _moveTo;
_cargo setBehaviourStrong "CARELESS";
_cargo setCombatBehaviour "CARELESS";
_unitGrp = group _cargo;
_unitGrp setSpeedMode "limited";

// cleanup 
[[_cargo], _moveTo, 150, 10] spawn RGGd_fnc_delete_whenNoPlayers; // this should only happen once! not repeated for each passenger!!! 



// action, on dismount, make them move out away a bit 