/*
Show OPFOR Groups FNC 
Updated: 23 May 2022

When run, this will show to all players the location of all opfor groups in-game 
*/

_groups = allGroups; 
private _RGG_opforGroups = []; 
_markers = [];
_delay = selectRandom [60,120,180];

sleep _delay;

{
	switch ((side _x)) do {
		case EAST: { _RGG_opforGroups pushBackUnique _x };
	};
} forEach _groups;

{
	_size = count units _x; 
	if (_size > 3) then {
		_leader = leader _x;
		_leaderPos = getPos _leader;
		_stampToString = str _x;
		_tempMarker = createMarker [_stampToString, _leaderPos];
		_tempMarker setMarkerType "o_inf";
		_tempMarker setMarkerText _stampToString;
		[180, _stampToString] spawn RGGd_fnc_delete_marker;
	};
} forEach _RGG_opforGroups;

{
	[[
		["Incoming Telex", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
		["ARVN Command have received intelligence on NVA Groups advancing on your position", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
		["Your combat documents have been updated, tell your soldiers to check their maps", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
		["Telex End", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>", 30]
	]] remoteExec ["BIS_fnc_typeText", _x];   
} forEach allPlayers;

_cnt = count RGG_AmmoCache;
if (_cnt > 0) then {
	{
		_pos = getPos _x;
		_stampToString = str _x;
		_tempMarker = createMarker [_stampToString, _pos];
		_tempMarker setMarkerType "loc_destroy";
		[180, _stampToString] spawn RGGd_fnc_delete_marker;
	} forEach RGG_AmmoCache;
};





