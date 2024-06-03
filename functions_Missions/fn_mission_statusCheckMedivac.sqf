/*
Status Check Medivac FNC 
Purpose: checks to see if the medivac mission is successful (within given time param)
Updated: 25 May 24 
Author: Reggs 

_units: array of units that have to be removed from area before things can progress 
_extractPos: anchor pos for checks 
_timeLimit = eg time this must be done by before being marked as failure 
*/

params ["_units", "_extractPos", "_timeLimit", "_raptorNum"];

systemChat "Running status check Medivac";
systemChat format ["Units needing extraction: %1", (count _units)];


_it = 0;
_check = true;
while {_check} do {
	
	_it = _it + 1;
	systemChat format ["DEBUG - statusCheckMedivac cycle on pos: %1", _extractPos];

	_data = [];
	{
		_distance = (getPos _x) distance _extractPos;
		if ((_distance < 500) && (alive _x)) then {
			_data pushBack _x;
		};
	} forEach _units;

	systemChat format ["DEBUG - statusCheckMedivac count _data: %1", (count _data)];

	if ((count _data) == 0) then {
		systemChat "DEBUG - statusCheckMedivac - good to progress delete_allWithinArea";
		[_extractPos, 500, 1500, 30, _raptorNum] spawn RGGd_fnc_delete_allWithinArea; // deletes all in mission area when all units have left AO - make sure playerProx check is solid here! 

		// try this to manage deletion of boarding markers, if they are KIA before the marker could be deleted normally 
		// {
		// 	deleteMarker (str _x);
		// 	systemChat format ["Deleting marker: %1", (str _x)];
		// } forEach _units;

		_check = false;
	} else {
		// units are still in the AO! - remove this when happy 
		systemChat format ["DEBUG - statusCheckMedivac - Cannot delete_allWithinArea, as injured units are still near to the extract pos: %1", _extractPos];
		// make them move to LZ 
	
		{
			_distance = (getPos _x) distance _extractPos;
			if ((_distance < 100) && (alive _x) && (((getPos _x) select 2) < 2)) then {
				_x doMove _extractPos; /// makr this a circle!
			};
		} forEach _units;

		// ten minute timeout 
		if (_it > 2) then {
			// any boarder still on the ground will bleed out 
			{
				if (vehicle _x == _x) then {
					_distance = (getPos _x) distance _extractPos;
					// if ((_distance < 100) && (alive _x) && (_x != (vehicle _x))) then {
					if ((_distance < 100) && (alive _x)) then {
						_x setDamage 1;
						systemChat "unit bled out";
					};
				};	
				sleep random 3;
			} forEach _units;

		};
	};

	// add timelimit check, to generate a failstate 

	sleep 60;
};

