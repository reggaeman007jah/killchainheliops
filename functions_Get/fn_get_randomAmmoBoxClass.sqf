/*
Random Camp Item Classname FNC
Updated: 13 Nov 2023 

Purpose: Returns random ammobox item classname 
*/

_data = [
	"vn_b_ammobox_supply_12",
	"vn_b_ammobox_supply_04",
	"vn_b_ammobox_full_15",
	"vn_b_ammobox_full_14",
	"vn_b_ammobox_full_13",
	"vn_b_ammobox_full_14",
	"vn_b_ammobox_full_12",
	"Land_vn_us_30cal",
	"Land_vn_us_can_50",
	"Land_vn_us_can_30",
	"Land_vn_us_ammobox_small",
	"Land_vn_us_ammobox_small_03",
	"Land_vn_us_ammobox_small_05",
	"Land_vn_us_ammobox_small_04",
	"Land_vn_us_launchers",
	"Land_vn_us_ammo",
	"Land_vn_us_weapons",
	"Land_vn_us_weapons_stack4",
	"Land_vn_bedna_ammo2x",
	"Land_Ammobox_rounds_F"
];
_rtn = selectRandom _data;
_rtn;

//

/*
Return Random Ammobox Classname FNC 
Updated: 13 Nov 2023 

Purpose: Returns one ammobox classname at random 

To-do: make this so that I can request an array back, i.e. to one call, not many calls 

Takes: _category code, used to provide the following sub-classes:
	1 - Blufor 
	2 - Opfor

*/

params ["_category"];

_data = [];
switch (_category) do {
	case 1: { 
		_data = [
			"vn_b_ammobox_supply_12",
			"vn_b_ammobox_supply_04",
			"vn_b_ammobox_full_15",
			"vn_b_ammobox_full_14",
			"vn_b_ammobox_full_13",
			"vn_b_ammobox_full_14",
			"vn_b_ammobox_full_12",
			"Land_vn_us_30cal",
			"Land_vn_us_can_50",
			"Land_vn_us_can_30",
			"Land_vn_us_ammobox_small",
			"Land_vn_us_ammobox_small_03",
			"Land_vn_us_ammobox_small_05",
			"Land_vn_us_ammobox_small_04",
			"Land_vn_us_launchers",
			"Land_vn_us_ammo",
			"Land_vn_us_weapons",
			"Land_vn_us_weapons_stack4",
			"Land_vn_bedna_ammo2x",
			"Land_Ammobox_rounds_F"
		];
	};
	case 2: { 
		_data = [
		];
	};
	default { systemChat "Ammobox ClassName Error"};
};
_return = selectRandom _data;
_return;
