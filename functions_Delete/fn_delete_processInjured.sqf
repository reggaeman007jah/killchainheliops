/* 
Process injured 
Updated: 11 May 2022

*/

params ["_injured"];
_checkThis = side _injured;

_anchor = getMarkerPos "processInjured";
_near = [];  
_check = true;
while {_check} do {
	{
		_near = [];
		_pos = getPos _x;
		_dist = _pos distance _anchor;
		if (_dist < 100) then {
			_near pushBack _x; 
		};
	} forEach allPlayers;

	_cnt = count _near;
	if (_cnt == 0) then {
		_check = false;
	};
	sleep 10;
};

if ((side _injured) == CIVILIAN) then {
	RGG_civviesSaved = RGG_civviesSaved + 1;
	publicVariable "RGG_civviesSaved";
	deleteVehicle _injured;
};
if ((side _injured) == independent) then {
	RGG_availableIndifor = RGG_availableIndifor + 3;
	publicVariable "RGG_availableIndifor";
	profileNamespace setVariable ["RGG_availableIndifor", RGG_availableIndifor];
	deleteVehicle _injured;
};
if ((side _injured) == west) then {
	deleteVehicle _injured;
};


