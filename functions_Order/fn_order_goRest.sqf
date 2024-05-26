/*
FNC Go Rest 
Updated: 19 Oct 2023 

Purpose: Will send given array to the medical area and process points 
*/

params ["_unitArray", "_delay"];

systemChat "RUNNING GO REST";

_despawnPos = [9798,6667];
sleep _delay;
// note - I need to manage orderly despawning of these units at this location when noone is around 
// and do scores 
// and do health checks 

_uniqueGrps = [];
{
	_grp = group _x;
	_uniqueGrps pushBackUnique _grp;
} forEach _unitArray;

{
	_x move _despawnPos;
} forEach _uniqueGrps;

	// 		// unassignVehicle _x; 
	// 		// [_x] orderGetIn false;
	// 		// _x doMove [9798,6667];
	// 		// _x setBehaviour "careless";

	// 		// // dam check 
	// 		// _dam = damage _x;
	// 		// if (_dam > 0.7) then {
	// 		// 	systemChat "this guy is fucked up";
	// 		// 	// add points 
	// 		// } else {
	// 		// 	systemChat "this guy seems ok";
	// 		// 	// add points 
	// 		// }; 
	// 		// // apply tickets based on health 



