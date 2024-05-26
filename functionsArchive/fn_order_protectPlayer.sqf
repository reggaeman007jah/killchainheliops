/*
Protect Player FNC 
Updated: 27 Nov 2023 

Purpose: Triggered when a player is incapacitated, and brings nearby ARVN on your position to protect you

Build Notes:
There are two phases of checking. In phase 1, the AI unit is trying to get to the player, and if they are KIA 
in the process, the FNC is re-triggered. What I don;t know is whether, in this event, the second cycle is triggered 
anyway. I have seen endless loops, but not sure how they happen, so this should be tested. The second phase occurs 
when the AI has taken a protective position over the player. In this phase, the state of the player is monitored, 
so while incapacitated, the AI's move ability is disabled. It is restored when the player is revived, or at a 
distance away i.e. respawned.

It should be noted that the separate healing system only kicks in once the player's position has been secured, and 
not before 

Actions:
- verify - does 'get nearest' work as intended?
- make getNearestIndifor a FNC so we can watch that pos 
- consider how to have multi-protectors arrive on-scene 

Snippets:
- _protector playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
*/

params ["_player"];

FALLBACKREMAIN = false; // in case was running 
_protector = objNull; // init dec 
_origGroup = []; // holds original group in case we need to re-group a unit 

// get nearest friendly -------------------------------------------------------------
_nearestunits = nearestObjects [(getPos _player), ["Man"], 500];
_nearestfriendlies = [];
if ((independent countSide _nearestunits > 0) or (west countSide _nearestunits > 0)) then {
	{
    	if ((side _x == independent) or (side _x == west)) then {	
			if (isPlayer _x == false) then { _nearestfriendlies pushBack _x };	
		};
  	} foreach _nearestunits;
};
// get nearest friendly ------------------------------------------------------------- end 


if ((count _nearestfriendlies) > 0) then {

	_protector = _nearestfriendlies select 0; 
	if ((count units _protector) > 1) then {
		_origGroup pushBack (group _protector);
		if ((side _protector) == independent) then {
			[_protector] joinSilent (createGroup [independent, true]);
		} else {
			[_protector] joinSilent (createGroup [west, true]);
		};
	};
	
	if ((groupOwner (group _protector)) != 2) then {  
		(group _protector) setGroupOwner 2;
	};

	_protector setUnitPos "up";
	_protector forceSpeed 4;
	_protector doMove (getPos _player);

	if ((side _protector) == independent) then {
		["<t size='0.8' color='#ffffff' font='PuristaMedium' >ARVN units are trying to secure your position</t>",-1,-1,8,2] remoteExec ["bis_fnc_dynamictext", _player];	
	} else {
		["<t size='0.8' color='#ffffff' font='PuristaMedium' >SOG units are trying to secure your position</t>",-1,-1,8,2] remoteExec ["bis_fnc_dynamictext", _player];	
	};
	sleep 6;

	_chk = true;
	while {_chk} do {
		_dist = (getPos _protector) distance (getPos _player);		

		if ((alive _protector) && (alive _player) && (_dist < 3)) then {
			_protector setUnitPos "middle";
			_protector doWatch ([] call RGGg_fnc_get_currentObj);
			if ((side _protector) == independent) then {
				["<t size='0.8' color='#ffffff' font='PuristaMedium' >ARVN have secured your position</t>",-1,-1,2,3] remoteExec ["bis_fnc_dynamictext", _player];	
			} else {
				["<t size='0.8' color='#ffffff' font='PuristaMedium' >SOG have secured your position</t>",-1,-1,2,3] remoteExec ["bis_fnc_dynamictext", _player];	
			};
			sleep 2;
			_protector disableAI "MOVE";
			[_player] spawn RGGo_fnc_order_healPlayer; 
			_chk = false;
		} else {
			_chk = true;
			_protector doMove (getPos _player);
			[(parseText format ["<t size='0.5' color='#ffffff' font='PuristaMedium' >Trooper Distance: %1m</t>", (floor _dist)]),0,0.8,4,3] remoteExec ["bis_fnc_dynamictext", _player];
		};

		if ((lifeState _player) != "INCAPACITATED") exitWith {
			_protector enableAI "Move";
			_chk = false;		
		};

		if (((getPos _player) select 2) > 5) exitWith {
			_chk = false;
		};

		if (!alive _protector) exitWith {
			["<t size='0.8' color='#ffffff' font='PuristaMedium' >Trooper is KIA, another call has gone out</t>",-1,-1,2,3] remoteExec ["bis_fnc_dynamictext", _player];
			sleep 4;
			[_player] spawn RGGo_fnc_order_protectPlayer; 
			_chk = false;
		};

		if (_dist > 250 ) exitWith {
			_chk = false; 
		};

		sleep 3;
	};

	_chk = true;
	while {_chk} do {
		_protector setUnitPos "middle";

		if ((lifeState _player) != "INCAPACITATED") then {
			_chk = false;		
		};

		if (!alive _protector) then {
			_chk = false;
		};

		if (((getPos _player) select 2) > 5) then {
			_chk = false;
		};

		if (((getPos _protector) distance (getPos _player)) > 250 ) then {
			_chk = false;
		};

		sleep 10;
	};

} else {
	["<t size='0.8' color='#ffffff' font='PuristaMedium' >There are no ARVN or SOG units near your position</t>",-1,-1,2,3] remoteExec ["bis_fnc_dynamictext", _player];
};

_protector doWatch objNull;
_protector enableAI "Move";

if ((count _origGroup) > 0) then {
	[_protector] joinSilent (_origGroup select 0)
};

systemChat "DEBUG - PROTECTOR - END CYCLE";
