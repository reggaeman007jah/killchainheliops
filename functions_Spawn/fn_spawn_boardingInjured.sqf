/*
spawn_boardingInjured FNC
Updated: 24 May 24 
Purpose: Spawns in injured units who await a heli to land nearby, to which they will board  
Author: Reggs 

_extractPos = spawnpoint of extraction 
_numInj = passed number of injured to pickup 
*/

params ["_extractPos", "_numInj", "_raptorNum"];

// check helis nearby and create units based on that number? For now keep as a set 4-6

_toBoard = [];

for "_i" from 1 to _numInj do {
	systemChat "creating injured unit";
	_indiGroup = createGroup west;
	_class = [] call RGGg_fnc_get_randomArmyClassname;  
	_pos = _extractPos getPos [(random 15), (random 359)];
	_unit = _indiGroup createUnit [_class, _pos, [], 0.1, "none"]; 
	_toBoard pushBack _unit;

	{
		_unit removeItems _x
	} forEach ["vn_b_item_firstaidkit","vn_o_item_firstaidkit","FirstAidKit","Medikit","vn_b_item_medikit_01"];

	_mags = magazines _unit;
	{
		_unit removeMagazineGlobal _x; // to prevent them from enagaging, and makes them board quicker 
	} forEach _mags;


	_unit setDamage (selectRandom [0.7, 0.8, 0.9]);
	_unit setUnitPos (selectRandom ["middle"]);
	sleep 0.3;
};

// success/fail checker, with follow-on delete FNC 
[_toBoard, _extractPos, 10, _raptorNum] spawn RGGm_fnc_mission_statusCheckMedivac;



// this next FNC is run on each unit individually, to manage the fact that multiple helis / players may be picking up .. 
// so each unit has to behave independently of the others
{
	[_x] spawn RGGo_fnc_order_autoBoard; 
} forEach _toBoard;

// ["_anchor", "_minEnemy", "_maxEnemy", "_minDist", "_maxDist", "_playerProxTrig", "_moveIn", "_grouped"] RGGs_fnc_spawn_hotLZ;
[_extractPos, 10, 20, 100, 120, 10, false, false] spawn RGGs_fnc_spawn_hotLZ; // make random 

// audio exchange between patrol and copilot

{
	{playSound "v1_rapAck"} remoteExec ["call", _x];
} forEach allPlayers;

sleep 5;

{
	{playSound "cp_goAheadV1"} remoteExec ["call", _x];
} forEach allPlayers;

sleep 2;


_sel = selectRandom [1,2,3];
switch (_sel) do {
	case 1: { { {playSound "v1_woundedYellowA"} remoteExec ["call", _x];} forEach allPlayers; };
	case 2: { { {playSound "v1_woundedYellowB"} remoteExec ["call", _x];} forEach allPlayers; };
	case 3: { { {playSound "v1_woundedYellowC"} remoteExec ["call", _x];} forEach allPlayers; };
	default { };
};

sleep 6;

{
	{playSound "cp_copyYellowOut"} remoteExec ["call", _x];
} forEach allPlayers;

