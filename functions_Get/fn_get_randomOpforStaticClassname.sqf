// this function when called will return a random classname for opfor static weaponry  

/*
Params:
* _type / 1 is high only, 2 is low only, 3 is any style 
*/

params ["_type"];

_high = [
	"vn_o_nva_navy_static_dshkm_high_01",
	"vn_o_nva_navy_static_rpd_high",
	"vn_o_nva_navy_static_pk_high"
];

_low = [
	"vn_o_nva_navy_static_pk_low",
	"vn_o_nva_navy_static_m1910_low_01",
	"vn_o_nva_navy_static_m1910_low_02",
	"vn_o_nva_navy_static_dshkm_low_01",
	"vn_o_nva_navy_static_dshkm_low_02"
];

_any = [
	"vn_o_nva_navy_static_dshkm_high_01",
	"vn_o_nva_navy_static_rpd_high",
	"vn_o_nva_navy_static_pk_low",
	"vn_o_nva_navy_static_pk_high",
	"vn_o_nva_navy_static_m1910_low_01",
	"vn_o_nva_navy_static_m1910_low_02",
	"vn_o_nva_navy_static_dshkm_low_01",
	"vn_o_nva_navy_static_dshkm_low_02"
];

_return = "";
switch (_type) do {
	case 1: { _return = selectRandom _high };
	case 2: { _return = selectRandom _low };
	case 3: { _return = selectRandom _any };
	default { systemChat "switch error statics" };
};

_return;

