// --- alive check --- //

/*
Takes a unit, checks if theyre alive, returns true when they are alive, and returns false when they are not

*/

_unit = _this select 0; // unit to be checked 
systemChat format ["unit to be checked", _unit];

sleep 10;

_alive = true;

if (alive _unit) then {
	systemChat format ["unit %1 is alive", _unit];
	_alive = true;
} else {
	systemChat format ["unit %1 is dead", _unit];
	_alive = false;
};

_alive; 