// --- inv mission 1 --- // 

/*
This mission is for extraction of injured civvies 

takes 
	building 
*/

_building = _this select 0;

_classes = [
	"LOP_AFR_Civ_Man_02",
	"LOP_AFR_Civ_Man_03",
	"LOP_AFR_Civ_Man_04",
	"LOP_AFR_Civ_Man_06",
	"C_Man_casual_4_v2_F_asia",
	"C_Man_casual_9_F_asia",
	"C_man_p_fugitive_F_asia",
	"C_man_polo_4_F_asia"
];

_positions = [_building] call BIS_fnc_buildingPositions;
_cnt = count _positions;
systemChat format ["DEBUG / INVESTIGATE 1 - number of available building positions: %1", _cnt];
systemChat format ["DEBUG / INVESTIGATE 1 - available building positions: %1", _positions];

// generate units in each available spot 
_civGroup = createGroup civilian;
// for "_i" from 1 to _cnt do {
// 	_class = selectRandom _classes;
// 	_unit = _civGroup createUnit [_class, _extractPos, [], 0.1, "none"]; 
// 	// _unit doMove _randomMovePos; Item_Medikit
// 	_unit removeItem "Item_Medikit";
// 	_unit removeItem "Item_Medikit";
// 	_unit removeItem "Item_Medikit";
// 	_unit setDamage 0.9;
// 	sleep 2;
// };

{
	_class = selectRandom _classes;
	_unit = _civGroup createUnit [_class, _x, [], 0.1, "none"]; 
	_unit addMPEventHandler ["MPKilled", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		if (isPlayer _killer) then {
			systemChat "YOU SLOTTED A GOOD GUY";
		};
	}];
	// _unit removeItem "Item_Medikit";
	// _unit removeItem "Item_Medikit";
	// _unit removeItem "Item_Medikit";
	_unit setDamage 0.9;
} forEach _positions;