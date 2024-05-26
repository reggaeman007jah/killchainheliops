/*
Show Map Markers 
Updated: 18 May 2022 
Purpose: This system will cycle on an always loop, showing locations of indifor and blufor group leaders 
Author: Reggs 
*/

sleep 20; 

if (KILLCHAINISLIVE) then {
	while {KILLCHAINISLIVE} do {

		_groups = allGroups; 
		private _RGG_bluforGroups = []; 
		private _RGG_indiforGroups = []; 
		{
			switch ((side _x)) do {
				case INDEPENDENT: { _RGG_indiforGroups pushBackUnique _x };
				case WEST: { _RGG_bluforGroups pushBackUnique _x };
			};
		} forEach _groups;

		{
			_size = count units _x; 
			if (_size > 0) then {
				_leader = leader _x;
				_leaderPos = getPos _leader;
				if (_leaderPos inArea "pathfinderBase") then {

				} else {
					_stampToString = str _x;
					deleteMarker _stampToString;
					_tempMarker = createMarker [_stampToString, _leaderPos];
					_tempMarker setMarkerType "n_inf";
					_sizeStr = str _size;
					_stampToString2 = _stampToString + " ¦ " + _sizeStr + " UNITS"; 
					_tempMarker setMarkerText _stampToString2;
				};
			} else {
				_stampToString = str _x;
				deleteMarker _stampToString;
			};
		} forEach _RGG_indiforGroups;

		{
			_size = count units _x; 
			if (_size > 0) then {
				_leader = leader _x;
				_leaderPos = getPos _leader;
				_zPos = _leaderPos select 2;
				if (_zPos < 10) then {
					_testDel = typeOf _leader;
					if ((_testDel != "vn_b_men_jetpilot_10") and (_testDel != "vn_b_men_lrrp_01")) then {
						_stampToString = str _x;
						deleteMarker _stampToString;
						_tempMarker = createMarker [_stampToString, _leaderPos];
						_tempMarker setMarkerType "b_inf";	
					};
				};			
			} else {
				_stampToString = str _x;
				deleteMarker _stampToString;
			};
		} forEach _RGG_bluforGroups;

		sleep 0.5;
	};
};

