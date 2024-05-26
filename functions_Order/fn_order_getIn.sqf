/*
Get in 
Updated: 19 Oct 2023 

Summary:
	This will enable any player (eventually only of certain rank) to land near any group of units, and 
	have them board their vehicle on keypress  

Action:
	Ensure we ignore any units that are in a vehicle already!!!!
	How do we manage multiple player pickups in close prox? global ignore array?

Notes:
	This operates in the player's namespace, so we can refer to the command 'player' here 
	Change this so that you 'can' pick up units at Pathfinder - leave for now though for testing 
	Or maybe have only designated PZs at Pathfinder?

*/

_name = str player;
_pos = getPos player;
_vic = vehicle player; 
_oldGrpsToDel = []; // only delete these groups if have no units - checker below

// ---------------
private _getInFnc = {
    params ["_unit", "_heli"];
	_unit assignAsCargo _heli;
	[_unit] orderGetIn true;
};

// _grp = createGroup [west, true];
// _spawn = [11227.4,1864.83,0.9]; 

// for "_i" from 1 to _freeCargoPositions do {
// 	_unit = _grp createUnit [(selectRandom _classes), _spawn, [], 0.1, "none"]; 
// 	bluforZeus addCuratorEditableObjects [[_unit], true];
// 	[[_unit, _heli], _getInFnc] remoteExec ['bis_fnc_call', _unit];
// 	sleep 1.4;
// };

