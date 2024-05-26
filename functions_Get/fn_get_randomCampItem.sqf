/*
Random Camp Item Classname FNC
Updated: 13 Nov 2023 

Purpose: Returns random camp item classname 
*/

_data = [
	"Land_WoodPile_F",
	"Land_WoodenLog_F",
	"vn_c_pack_01",
	"vn_b_item_medikit_01_gh",
	"vn_b_item_firstaidkit_gh",
	"vn_o_item_firstaidkit_gh",
	"Land_vn_c_prop_basket_04",
	"Land_vn_basket_ep1",
	"vn_o_item_bedroll_01",
	"vn_prop_food_fresh_09_gh",
	"Land_vn_canisterfuel_blue_f"
];
_rtn = selectRandom _data;
_rtn;