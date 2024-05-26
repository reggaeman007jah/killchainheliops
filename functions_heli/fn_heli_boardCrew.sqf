/*
Heli Board Crew FNC 
Updated: 01 Nov 2023 

Purpose: Boarding system for blufor gunners and isCopilotEnabled 

Note:
- This is a key element of Killchain. This system should enable player pilots to land at a designated PZ to spawn and board AI crew and CP.

*/

params ["_pilot", "_heli"];



_allTurrets = allTurrets [_heli, false];
systemChat format ["DEBUG - _allTurrets: %1", _allTurrets];
_cntT = count _allTurrets;
systemChat format ["DEBUG - _cntT: %1", _cntT];

sleep 1;

_freeGunPositions = _heli emptyPositions "Gunner";
systemChat format ["DEBUG -_heli: %1", _heli];
systemChat format ["DEBUG -Gun Positions: %1", _freeGunPositions];

// _freeCargoFFVGunPositions = _heli emptyPositions "Commander";
// systemChat format ["_heli: %1", _heli];
// systemChat format ["Commander Gun Positions: %1", _freeCargoFFVGunPositions];

CANBOARDGUN = false;

_spawn = [9510.79,6632.45,0]; // a placed tent 

_fullCrew = fullCrew _heli;
{
	if (isNull (_heli turretUnit [_x select 0])) then { 
		_float = diag_tickTime;
		_stampToString = str _float;
		_stampToString = createGroup [west, true];
		_unit = _stampToString createUnit ["vn_b_men_aircrew_04", _spawn, [], 0.1, "none"]; 
		bluforZeus addCuratorEditableObjects [[_unit], true];

		_unit addEventHandler ["Reloaded", {
			params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];
			format ["%1 IS RELOADING !!!!", _unit] remoteExec ["systemChat", _pilot]; 
		}];

		_unit addEventHandler ["Killed", {
			params ["_unit", "_killer", "_instigator", "_useEffects"];
			// run a heli check, if in heli, check empty turret seats and if empty, unlock that turret
			[_unit] call RGGu_fnc_utilities_unlockCheck;
		}];

		_unit assignAsTurret [_heli, [_x select 0]];
		[_unit] orderGetIn true; 
		_stampToString setCombatMode "RED";
		_stampToString setBehaviour "COMBAT";
	};
	sleep 2;
} forEach _allTurrets;

// private _sensors = listVehicleSensors _heli;
// hint str _sensors;

_checkCanRedeploy = true;
while {_checkCanRedeploy} do {
	_heliPos = getPos _heli;
	_distance = _heliPos distance [9529.24,6613.7,0];
	if (_distance > 20) then {
		_checkCanRedeploy = false;
		CANBOARDGUN = true;
		// {
		// 	_turretsTEst = _heli turretUnit turretpath
		// 	_unit assignAsTurret [_heli, [_x select 0]];

		// 	sleep 2;
		// } forEach _allTurrets;
		_fullCrew = fullCrew _heli;
		systemChat format ["_fullCrew: %1", _fullCrew];
	};

	// {
	// 	// _turret = _heli unitTurret _x;
	// 	// systemChat format ["turret-check: %1", _turret];
	// 	_assRole = assignedVehicleRole _x;
	// 	systemChat format ["_assRole-check: %1", _assRole];
	// 	// _heli lockTurret [_turret, true];
	// } forEach _fullCrew;

	sleep 5;
};

{
	_heli lockTurret [_x, true];
} forEach _allTurrets;
