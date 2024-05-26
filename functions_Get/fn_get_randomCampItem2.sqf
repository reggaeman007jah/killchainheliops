/*
Random Camp Item Classname FNC
Updated: 13 Nov 2023 

Purpose: Returns random camp item classname - used for abandoned camps 
*/

_data = [
	"Land_vn_temple_ruin_04",
	"Land_vn_clothesline_01_short_f",
	"Land_vn_clothesline_01_f",
	"Land_vn_woodenplanks_01_messy_pine_f",
	"Land_vn_o_bunker_01",
	"Land_vn_o_tower_03",
	"Land_vn_o_tower_02",
	"Land_vn_o_shelter_06",
	"Land_vn_o_shelter_03",
	"Land_vn_o_platform_05",
	"Land_vn_o_platform_04",
	"Land_vn_o_shelter_05",
	"Land_vn_o_bunker_03",
	"Land_vn_woodencart_f",
	"Land_vn_wheel_cart_ep1",
	"Land_vn_sacks_heap_f",
	"Land_vn_sack_f",
	"Land_vn_fence_punji_01_03"
];
_rtn = selectRandom _data;
_rtn; 