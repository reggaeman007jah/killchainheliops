/*
Date: 		26 April 2022 
Author: 	Reggs 
Title: 		resupLRRP / Resupply LRRP Patrols 
Summary: 	This function will manage the resupply LRRP mission dynamic 

devNotes:
I want a function that can be run at any time, to generate a resupply mission. This is being written 
for a VN scenario, but should be easily transferrable to future campaigns. 
Essentially, the player team will need to bring a supply box to an embedded LRRP team, in order to 
receive a reward of some sort. 
I need to ensure we use the ropeBreak EH properly.
Do I automate the positions here, or pre-code an array of positions suitable?
Idea - have different bases in the area that hold different things - medical, uxplosives, rockets etc 
This way  a LRRP mission will be supplied from different bases sometimes 


Key UX Elements:
dropzone should be near a treeline, as I want to get LRRPs to run out of the jungle to resupply, 
then run back into the jungle and despawn safely.
dropzone should be an 8-grid, not a map marker 
Mission can be declared as a radio transmission (audio file).
Mission can be time-limited - we could state that the team needs ammo before nightfall or else dead 
Can be a cold or hot LZ 


Logic / Plan:
Start with hardcoded positions 
Decsion - when do we trigger this?
Start with a morning radio alert - maybe every morning between x and y time 
Need a playerNear trigger - must be in heli and must have crate to trigger 
Once trigger is set, we don't do smoke, I want the pilot to be sure of the pos  
LRRPs cannot show their position until the last moment, so they rely on pilots knowing 
grids well enough to deploy crates with confidence 
As soon as ropeBreak correctly, get LRRPs to resupply at box .. then return to jungle cover 
If this is done, then the next assault will have one less group, as they will have been ambushed 
and killed by the LRRP team 


Elements:
Radio alert to pilots with coords and what the LRRPs need 
Trigger for heli with cargo 
System to affect any future spawning - reducing or adding depending on mission success/fail 
Spawn, move resupply and move away system 
Hot/Cold LZ system 

_data = [
	//
	//
];

_pos = selectRandom _data;

_posX = _pos select 0;
_posY = _pos select 1;

15 May
have a mission appear for raptors only .. telex a position, and have them deploy an ammo box there 
spawn LRRPs, and smoke when any heli is near .. create marker to check for box - when box in area, 
have LRRPs rearm at box for the action.
V1 - this is it, you just wait for noPlayersNear and get reward - ARVN RF 
Each mission lasts for 20 minutes, it is triggered in each patrol point cycle, and has a random 
start delay so as not to be predictable 

*/

// get random pos in Free Fire Zone - must be at least 2000 away and also not near Pathfinder 

// run checkSmoke system - this will run on a loop until either time runs out or player heli near  
// and when yes, pop smoke - so pass location and timeout 

systemChat "Debug - Running LRRP Resupply Mission";
sleep 30; // make random 
_lrrpPos = "freeFireZone" call BIS_fnc_randomPosTrigger;
// also here get isFlatEmpty 

_deleteData = []; 

_dZone = createMarker ["_dZone", _lrrpPos];
_dZone setMarkerShape "ELLIPSE";
_dZone setMarkerColor "ColorBlue";
_dZone setMarkerSize [20, 20];
_dZone setMarkerAlpha 0.2;

// create a spot different from spawn point, as center of main marker 
_markerDis = random 250; // so, 500m radius 
_markerDir = random 359;
_markerPos = _lrrpPos getPos [_markerDis, _markerDir];

_lrrpMrk = createMarker ["_lrrpMrk", _markerPos];
_lrrpMrk setMarkerShape "ELLIPSE";
_lrrpMrk setMarkerColor "ColorBlue";
_lrrpMrk setMarkerSize [600, 600];
_lrrpMrk setMarkerAlpha 0.4;

_lrrp = createMarker ["_lrrpPos", _markerPos];
_lrrp setMarkerType "b_recon";

systemChat "Debug - creating LRRPs";

