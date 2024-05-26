/*
TINMAN BASIC - ATTACK FNC 
Updated: 03 Dec 2023
Purpose: One off attack order - instructs -all- indifor move in to attack objective 
Author: Reggs

Params:
* _speed / num value, 1 2 3 

Notes:
- this system uses a move check, and telports them to a nearby pos if no movement seen after order given  

Snippets:
"All ARVN Groups are assaulting the objective" remoteExec ["systemChat", -2];
{playSound "attack"} remoteExec ["call",-2];
{playSound "commandOut"} remoteExec ["call",0];
systemChat "played sound";
*/

params ["_speed"]; 

FALLBACKREMAIN = false; 
RGG_AUTOMOVE = false;
_movePos = getMarkerPos 'REDZONE'; // objective pos 
_selection = []; // holds data for strays 

{
	if ((groupOwner _x) != 2) then {  
		_x setGroupOwner 2;
	};

	if ((([] call RGGg_fnc_get_tinmanPos) distance (getPos (leader _x))) < 500) then {

		_selection pushBack _x;
		_x move _movePos; 
		_x setFormation "STAG COLUMN";

		{
			_x setUnitPos "up";
		} forEach (units _x);

		switch (_speed) do {
			case 1: {
				_x setSpeedMode "limited";				
				{
					_x forcespeed (2 + (selectRandom [0.1, 0.2]));
					sleep (selectRandom [0.1,0.2,0.3]);
				} forEach (units _x);
			};
			case 2: {
				_x setSpeedMode "normal";			
				{
					_x forceSpeed 3;
					sleep (selectRandom [0.1,0.2,0.3]);
				} forEach (units _x);
			};
			case 3: {
				_x setSpeedMode "full";			
				{
					_x forceSpeed 4;
					sleep (selectRandom [0.1,0.2,0.3]);
				} forEach (units _x);
			};
			default { systemChat "switch error Attack OBJ"; };
		};

		if (((getPos (leader _x)) distance _movePos) > 50) then {
			[_x, _movePos] spawn RGGu_fnc_utilities_chkIfMoved; // send group and move order pos 
		};

	} else {
		systemChat "too far away to issue orders"; 
		// should we use this event to send them in anyway, as they are doing nothing out there, and why wait for the auto-check?
	};
} forEach (allGroups select {side _x isEqualTo independent});

[_selection, _movePos] spawn RGGu_fnc_utilities_processIndiStrays; // sends an array of indi groups and re-orders the strays to attack the obj 

