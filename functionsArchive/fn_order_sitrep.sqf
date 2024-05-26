/*
TINMAN BASIC - Sitrep FNC 
Updated: 31 Oct 2023 

Purpose: Simply confirms overall numbers of troops in redzone

Action November 2021 - remove (and test ok) systemChat messages 
Action November 2021 - complete UI display for group data 
*/

_unitsRedzone = allUnits inAreaArray "redzone";
	
// Redzone stats 
_redzoneIndi = 0;
{
	switch ((side _x)) do
	{
		case INDEPENDENT: {_redzoneIndi = _redzoneIndi + 1};
	};
} forEach _unitsRedzone;

if (_redzoneIndi > 0) then {
	// format ["ARVN Units in AO: %1", _redzoneIndi] remoteExec ["systemChat", -2];
	["Indi Units in AO: %1", _redzoneIndi] call RGGi_fnc_information_leadershipGroup;
	// "Bravo 3 out" remoteExec ["systemChat", 0, true];
} else {
	// "No Indifor in AO!" remoteExec ["systemChat", -2, true];
	["No Indifor in AO!"] call RGGi_fnc_information_leadershipGroup;
};

// use -2 here?
// do better display of information 
_allGrps = allGroups select { side _x isEqualTo independent };
_commPos = [] call RGGg_fnc_get_tinmanPos;
_objPos = getMarkerPos 'REDZONE';

_data = [];
{
	_leader = leader _x;
	_leaderPos = getPos leader _x;
	_units = units _x;
	_cnt = count _units;
	_distPL = _leaderPos distance _commPos;
	_distObj = _leaderPos distance _objPos;
	_injured = [];
	{
		_dam = damage _x;
		if (_dam > 0.8) then {
			_injured pushBack _x;
			systemChat format ["DEBUG - SITREP - Injured Unit: %1", _x];	
		};
	} forEach _units;
	_cntInj = count _injured;

	// now move injured to designated extract area 
	// consider separate groups for this action 
	{
		if (_cntInj > 0) then {
			// put into new group 
			_grp = createGroup [independent, true];
			[_x] joinSilent _grp;
			_moveTo = getMarkerPos "medicalLZ";
			_x doMove _moveTo;
			systemChat format ["DEBUG - SITREP - Unit: %1 moving to extract LZ", _x];	
		};
	} forEach _injured;

	_inRed = _leaderPos inArea "redzone";
	if (_inRed) then {
		_data pushBack [_x, _leader, _leaderPos, _cnt, _cntInj, _distPL, _distObj];
	};
	/*
	Group Name: 
	Group Leader Name:
	Group Leader Position:
	Units in Group:
	Number of badly injured:
	Distance of group from PL:
	Distance of group from Obj:
	Ammo count: TBC 
	Send - [_x]
	*/
} forEach _allGrps;

// send _data to display function 
[_data] call RGGi_fnc_information_sitrep;

// _inRed = _commPos inArea "redzone";