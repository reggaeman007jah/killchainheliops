/*
Move to LZ FNC 
Updated: 17 Oct 2023 
Purpose: When triggered will send all ARVN in AO to the closest designated LZ for extraction

*/

// for each group leader, get pos, and then send to their nearest LZ point  
// 

systemChat "running move LZ FNC";

// _groups = allGroups inAreaArray "redzone";
_arvnGroups = [];
{
	if (side _x == independent) then {
		_arvnGroups pushBackUnique _x;
	};
} forEach allGroups;
// _selection = allGroups select {side _x isEqualTo independent};
// systemChat format ["All ARVN Groups: %1", _arvnGroups];

// find nearest LZ for each group 
{
	// get group leader and leader pos 
	_ldr = leader _x;
	_ldrPos = getPos _ldr;

	// get all LZ markers and store 
	_lzMarkers = [];
	{
		_hook = _x select [0,2]; // i.e. looking for string == LZ 
		if (_hook == "LZ") then {
			_lzMarkers pushBack _x;
		};
	} forEach allMapMarkers;

	// it is important to limit the distance we should expect a group to travel to get to an LZ - if the nearest is still over 2km away, then do nothing 
	_nearestMarker = [_lzMarkers, _ldrPos] call BIS_fnc_nearestPosition;
	_lzPos = getMarkerPos _nearestMarker;
	_dist = _lzPos distance _ldrPos;
	if (_dist < 2000) then {
		// _x move _lzPos;
		// _x setFormation "diamond";	
		_name = markerText _nearestMarker;
		// check ownership, and if not owned by server, give it to the server 
		_clientID = groupOwner _x;
		// if (_clientID != 2) then {
		// 	_localityChanged = _x setGroupOwner 2;
		// 	systemChat format ["Changing locality of %1 to Server", _x];
		// } else {
		// 	systemChat format ["Locality of %1 is already Server", _x];
		// };
		[_x, _lzPos, _name] remoteExec ["RGGo_fnc_order_serverMove", 2]; // 2 = execute from server 
		// debug info:
		// systemChat format ["%1 is moving to %2 for extraction", _x, _name];
		// systemChat format ["Owner: %1", _clientID];
	};

} forEach _arvnGroups;


// [] remoteExec ["RGGo_fnc_order_moveLZ", 2];
// [1] remoteExec ["RGGp_fnc_patrol_routeManager", 2];

// _selection = allGroups select {side _x isEqualTo independent};

// ---

// _arvnGroups = [];
// {
// 	if (side _x == independent) then {
// 		_arvnGroups pushBackUnique _x;
// 	};
// } forEach allGroups;
// {
// 	_ldr = leader _x;
// 	_ldrPos = getPos _ldr;
// 	_lzMarkers = [];
// 	{
// 		_hook = _x select [0,2]; 
// 		if (_hook == "LZ") then {
// 			_lzMarkers pushBack _x;
// 		};
// 	} forEach allMapMarkers;
// 	_nearestMarker = [_lzMarkers, _ldrPos] call BIS_fnc_nearestPosition;
// 	_lzPos = getMarkerPos _nearestMarker;
// 	_x move _lzPos;
// 	_name = markerText _nearestMarker;
// 	systemChat format ["%1 is moving to %2 for extraction", _x, _name];
// 	_x setFormation "diamond";
// } forEach _arvnGroups;


	// systemChat format ["All _allLZIcons: %1", _lzMarkers];

	// debug check that dist calcs are working ok 
	// {
	// 	_markerPos = getMarkerPos _x;
	// 	systemChat format ["Marker: %1", _x];
	// 	systemChat format ["Marker Pos: %1", _markerPos];
	// 	systemChat format ["_ldrPos Pos: %1", _ldrPos];
	// 	_dist = _markerPos distance _ldrPos;
	// 	systemChat format ["Distance identified: %1", _dist];
	// 	systemchat "-------------";
	// } forEach _lzMarkers;

	// systemChat format ["_ldrPos Pos: %1", _ldrPos];

/*


	// cycle through all LZ markers at get dist from group leader pos 
	_closest = [];
	{
		_dist = _ldrPos distance _x;
		systemChat format ["%1 is %2 meters away", _x, _dist];
		_cnt = count _closest;
		if (_cnt > 0) then {
			// do calcs 
			if ((_closest select 0) > _dist) then {
				
			} else {
				
			};
		} else {
			// array is empty, store init value 
			_closest pushback _x;
		};
	} forEach _lzMarkers;






// get all indi group leaders in redzone 
_groups = allGroups inAreaArray "redzone";
_data = [];
{
	_ldr = leader _x;
	if (side _ldr == independent) then {
		_data pushBackUnique _ldr;
	};
} forEach _groups;



_inGroups = [];
{
	if ((side _x) == INDEPENDENT) then {_inGroups pushBack _x};
} forEach allGroups;
systemChat str _inGroups;

_ldrs = [];
{
	_ldr = leader _x;
	_ldrs pushBackUnique _ldr;
} forEach _inGroups;
systemChat str _ldrs;

{
	_pos = getPos _x;
	_smoke = createVehicle ["G_40mm_smokeYELLOW", _pos, [], 0, "none"]; 
	_rnd = selectRandom [0.5,1,1.5];
	sleep _rnd;
} forEach _ldrs;


_allLZIcons = ["LZ "] call BIS_fnc_getMarkers; // get all icon markers into an array based on LZ string argument 
RGG_triggerLZ = []; // to hold patrol LZ, all others are deleted 
{
	_num = _x select [3,1]; // number of LZ - e.g. 3 is patrol charlie, 4 is delta etc 
	if (_rStr isNotEqualTo _num) then {
		deleteMarker _x; // delete LZ 
	} else {
		RGG_triggerLZ pushBack _x;
	};
} forEach _allLZIcons; // i.e. 