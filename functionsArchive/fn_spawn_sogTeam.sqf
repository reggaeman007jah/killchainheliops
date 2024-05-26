/*
spawn_sogTeam FNC 
Updated: 01 Dec 2023
Purpose: Spawns SOG units near to caller, and assigns them as a bodyguard unit (to caller)
Author: Reggs 
*/

params ["_target", "_delay"];

sleep _delay;
_2dSpawnPosX = [(getPos _target), 500, 4] call RGGg_fnc_get_nearestBushes; 
_sogGroup = createGroup [west, true];
{
	_unit = _sogGroup createUnit [([] call RGGg_fnc_get_randomSOGClassname), _x, [], 1, "none"]; 
	bluforZeus addCuratorEditableObjects [[_unit], true];
	sleep 0.1;	
} forEach _2dSpawnPosX;
_sogGroup setSpeedMode "limited";
_sogGroup move (getPos _target);
[_target, _sogGroup] remoteExec ["RGGo_fnc_order_sogCPD", _target, true];
[[
	["Incoming Telex", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7'>%1</t><br/>"],
	["Following your actions in the field, you have been assigned an S.O.G. Fire Team:", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7'>%1</t><br/>"],
	["Degrees:", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7'>%1</t><br/>"],
	[(str (floor ((getPos _target) getDir (getPos (leader _sogGroup))))), "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7'>%1</t><br/>"],
	["Meters:", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7'>%1</t><br/>"],
	[(str (floor ((getPos _target) distance (getPos (leader _sogGroup))))), "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7'>%1</t><br/>"],
	["Telex End", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>", 30]
]] remoteExec ["BIS_fnc_typeText", _target]; 
sleep 15;
_sogGroup setSpeedMode "full";
