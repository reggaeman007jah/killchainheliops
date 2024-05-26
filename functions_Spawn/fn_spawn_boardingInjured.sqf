/*
spawn_boardingInjured FNC
Updated: 24 May 24 
Purpose: Spawns in injured units who await a heli to land nearby, to which they will board  
Author: Reggs 
*/

params ["_extractPos"];

// check helis nearby and create units based on that number? For now keep as a set 4-6

_toBoard = [];

for "_i" from 1 to (selectRandom [4,5,6]) do {
	systemChat "creating injured unit";
	_indiGroup = createGroup west;
	_class = [] call RGGg_fnc_get_randomArmyClassname;  
	_pos = _extractPos getPos [(random 15), (random 359)];
	_unit = _indiGroup createUnit [_class, _pos, [], 0.1, "none"]; 
	_toBoard pushBack _unit;
	// _unit removeItems "vn_b_item_firstaidkit";
	{
		_unit removeItems _x
	} forEach ["vn_b_item_firstaidkit","vn_o_item_firstaidkit","FirstAidKit","Medikit","vn_b_item_medikit_01"];
	// {
	// 	_unit removeItems _x
	// } forEach ["vn_b_item_firstaidkit","vn_o_item_firstaidkit","FirstAidKit","Medikit","vn_b_item_medikit_01"];
	// {
	// 	_unit removeItems _x
	// } forEach ["vn_b_item_firstaidkit","vn_o_item_firstaidkit","FirstAidKit","Medikit","vn_b_item_medikit_01"];
	_unit setDamage 0.9;
	_unit setUnitPos (selectRandom ["middle"]);
	sleep 0.3;
};

// success/fail checker, with follow-on delete FNC 
[_toBoard, _extractPos, 10] spawn RGGm_fnc_mission_statusCheckMedivac;



// this next FNC is run on each unit individually, to manage the fact that multiple helis / players may be picking up .. 
// so each unit has to behave independently of the others
{
	// _x setDamage 0.9;	
	[_x] spawn RGGo_fnc_order_autoBoard; 
} forEach _toBoard;
