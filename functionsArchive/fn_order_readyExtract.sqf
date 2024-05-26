/*
Ready Extract FNC
Updated: 24 May 2022

This system will aim to send all ARVN to a location ready for extraction - this is to inform numbers for future missions 
and depends on whether we aim to use persistance (of stats, RF etc). 

I want to gather all groups, send to a suitable empty and open location (maybe one hard-coded, and linked to the last OBJ of the route),
and await pickup - this may enable a last task for others who want a little flight action. 

It would be good to batch them into groups of 11, for hueys 
Or maybe, manage groupings based on available cargo, to enable different helis to be involved 

I need to design a place to unload cargo - anywhere at base probably, rather than a set LZ point  


*/

// send all indifor groups to a pre-set LZ  

// have a way to track groups - ensure this is still on 

// have extracts of these groups be part of the mission, with blufor left last on the ground maybe 

// have timer system, so that after x time, area is overrun 

// increase arty in area while this happens 


// copied from old script, below:
_initStartPos = getPos ammo1;
_indi = [];
_units = allUnits inAreaArray "objective 1";

{ if ((side _x) == INDEPENDENT) then {_indi pushBack _x} } forEach _units;

{
	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
	_endPoint1 = _initStartPos getPos [_randomDist,_randomDir];
	sleep 2;
	_x setBehaviour "AWARE";
	_x doMove _endPoint1;
} forEach _indi;