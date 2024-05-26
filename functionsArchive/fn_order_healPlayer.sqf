/*
Heal Player FNC 
Updated: 27 Nov 2023 

Purpose: Finds a nearby unit to perform medical / resus the injured player

Actions:
- Verify - could this allocate an existing protector unit? Check the array results!
- we need to inform the player what's happening while downed 
- consider forceKill if no healers around 
- consider what happens if the healer is KIA before finished healing - do we check at the end ifALive before resuss?
- what if they get close but can't walk the last few meters? I've seen this!
*/

params ["_player"];

_healer = objNull; // init dec 
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


if ((count _nearestfriendlies) > 1) then {
	_healer = _nearestfriendlies select 1; 

	if ((count units _healer) > 1) then {
		_origGroup pushBack (group _healer);
		if ((side _healer) == independent) then {
			[_healer] joinSilent (createGroup [independent, true]);
		} else {
			[_healer] joinSilent (createGroup [west, true]);
		};
	};

	if ((groupOwner (group _healer)) != 2) then {  
		(group _healer) setGroupOwner 2;
	};

	_healer setUnitPos "up";
	_healer forceSpeed 4;
	_healer doMove (getPos _player);

	if ((side _healer) == independent) then {
		["<t size='0.8' color='#ffffff' font='PuristaMedium' >An ARVN Combat Medic is en-route to your position</t>",-1,-1,3,2] remoteExec ["bis_fnc_dynamictext", _player];	
	} else {
		["<t size='0.8' color='#ffffff' font='PuristaMedium' >A SOG Combat Medic is en-route to your position</t>",-1,-1,3,2] remoteExec ["bis_fnc_dynamictext", _player];	
	};
	sleep 6;

	_chk = true;
	while {_chk} do {
		_dist = (getPos _healer) distance (getPos _player);

		if ((alive _healer) && (alive _player) && (_dist < 2)) then {
			["<t size='0.8' color='#ffffff' font='PuristaMedium' >Combat Medic is at your position</t>",-1,-1,3,2] remoteExec ["bis_fnc_dynamictext", _player];
			_healer setUnitPos "middle";
			_healer doWatch _player;
			_healer disableAI "MOVE";			
			_healer setDir (_healer getDir _player);
			_healer playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
			sleep 12;
			// To-do ... add ifAliveHealer check here, before resus 
			["#rev", 1, _player] remoteExecCall ["BIS_fnc_reviveOnState", _player]; 
			_player setVariable ["RGG_unitIsDown", false, true];
			["<t size='0.8' color='#ffffff' font='PuristaMedium' >You're good ...</t>",-1,-1,2,3] remoteExec ["bis_fnc_dynamictext", _player];
			_healer enableAI "Move";
			_healer enableAI "AUTOTARGET";
			_healer doWatch ([] call RGGg_fnc_get_currentObj);
			_chk = false;
		} else {
			_chk = true;
			_healer enableAI "MOVE";
			_healer disableAI "AUTOTARGET";
			_healer setBehaviourStrong "careless";
			_healer doMove (getPos _player);
			[(parseText format ["<t size='0.5' color='#ffffff' font='PuristaMedium' >Medic is %1m away</t>", (floor _dist)]),0,0.8,1,1] remoteExec ["bis_fnc_dynamictext", _player];
		};

		if ((lifeState _player) != "INCAPACITATED") then {
			_healer enableAI "Move";
			_chk = false;
		};

		if (_dist > 250) then {
			_chk = false;
		};

		_targetAlt = (getPos _player) select 2;
		if (_targetAlt > 10) then {
			_chk = false;
		};

		if ((!alive _healer) && (_targetAlt < 5)) then {
			if ((side _healer) == independent) then {
				["<t size='0.8' color='#ffffff' font='PuristaMedium' >ARVN Combat Medic is KIA, another call has gone out</t>",-1,-1,2,3] remoteExec ["bis_fnc_dynamictext", _player];
			} else {
				["<t size='0.8' color='#ffffff' font='PuristaMedium' >SOG Combat Medic is KIA, another call has gone out</t>",-1,-1,2,3] remoteExec ["bis_fnc_dynamictext", _player];
			};
			sleep 2;
			[_player] spawn RGGo_fnc_order_healPlayer; 
			_chk = false;
		};

		sleep 2;
	};
} else {
	["<t size='0.8' color='#ffffff' font='PuristaMedium' >There are no ARVN or SOG medics near your position</t>",0,0,2,3] remoteExec ["bis_fnc_dynamictext", _player];
	// does this system catch units still in a heli? Do they do the needful on landing?
	// maybe get the protector to do a slower heal?
};

if ((count _origGroup) > 0) then { [_healer] joinSilent (_origGroup select 0) };
_healer setBehaviour "auto";
_healer doWatch objNull;
systemChat "DEBUG - HEALER - END CYCLE";