/*
Get Init Loadout FNC 
Updated: 09 Nov 2023 

Purpose: holds and returns initial loadouts for _plr roles 

Action:
- create specifics for certain roles - e.g. medics have red berets 

*/

// check altis mission on how to manage _plr properly 

params ["_plr"];

removeAllWeapons _plr;
removeAllItems _plr;
removeAllAssignedItems _plr;
removeUniform _plr;
removeVest _plr;
removeBackpack _plr;
removeHeadgear _plr;
removeGoggles _plr;

_plr addWeapon "vn_m16";
_plr addPrimaryWeaponItem "vn_m16_20_t_mag";
_plr addWeapon "vn_p38s";
_plr addHandgunItem "vn_m10_mag";

_plr forceAddUniform "vn_b_uniform_macv_03_15";
_plr addVest "vn_b_vest_usmc_06";
_plr addBackpack "vn_b_pack_arvn_02_m16_pl";

_plr addWeapon "vn_m19_binocs_grey";

_plr addItemToUniform "vn_b_item_firstaidkit";
for "_i" from 1 to 2 do {_plr addItemToUniform "vn_m61_grenade_mag";};
_plr addItemToUniform "vn_m10_mag";
for "_i" from 1 to 3 do {_plr addItemToUniform "vn_m16_20_t_mag";};
for "_i" from 1 to 8 do {_plr addItemToBackpack "vn_b_item_firstaidkit";};
for "_i" from 1 to 12 do {_plr addItemToBackpack "vn_m16_20_t_mag";};
for "_i" from 1 to 4 do {_plr addItemToBackpack "vn_m61_grenade_mag";};
for "_i" from 1 to 2 do {_plr addItemToBackpack "vn_m18_red_mag";};
for "_i" from 1 to 2 do {_plr addItemToBackpack "vn_m18_purple_mag";};
_plr addItemToBackpack "vn_mine_m112_remote_mag";
for "_i" from 1 to 3 do {_plr addItemToBackpack "vn_mine_m14_mag";};
_plr addItemToBackpack "vn_mine_m18_range_mag";
for "_i" from 1 to 2 do {_plr addItemToBackpack "vn_m18_green_mag";};
for "_i" from 1 to 2 do {_plr addItemToBackpack "vn_m18_white_mag";};
for "_i" from 1 to 2 do {_plr addItemToBackpack "vn_m18_yellow_mag";};
for "_i" from 1 to 2 do {_plr addItemToBackpack "vn_m34_grenade_mag";};
_plr addHeadgear "vn_b_helmet_m1_02_01";
_plr addGoggles "vn_b_acc_towel_01";

_plr linkItem "vn_b_item_map";
_plr linkItem "vn_b_item_compass";
_plr linkItem "vn_b_item_watch";
_plr linkItem "vn_b_item_radio_urc10";


