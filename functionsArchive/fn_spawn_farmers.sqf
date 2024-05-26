/*
spawn_farmers FNC  
Updated: 13 May 2022 
Purpose: To create ambi-civvies in the warzone - currently will have 15-20 at any one time 
Author: Reggs
*/

params ["_spawnPos"];

_class = [
	"vn_c_men_03",
	"vn_c_men_04",
	"vn_c_men_07",
	"vn_c_men_08",
	"vn_c_men_11",
	"vn_c_men_12",
	"vn_c_men_15",
	"vn_c_men_16",
	"vn_c_men_19",
	"vn_c_men_20",
	"vn_c_men_23",
	"vn_c_men_24",
	"vn_c_men_27",
	"vn_c_men_28",
	"vn_c_men_31",
	"vn_c_men_32"
];

_civUnits = [];	
{ if ((side _x) == civilian) then {_civUnits pushBack _x} } forEach allUnits;

_civCnt = count _civUnits;
if (_civCnt < 3) then {
	for "_i" from 1 to 5 do {
		_grp = createGroup [civilian, true];
		_unit = _grp createUnit [(selectRandom _class), _spawnPos, [], 2, "none"]; 
		bluforZeus addCuratorEditableObjects [[_unit], true];
		sleep 0.2
	};
};
