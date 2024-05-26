/*
Return Random Opfor Classname FNC 
Updated: 30 Oct 2023 

Purpose: Returns one classname at random 

To-do: make this so that I can request an array back, i.e. to one call, not many calls 

Takes: _category code, used to provide the following sub-classes:
	1 - NVA 
	2 - VC 

*/

params ["_category"];

_data = [];
switch (_category) do {
	case 1: { 
		_data = [
			"vn_o_men_nva_01",
			"vn_o_men_nva_02",
			"vn_o_men_nva_03",
			"vn_o_men_nva_04",
			"vn_o_men_nva_05",
			"vn_o_men_nva_06",
			"vn_o_men_nva_07",
			"vn_o_men_nva_08",
			"vn_o_men_nva_09",
			"vn_o_men_nva_10",
			"vn_o_men_nva_11",
			"vn_o_men_nva_12",
			"vn_o_men_nva_13",
			"vn_o_men_nva_14",
			"vn_o_men_nva_15",
			"vn_o_men_nva_16",
			"vn_o_men_nva_17",
			"vn_o_men_nva_18",
			"vn_o_men_nva_19",
			"vn_o_men_nva_20",
			"vn_o_men_nva_21",
			"vn_o_men_nva_22",
			"vn_o_men_nva_23",
			"vn_o_men_nva_24",
			"vn_o_men_nva_25",
			"vn_o_men_nva_26",
			"vn_o_men_nva_27",
			"vn_o_men_nva_28",
			"vn_o_men_nva_29",
			"vn_o_men_nva_30",
			"vn_o_men_nva_31",
			"vn_o_men_nva_33",
			"vn_o_men_nva_34",
			"vn_o_men_nva_35"
		];
	};
	case 2: { 
		_data = [
			"vn_o_men_vc_regional_01",
			"vn_o_men_vc_regional_02",
			"vn_o_men_vc_regional_03",
			"vn_o_men_vc_regional_04",
			"vn_o_men_vc_regional_05",
			"vn_o_men_vc_regional_06",
			"vn_o_men_vc_regional_07",
			"vn_o_men_vc_regional_08",
			"vn_o_men_vc_regional_09",
			"vn_o_men_vc_regional_10",
			"vn_o_men_vc_regional_11",
			"vn_o_men_vc_regional_12"
		];
	};
	default { systemChat "Opfor ClassName Error"};
};

_return = selectRandom _data;
_return;
