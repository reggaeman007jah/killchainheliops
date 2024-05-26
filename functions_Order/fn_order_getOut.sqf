/*
Get Out FNC 
Updated: 19 Oct 2023 
Summary: This will disembark any cargo units from player's heli 

Action:
	Make sure there is a suitable despawner running, or triggered, to cleanup any delivered units at base 
*/

_vic = vehicle player;
_pos = getPos (vehicle player);

// [_vic, 0] spawn RGGe_fnc_effects_cargoCheck; // checker 

private _getOutFnc = {
    params ["_unit", "_pos"];

	_roleRtn = assignedVehicleRole _unit;
	_role = _roleRtn select 0;
	if (_role == "cargo") then {		
		format ["Cargo Unit told to get out: %1", _unit] remoteExec ["systemChat", 0]; 
		unassignVehicle _unit; 
		// _unloaded pushBack _unit;
		_unit setUnitPos "MIDDLE";
		moveOut _unit; 
		format ["Moving out: %1", _unit] remoteExec ["systemChat", 0];
		if (_pos inArea "pathfinderBase") then {
			_unit setCombatBehaviour "careless"; // trying on unit, not on group here 
			// [_unloaded, "UP", 20] spawn RGGo_fnc_order_setStance;
			// [_unloaded, 35] spawn RGGo_fnc_order_goRest; // points 
		} else {
			_dist = selectRandom [10, 10.2, 10.4];
			_dir = random 359;
			_moveTo = _pos getPos [_dist, _dir];
			_unit doMove _moveTo;
			// [_unloaded, "AUTO", 60] spawn RGGo_fnc_order_setStance;
		};
	};
};


_cnt = count (crew _vic); 
if (_cnt > 0) then {

	format ["You have %1 cargo units to unload", _cnt] remoteExec ["systemChat", 0]; 
	{
		//-- assuming that not all units must be local to the same machine, we 'justify' multiple remote execs :) 
		[[_x, _pos] , _getOutFnc] remoteExec ['bis_fnc_call', _x]; //-- you can also use 'bis_fnc_spawn'. Here, you execute the fnc where unit _x is local    
		sleep .7;
	} forEach crew _vic;

	sleep 10;
	{
		doStop _x;
	} forEach (crew _vic);
};



// format ["crew _vic: %1", (crew _vic)] remoteExec ["systemChat", 0]; // can I at least see the crew?

// {
// 	_roleRtn = assignedVehicleRole _x;
// 	_role = _roleRtn select 0;
// 	if (_role == "cargo") then {
// 		_units pushBack _x;
// 		format ["Unit told to get out: %1", _x] remoteExec ["systemChat", 0]; 

// 	};
// } forEach crew _vic;




// _cargoCnt = count _units;
// [_vic, 0, _cargoCnt] spawn RGGe_fnc_effects_cargoCheck; // checker - broken 
// sleep 2;

// _cnt = count _units; 
// format ["total units told to get out: %1", _cnt] remoteExec ["systemChat", 0]; 

// if (_cnt > 0) then {
	// format ["You have %1 cargo units to unload", _cnt] remoteExec ["systemChat", 0]; 
	// // systemChat format ["You have %1 cargo units to unload", _cnt];

	// _unloaded = [];
	// { 		
	// 	unassignVehicle _x; 
	// 	_unloaded pushBack _x;
	// 	_x setUnitPos "MIDDLE";
	// 	moveOut _x; 
	// 	format ["Moving out: %1", _x] remoteExec ["systemChat", 0]; 
	// 	sleep .7;
	// } forEach _units;




	// if (_pos inArea "pathfinderBase") then {
		// systemChat "dropping off units at Pathfinder";
		// {
		// 	_grp = group (_units select 0);
		// 	_ldr = leader _grp;
		// 	_grp setBehaviour "careless";

		// } forEach _units;
		// [_vic, 0] spawn RGGe_fnc_effects_cargoCheck; // checker 

	// } else {
		// systemChat "dropping off units in-field";
		// {
		// 	_dist = selectRandom [10, 10.2, 10.4];
		// 	_dir = random 359;
		// 	_moveTo = _pos getPos [_dist, _dir];
		// 	// _x setUnitPos "MIDDLE";
		// } forEach _units;

		// sleep 10;

		// {
		// 	doStop _x;
		// } forEach _units;

		// [_vic, 0] spawn RGGe_fnc_effects_cargoCheck; // checker - to do 
		
	// };
// };

/* Notes 
we should recognise that getout order might be used in combat or after a patrol 
we should also use this system for managing unloading injured as well as uninjured 
so if dropping off at PF, you count the unloaded as tickets back into the system 
1 ticket for healthy - 2 tickets for each injured 

