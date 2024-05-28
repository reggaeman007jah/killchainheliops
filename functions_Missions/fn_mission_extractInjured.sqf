/*
Medivac Mission FNC 
Purpose: Generates random Medivac mission 
Updated: 25 May 24 
Author: Reggs 

_extractPos: position of mission 
_cycleLimit: not currently used 
_lzRef: used for announcement to player 
_missionType: used for announcement to player 
_currentHeat: used for announcement to player 
*/

params ["_extractPos", "_cycleLimit", "_lzRef", "_missionType"];

systemChat "running FNC extractInjured";

_proxCheck = true;
while {_proxCheck} do {
	_data = [];
	{
		_distance = (getPos _x) distance _extractPos;
		if (_distance < 1000) then {
			_data pushBack _x;
		};
	} forEach allPlayers;

	_cnt = count _data;
	if (_cnt == 0) then {
		_proxCheck = false;
		// systemChat "DEBUG - a new mission is generated as there are no players near to the selected mission position";
		[_lzRef, _missionType] call RGGm_fnc_mission_announcer;
	} else {
		systemChat "DEBUG - a new mission cannot be generated yet as there is at least one player too near to the selected position";
	};

	sleep 30;
};

// note while this solves the issue of a mission being generatedd under the feet of players ie it could be close to where they are while they are RTB, 
// it could still generate a mission that can't be met as they are still having to fly over the spot with cargo.
// this can stay here, does not do any harm, but a better solution is needed, ideally one that generates a new mission when the heli/s are all in base 

// the auto-delete that gets triggered when players fly overhead but can't attend, perhaps that can only happen, ie be triggered, when at least one heli is close to 
// ground, indicating a probable site attend ..

_cycle = 0;
_checkCycle = true;
while {_checkCycle} do {	

	_cycle = _cycle + 1;
	{
		if ((_extractPos distance (getPos _x)) < 1600) exitWith {
			_checkCycle = false;
			[_extractPos] spawn RGGs_fnc_spawn_advanceTeam;
			[_extractPos] spawn RGGs_fnc_spawn_boardingInjured;

			// maybe here, the deleteAllWithinArea needs to be linked to the created units for pickup - so checkCycle to see if any are on ground 
			// if all units are removed from area, or dead, then delete can occur, and new mission created, from the delete FNC 

			// [_extractPos, 500, 1500, 30] spawn RGGd_fnc_delete_allWithinArea; // deletes all in mission area when all players have left AO 
			// start mission timer here for landing and pickup - this can be easy or hard, and give context like, be quick as NVA are approaching the LZ 
			// inform all pilots that clock is ticking 
			// run successChecker here if not part of the mission timer 
		};
		sleep 1;
	} forEach allPlayers; 

	// if (_cycle > _cycleLimit) then {
	// 	// mission has failed as took too long to get to site  
	// };

	sleep 10;
}; 

// checkCycle is used to time-limit the mission, and while you could be clever and calc time to get to site va distance (giving longer times for further away places, 
// for now this will be more of a safety net to prevent an endless checkLoop
// based on a 10-second cycleTime, if the passed _cycleLimit is 30, then that means the time limit is 300 seconds / 5 mins 


// old 
/*
This function generates a random medevac mission 

To-do:

side note - can you disable death and instead have a one-life system with AIS, to enforce medevac back to base for real heal? 
players get a notification with a location - go to 1234 1234 for pickup of walking wounded 

side note - can also enable ammo drops using similar system 
side note - dont forget padre system - dialog to request pickup, drop off, cas, ammo drop, medevac, patrol, scout etc 
side note - dont forget LZ assist - global system to share locational data across helis 
side note - dont forget in-air tracking, to track speed, heading and owner of heli nearby 

you go there 
injured boards heli 
defensive perimiter is there already 
spawn in enemy on approach 
set damage false on all units in that area - this is an effect thing 
ensure lots of machine gunners on both sides 
when near - auto smoke nearby 
when land - injured board 
take off and land at medi-base where they disembark and head into medi tent 
have white coats come out to greet also - like mash 
build system to nuke all when no players are near 

*/

// gen random pos 
// gen units + injured units 
// gen marker 

// sleep 2;
// systemChat "DEBUG - RUNNING: missions_extractInjured";

// this should be informed by the dropping of a medical container 
// container drop should build a medical FOB 
// medical FOB is then the anchor for missions 
// missions must always be at least 1km away from anchor, no more than 4km 

// _areaCenter = _this select 0;
// _extractPos = _this select 0;

// _extractPos = [_areaCenter, 1000, 3000, 40, 0, 1, 0] call BIS_fnc_findSafePos;

// the welcome party switch will determine if the ambush happens on landing, on approach, or whether opfor are way further out as heli approaches 
// private "_actDist";
// switch (_welcomeParty) do {
// 	case "1": { _actDist = 20 }; // waits for landing before ambush - so sets activation var to small - needs a z value here 
// 	case "2": { _actDist = 100 }; // triggers an attack on close approach - so sets activation var to medium
// 	case "3": { _actDist = 500 }; // triggers an attack on long approach - so sets activation var to large 
// 	default { systemChat "Switch Error _trogActDist" };
// };


// MEDEVAC = true; // for marker system 
// ["MEDEVAC", _extractPos, "hd_pickup", "MEDEVAC_Marker", "colorRed"] spawn RGGe_fnc_effects_markers;


// for "_i" from 1 to 10 do {
// 	_indiGroup = createGroup west;
// 	_class = [] call RGGg_fnc_get_randomArmyClassname;  
// 	_unit = _indiGroup createUnit [_class, _extractPos, [], 0.1, "none"]; 
// 	_randomMovePos = [ ["EXTRACT"] ] call BIS_fnc_randomPos;
// 	_unit doMove _randomMovePos;
// 	_stance = selectRandom ["middle", "down"];
// 	_unit setUnitPos _stance;
// 	sleep 0.2;
// };


// // smoke trigger 
// _trgSmk = createTrigger ["EmptyDetector", _extractPos];
// _trgSmk setTriggerArea [1000, 1000, 0, false];
// _trgSmk setTriggerActivation ["ANYPLAYER", "PRESENT", true];
// _trgSmk setTriggerStatements ["this", "
// 	_smoke = createVehicle ['G_40mm_smokeYELLOW', _extractPos, [], 0, 'none']; 
// ", "systemChat 'no player near'"];

// // attack manager 
// attackNow = false;

// _trg = createTrigger ["EmptyDetector", _extractPos];
// _trg setTriggerArea [_actDist, _actDist, 0, false];
// _trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
// _trg setTriggerStatements ["this", "
// 	systemChat 'DEBUG - created trigger activator';
// 	_allUnitsX = allUnits inAreaArray 'BATTLEZONE';
// 	{
// 		_x enableAI 'MOVE';
// 		_x setBehaviour 'COMBAT';
// 		_x setCaptive false;
// 		_x setUnitPos 'AUTO';
// 	} forEach _allUnitsX;
// 	attackNow = true;
// ", "systemChat 'no player near'"];

// waitUntil { attackNow; };

// create attacks here 

// MEDEVAC = false;

// note - add checker before things start here, to make sure there are no platers near 

// note: _lzRefStr, _missionType, _currentHeat are used for the announcement to players 