// ---------------
if (_pos inArea "pathfinderBase") then {
	systemChat "you can't pick up units at PF, unless at the main ARVN PZ";
	systemChat "you can only drop off";
} else {
	if (_vic isKindOf "helicopter") then { // check is near ground 
		if ((_pos select 2) < 5) then { // ok to board
			_seats = _vic emptyPositions "cargo";
			if (_seats > 0) then { // you have seats 

				systemChat format ["Free seats in cargo: %1", _seats];
				// [_vic, 1] spawn RGGe_fnc_effects_cargoCheck; // checker 

				_NFZ1 = createMarker [_name, _pos];
				_NFZ1 setMarkerShape "ELLIPSE";
				_NFZ1 setMarkerColor "colorRed";
				_NFZ1 setMarkerSize [50, 50];
				_NFZ1 setMarkerAlpha 0.3;

				// get friendly units  
				_units = allUnits inAreaArray _NFZ1;				
				_indiUnits = [];
				{
					// if ((side _x == independent) or (side _x == west)) then {
					if (side _x == independent) then {
						if (isNull objectParent _x) then {						
							_indiUnits pushBack _x;	
						};
					};
				} forEach _units;
				systemChat format ["There are %1 ARVN units at your LZ", (count _indiUnits)];

				/*
				the checker below is useful, but I have bigger problems rn so am removing for now 
				*/
				// [_vic, 1, (count _indiUnits)] spawn RGGe_fnc_effects_cargoCheck; // checker 

				if ((count _indiUnits) <= _seats) then {
					systemChat "there is room for all to board - create a group just in case the identified units span multiple groups";
					// example: if a unit is in the zone, but their group leader is not .. will lead to the unit running off to regroup on landing 
					_newBoardingGroup = createGroup [independent, true]; // this is duplicated below !! make better 
					systemChat format ["_newBoardingGroup created: %1", _newBoardingGroup];
					
					// _oldGrpsToDel = []; // only delete these groups if have no units - checker below 
					// removed the above, check all works ok, then delete 
					{
						_grp = group _x;
						_oldGrpsToDel pushBackUnique [_grp, (str _grp)]; // sending the group and the string of the group 							
					} forEach _indiUnits;

					{
						[_x] joinSilent _newBoardingGroup;				
					} forEach _indiUnits;

					// {
					// 	_x assignAsCargo _vic;
					// 	[_x] orderGetIn true;
					// } forEach _indiUnits;

					// -----------

					{
						[[_x, _vic] , _getInFnc] remoteExec ['bis_fnc_call', _x];    
						// _unloaded pushBack _x; 
						sleep .7;
					} forEach _indiUnits;
					// -----------

					deleteMarker _name;

					[_vic, 5, 20, [_newBoardingGroup, 5, 10], RGGu_fnc_utilities_strayCheck] spawn RGGu_fnc_utilities_altCheck; // altitude checker 
					// [_newBoardingGroup, 30, 100] spawn RGGu_fnc_utilities_strayCheck; // stray checker - prevents stupid regroup movements 

				} else {
					_newWaitingGroup = createGroup [independent, true]; // new empty group - we know this is needed as there are more units here than seats 
					_newBoardingGroup = createGroup [independent, true]; 
					systemChat format ["_newWaitingGroup created: %1", _newWaitingGroup];
					systemChat format ["_newBoardingGroup created: %1", _newBoardingGroup];
					// there may be one or multi groups at an LZ - so to keep things simple - if you cannot get everyone aboard .. 
					// merge all groups into 1 (if more than one group), then make a new boarding group and board just that group 

					{
						_grp = group _x;
						_oldGrpsToDel pushBackUnique [_grp, (str _grp)]; // sending the group and the string of the group 		
						[_x] joinSilent _newWaitingGroup;						
					} forEach _indiUnits;
					// now we have one group - that is more than the seats available - but at least one group to work with 

					// testing - count and display group size here 
					// systemChat format ["_oldGrpsToDel: %1", _oldGrpsToDel];
					_newWaitingGroupSize = count (units _newWaitingGroup);
					_newBoardingGroupSize = count (units _newBoardingGroup);
					systemChat format ["_newWaitingGroupSize: %1", _newWaitingGroupSize];
					systemChat format ["_newBoardingGroupSize: %1", _newBoardingGroupSize];

					{
						if (_forEachIndex < _seats) then {
							[_x] joinSilent _newBoardingGroup;
							systemChat format ["_x: %1", _x];
							sleep 0.1;						
						};					
					} forEach (units _newWaitingGroup);

					systemChat "done sorting";

					_newWaitingGroupSize = count (units _newWaitingGroup);
					_newBoardingGroupSize = count (units _newBoardingGroup);
					systemChat format ["_newWaitingGroupSize: %1", _newWaitingGroupSize];
					systemChat format ["_newBoardingGroupSize: %1", _newBoardingGroupSize];

					{
						_x assignAsCargo _vic;
						[_x] orderGetIn true;
					} forEach (units _newBoardingGroup);
					deleteMarker _name;

					[_newWaitingGroup, 15] spawn RGGo_fnc_order_splitGroup; // sorts out any groups that are too big now as a result of unit consolidation
					[_vic, 5, 20, [_newBoardingGroup, 5, 10], RGGu_fnc_utilities_strayCheck] spawn RGGu_fnc_utilities_altCheck; // altitude checker 
					// [_newBoardingGroup, 30, 100] spawn RGGu_fnc_utilities_altCheck; // stray checker 
				};

				// tidy up any empty group markers 
				systemChat "running group count check to del";
				systemChat format ["_oldGrpsToDel array: %1", _oldGrpsToDel]; // contains name str of all old markers to be del 
				{
					if (isNull (_x select 0) or (count units (_x select 0) == 0)) then {
						systemChat format ["deleting %1 as in null or zero units", (_x select 1)];
						deleteMarker (_x select 1);
					} else {
						systemChat format ["%1 is not deleted as has some units left", (_x select 0)];
					};		
					sleep 1;		
				} forEach _oldGrpsToDel;
				
				// final boarding debug 
				// _seats = _vic emptyPositions "cargo";
				// systemChat format ["Final Debug Check - Free seats in cargo: %1", _seats];

			} else {
				// you have no seats 
				systemChat "you dont have any free seats";
			};
		} else {
			// not ok to board 
			systemChat "you are too high";
		};
	} else {
		// not in heli 
		systemChat "u r not in heli";
	};
};	



// now check is over, we trigger strayCheck FNC fn_utilities_strayCheck