_pos1 = _lrrpPos getPos [10,0];
_pos2 = _lrrpPos getPos [10,90];
_pos3 = _lrrpPos getPos [10,180];
_pos4 = _lrrpPos getPos [10,270];

_lrrpGroup1 = createGroup [west, true];
_lrrpGroup2 = createGroup [west, true];
_lrrpGroup3 = createGroup [west, true];
_lrrpGroup4 = createGroup [west, true];
_unit1 = _lrrpGroup1 createUnit ["vn_b_men_lrrp_01", _pos1, [], 0.1, "none"]; 
_unit2 = _lrrpGroup2 createUnit ["vn_b_men_lrrp_01", _pos2, [], 0.1, "none"]; 
_unit3 = _lrrpGroup3 createUnit ["vn_b_men_lrrp_01", _pos3, [], 0.1, "none"]; 
_unit4 = _lrrpGroup4 createUnit ["vn_b_men_lrrp_01", _pos4, [], 0.1, "none"]; 
bluforZeus addCuratorEditableObjects [[_unit1,_unit2,_unit3,_unit4], true];

// smoke trigger 
[_lrrpPos, 600, 30, 3] spawn RGGe_fnc_effects_smokeProx2;


_chk = true;
_iter = 0;
while {_chk} do {
	
	_iter = _iter + 1;

	if (_iter == 25) exitWith {
		// also - check no players are near-ish 
		systemChat "time is up, LRRPs are now probably KIA";
		_deleteData pushBack [_unit1, _unit2, _unit3, _unit4];
		[_deleteData, _lrrpPos, 30, 10] spawn RGGd_fnc_delete_whenNoPlayers; 
		deleteMarker "_dZone";
		deleteMarker "_lrrpPos";
		deleteMarker "_lrrpMrk";
		_chk = false;
	};

	_objects = _lrrpPos nearObjects 400;
	_cntO = count _objects;
	systemChat format ["Debug - LRRP - objects found: %1", _cntO];
	// check whether the box is in the zone - spawn intel and rerun FNC is yes 
	{
		// systemChat format ["objects: %1", _x];
		// make sure box is on the ground! 
		// get smoke on prox - send colour to telex, and also create different smoke as a trap 
		// give grid only, no markers 

		if (typeOf _x == "vn_b_ammobox_full_01") then {
			_boxPos = getPos _x;
			_alt = _boxPos select 2;
			if (_alt < 1) then {
				// pass _x to a delayDelete function 
				_deleteData pushBack [_x, _unit1, _unit2, _unit3, _unit4];
				[_deleteData, _lrrpPos, 300, 60] spawn RGGd_fnc_delete_whenNoPlayers; // send markerPos, 300m gap and 60 second cycle 

				// inform leaders 
				systemChat "Debug - LRRP Resupply - we have an ammo box!!";
				_tell = [];
				{
					// if role matches command or pilot, push to _tell then forEach the message to them only 
					_playerRole = roleDescription _x;
					if (
						(_playerRole == "Raptor 1 - Squadron Leader@Raptor") or 
						(_playerRole == "Raptor 2 - Squadron 2IC@Raptor") or 
						(_playerRole == "Viking 1:1 - Platoon Leader@Viking 1") or 
						(_playerRole == "Viking 1:2 - Platoon 2IC / Padre@Viking 1")
					) then {
						_tell pushBack _x;
					};
				} forEach allPlayers;

				// inform leadership only 
				{
					[[
						["Incoming Telex", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
						["Command has confirmed that LRRP ammunition supplies were delivered successfully", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
						["Telex End", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>", 30]
					]] remoteExec ["BIS_fnc_typeText", _x];   
				} forEach _tell;

				// accelerator 
				RGG_lrrpMulti = RGG_lrrpMulti + 1;

				deleteMarker "_dZone";
				deleteMarker "_lrrpPos";
				deleteMarker "_lrrpMrk";
				_chk = false;
			};
		};
		sleep 0.3;
	} forEach _objects;
	
	sleep 60;
};





