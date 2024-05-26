// --- Order Get In Cargo --- // 

/*
Trying to manage civilian getIn orders 

Takes:
	unit 
	heli to get into 

*/

params ["_unit", "_heli", "_cargoSpace"];
systemChat "DEBUG / GET_IN_FNC - Running FNC";
// _unit = _this select 0;
// _heli = _this select 1;
// _cargoSpace = _this select 2;

_unit enableAI "move";
sleep 2;
_unit setUnitPos "up";

_heliPos = getPos _heli;
_unit doMove _heliPos;

// now for pos check 
_pos1 = getPos _unit;
sleep 20;
_pos2 = getPos _unit;
_dist = _pos1 distance _pos2;
if (_dist < 3) then {
	systemChat format ["DEBUG / GET_IN_FNC - stuck unit: %1", _unit];
	systemChat "DEBUG / GET_IN_FNC - Need to teleport - TO DO";
	// or just kill them and take the points 
	// unassignVehicle unitName 
	// first try unassign 
	unassignVehicle _unit; 
} else {
	systemChat format ["DEBUG / GET_IN_FNC - unit should be en-route: %1", _unit];
};

sleep 2;
systemChat "now to board";

_unit assignAsCargoIndex [_heli, _cargoSpace];
[_unit] orderGetIn true;
systemChat format ["DEBUG / GET_IN_FNC - double check ... %1 assigned to cargo space: %2", _unit, _cargoSpace];
// systemChat "DEBUG / GET_IN_FNC - this should iterate upwards";

// _cargoPos = assignedVehicleRole _unit;

// _vehicle = assignedVehicle _unit;
// systemChat format ["DEBUG / GET_IN_FNC - double check ... %1 assigned as cargo to heli %2", _unit, _vehicle];
// systemChat "DEBUG / GET_IN_FNC - should be the same vic";

_heliIndex = _heli getCargoIndex _unit;
systemChat "DEBUG / GET_IN_FNC - now check, is the index assigned before they get in or is it blank?";
systemChat format ["DEBUG / GET_IN_FNC - double check ... %1 assigned to slot: %2", _unit, _heliIndex];

_freeCargoPositions = _heli emptyPositions "cargo";
systemChat format ["DEBUG / GET_IN_FNC - %1 empty cargo slots: %2", _heli, _freeCargoPositions];
// to test - is you specify the cargo slot when assigning, does it show as free or taken here? ^^

// // now for pos check 
// _pos1 = getPos _unit;
// sleep 5;
// _pos2 = getPos _unit;
// _dist = _pos1 distance _pos2;
// if (_dist < 3) then {
// 	systemChat format ["DEBUG / GET_IN_FNC - stuck unit: %1", _unit];
// 	systemChat "DEBUG / GET_IN_FNC - Need to teleport - TO DO";
// 	// unassignVehicle unitName 
// 	// first try unassign 
// 	unassignVehicle _unit; 
// } else {
// 	systemChat format ["DEBUG / GET_IN_FNC - unit should be en-route: %1", _unit];
// };

// maybe the answer it to move them near first, and then get them to board when near 