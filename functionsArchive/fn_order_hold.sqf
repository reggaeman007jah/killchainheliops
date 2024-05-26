/*
TINMAN BASIC - HOLD FNC 
Updated: 06 Dec 2023 
Purpose: One off order - all indi groups to hold position 
Author: Reggs 

Params: none 

Actions:
- have all units who fallback to setDir away from Tinman 

Snippets:
"All INDI Groups are holding position" remoteExec ["systemChat", -2];
{playSound "attack"} remoteExec ["call",-2];
{playSound "commandOut"} remoteExec ["call",0];
systemChat "played sound";
*/

systemChat "HOLDING POS";
FALLBACKREMAIN = false; // in case was running 
RGG_AUTOMOVE = false;
{
	if ((groupOwner _x) != 2) then { _x setGroupOwner 2 };
	if ((([] call RGGg_fnc_get_tinmanPos) distance (getPos (leader _x))) < 500) then {
		_x move (getPos (leader _x));
		{
			[_x, (getPos (leader _x)), 5, 5, 45, "stanceMiddle"] spawn RGGo_fnc_order_watchDest;	
		} forEach (units _x);	
	};
} forEach (allGroups select {side _x isEqualTo independent});

// think about finding the closest unit to target then making then leader (set leader) then using that pos as hold pos 








