/*
VC Intel (Trap Fields)
Updated: 18 May 2022 
This is triggered on successful delivery of food to a village 

*/

sleep 60;


_tell = [];
{
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

{
	[[
		["Incoming Telex", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
		["ARVN Command have received intelligence on a minefield near your current objective", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
		["Your combat documents have been updated", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
		["Telex End", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>", 30]
	]] remoteExec ["BIS_fnc_typeText", _x];   
} forEach _tell;

_markers = allMapMarkers;
{
	if (_x == "trapField") then {
		systemChat "we have trap intel";
		_pos = getMarkerPos _x;
		deleteMarker "warningTraps"; 
		_objective1 = createMarker ["warningTraps", _pos];
		_objective1 setMarkerType "MinefieldAP";
	};
} forEach _markers;

"trapfield" setMarkerColor "ColorRed";
"trapfield" setMarkerAlpha 0.7;