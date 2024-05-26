// [west, [9569,6471,0], "pathfinder"] call BIS_fnc_addRespawnPosition;


enableEnvironment [false, true];

// #include "\a3\editor_f\Data\Scripts\dikCodes.h"

// ["Operation Killchain - Tactical","throwWhite", "throw white smoke", {_this call RGGtac_fnc_tactical_throwWhite}, ""] call CBA_fnc_addKeybind;
// ["Operation Killchain - Tactical","throwRed", "throw red smoke", {_this call RGGtac_fnc_tactical_throwRed}, ""] call CBA_fnc_addKeybind;
// ["Operation Killchain - Tactical","throwGreen", "throw green smoke", {_this call RGGtac_fnc_tactical_throwGreen}, ""] call CBA_fnc_addKeybind;
// ["Operation Killchain - Tactical","throwPurple", "throw purple smoke", {_this call RGGtac_fnc_tactical_throwPurple}, ""] call CBA_fnc_addKeybind;
// ["Operation Killchain - Tactical","throwYellow", "throw yellow smoke", {_this call RGGtac_fnc_tactical_throwYellow}, ""] call CBA_fnc_addKeybind;
// ["Operation Killchain - Tactical","throwWP", "throw WP", {_this call RGGtac_fnc_tactical_throwWP}, ""] call CBA_fnc_addKeybind;
// ["Operation Killchain - Tactical","throwGas", "throw gas", {_this call RGGtac_fnc_tactical_throwGas}, ""] call CBA_fnc_addKeybind;
// ["Operation Killchain - Orders", "orderHold", "Hold", {_this remoteExec ["RGGo_fnc_order_hold", 2]}, ""] call CBA_fnc_addKeybind;
// ["Operation Killchain - Orders", "orderFallBack", "Fall Back", {_this remoteExec ["RGGo_fnc_order_fallBack", 2]}, ""] call CBA_fnc_addKeybind;
// ["Operation Killchain - Orders", "orderReconOverwatch", "Recon Overwatch", {_this remoteExec ["RGGo_fnc_order_autoMove", 2]}, ""] call CBA_fnc_addKeybind;
// ["Operation Killchain - Orders", "orderAttack", "Attack Objective", {[2] remoteExec ["RGGo_fnc_order_attack", 2]}, ""] call CBA_fnc_addKeybind;
// ["Operation Killchain - Orders", "orderAttackStealth", "Attack - Stealth", {[1] remoteExec ["RGGo_fnc_order_attack", 2]}, ""] call CBA_fnc_addKeybind;
// ["Operation Killchain - Orders", "orderAttackCharge", "Attack - Charge", {[3] remoteExec ["RGGo_fnc_order_attack", 2]}, ""] call CBA_fnc_addKeybind;

// ["Operation Killchain - Menu System", "ordersDialog", "Orders Dialog", {_this remoteExec ["RGGo_fnc_order_ui", player]}, ""] call CBA_fnc_addKeybind;

// _rec =  player addAction ["Record", "unitCapture\capture.sqf"]; 
// _f1 =   player addAction ["Route 1", {
// 	["<t size='1' color='#ffffff' font='PuristaMedium' >Training Route 1</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", player, true];
// 	[6] remoteExec ["RGGh_fnc_heli_route1", 0];
// 	[] execVM "unitCapture\training\route1\route1trainee.sqf";;
// }, nil, 6, false, true]; 

// ["Operation Killchain - Aviation","wayfinderOneshot", "one-off wayfinder request - full", {_this spawn RGGi_fnc_information_wayfinderOneshot}, ""] call CBA_fnc_addKeybind;
// ["Operation Killchain - Aviation","wayfinderOneshotAdj", "one-off wayfinder adjust request", {_this spawn RGGi_fnc_information_wayfinderAdj}, ""] call CBA_fnc_addKeybind;
// ["Operation Killchain - Aviation","wayfinderOneshotDist", "one-off wayfinder distance request", {_this spawn RGGi_fnc_information_wayfinderDist}, ""] call CBA_fnc_addKeybind;
["Operation Killchain - Aviation", "wayfinderAdj", "Mission Course Direction", {_this spawn RGGw_fnc_wayF_adj}, ""] call CBA_fnc_addKeybind;
["Operation Killchain - Aviation", "wayfinderAdj", "Base Direction", {_this spawn RGGw_fnc_wayF_adjBase}, ""] call CBA_fnc_addKeybind;