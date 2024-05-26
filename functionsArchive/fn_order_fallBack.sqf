/*
TINMAN BASIC - FALLBACK FNC 
Updated: 06 Dec 2023 
Purpose: One off order - all indi groups move to player (PL) position 
Author: Reggs 

Params: none 

Check:
- do we need to set speed here? Would this order inherit a slower speed order?
- this should always be fasted speed 

Snippets:
{playSound "attack"} remoteExec ["call",-2];
{playSound "commandOut"} remoteExec ["call",0];
systemChat "played sound";
*/
systemChat "FALLING BACK";
FALLBACKREMAIN = false; 
RGG_AUTOMOVE = false;
{
	if ((groupOwner _x) != 2) then { _x setGroupOwner 2 };

	_tinPos = [] call RGGg_fnc_get_tinmanPos;
	_dist = _tinPos distance (getPos (leader _x));

	if ((_dist < 500) && (_dist > 15)) then {
		{
			_x setUnitPos "up";
			_x forceSpeed 4;
			sleep (selectRandom [0.1, 0.2, 0.3]);		
		} forEach (units _x);
		_goTo = (_tinPos getPos [(selectRandom [6, 8, 10, 12, 14, 16]), (random 359)]);
		(leader _x) move _goTo;
		{
			[_x, _goTo, 5, 2, 45, "stanceMiddle"] spawn RGGo_fnc_order_watchDest;
		} forEach (units _x);
		
	} else {
		{
			_x setUnitPos "middle";
		} forEach (units _x);	
	};
} forEach (allGroups select {side _x isEqualTo independent});

