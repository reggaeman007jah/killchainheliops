/*
Split Group FNC 
Updated: 21 Oct 2023 

Purpose: Takes a group, and checks size. Also takes a group limiter, to ensure all groups checked here are no bigger than given limiter 
*/

params ["_grp", "_limit"];

systemChat "running split-group checker";


if ((count (units _grp)) > _limit) then {
	// split this big mutha!
	systemChat format ["%1 is being split", _grp];
	_overflowGroup = createGroup [independent, true]; 
	{
		if (_forEachIndex > _limit) then {
			[_x] joinSilent _overflowGroup;
			systemChat "unit being sent to overflow";
			sleep 0.1;						
		};	
	} forEach (units _grp);
} else {
	systemChat format ["%1 does not need splitting", _grp];
};
_grp setFormation "DIAMOND";
	

/*
notes:
This could be improved by better managing possible numbers, so if it is given 30 units and a limit of 5, then we should here get 
6 groups. In this iteration you only end up with two .. so improve this later!


		