/*
randomArmyClassnames FNC 
Purpose: returns random classname of given (passed) type 
Updated: 04 June 24 
Author: Reggs 

Params:
	_type: number / 1 = US Army, 2 = LRRP 
*/

params ["_type"];


_data1 = [
	"vn_b_men_army_01",
	"vn_b_men_army_14",
	"vn_b_men_army_03",
	"vn_b_men_army_04",
	"vn_b_men_army_05",
	"vn_b_men_army_06",
	"vn_b_men_army_07",
	"vn_b_men_army_08",
	"vn_b_men_army_09",
	"vn_b_men_army_10",
	"vn_b_men_army_11",
	"vn_b_men_army_11",
	"vn_b_men_army_12",
	"vn_b_men_army_16",
	"vn_b_men_army_17",
	"vn_b_men_army_18",
	"vn_b_men_army_07",
	"vn_b_men_army_19",
	"vn_b_men_army_20",
	"vn_b_men_army_10",
	"vn_b_men_army_21",
	"vn_b_men_army_12",
	"vn_b_men_army_11"
];
_data2 = [
	"vn_b_men_sf_01",
	"vn_b_men_sf_14",
	"vn_b_men_sf_03",
	"vn_b_men_sf_04",
	"vn_b_men_sf_05",
	"vn_b_men_sf_06",
	"vn_b_men_sf_07",
	"vn_b_men_sf_08",
	"vn_b_men_sf_09",
	"vn_b_men_sf_10",
	"vn_b_men_sf_11",
	"vn_b_men_sf_11",
	"vn_b_men_sf_12",
	"vn_b_men_sf_16",
	"vn_b_men_sf_17",
	"vn_b_men_sf_18",
	"vn_b_men_sf_07",
	"vn_b_men_sf_19",
	"vn_b_men_sf_20",
	"vn_b_men_sf_10",
	"vn_b_men_sf_21",
	"vn_b_men_sf_12",
	"vn_b_men_sf_11"
];
_rtn = selectRandom _data1;
if (_type == 1) then {
	_rtn = selectRandom _data1;
} else {
	_rtn = selectRandom _data;
};
_rtn;