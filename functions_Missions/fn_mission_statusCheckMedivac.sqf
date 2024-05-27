/*
Status Check Medivac FNC 
Purpose: checks to see if the medivac mission is successful (within given time param)
Updated: 25 May 24 
Author: Reggs 

_units: array of units that have to be removed from area before things can progress 
_extractPos: anchor pos for checks 
_timeLimit = eg time this must be done by before being marked as failure 
*/

params ["_units", "_extractPos", "_timeLimit"];

_check = true;
while {_check} do {
	
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
		[_extractPos, 500, 1500, 30] spawn RGGd_fnc_delete_allWithinArea; // deletes all in mission area when all units have left AO - make sure playerProx check is solid here! 
		_check = false;
	} else {
		// units are still in the AO! - remove this when happy 
		systemChat format ["DEBUG - statusCheckMedivac - Cannot delete_allWithinArea, as injured units are still near to the extract pos: %1", _extractPos];
		// make them move to LZ 
		// adjust health? 
	};

	// add timelimit check, to generate a failstate 

	sleep 60;
};

