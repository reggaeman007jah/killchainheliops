/*
Boarding Indifor FNC 
Updated: 01 Oct 2023 

Purpose: Spawns and auto-boards indifor onto player's heli 

Notes:
This is a key element of Killchain. This system should enable players to use any heli to land on a designated 
PZ, where the function would check for free seats, spawn that number of AI, and have them board the heli automatically.

This is run from one of the few in-mission trigger zones, at the main base.

The function takes the pilot and the heli being used, then calcs the number of free positions 
It then uses a CANBOARD bool to prevent confusion if a second player-pilot lands at the LZ - first heli must be 30m 
away 2d before more units can board a new heli 

Then it checks that there are enough reinforcements available (RGG_availableIndifor).

There is a hard-coded location pos used as a spawn point. A group is created with a unique name. 

Each unit created has an EH added, to track when he has been killed.

Action: Classnames are hardcoded here - this should be done elsewhere.
Action: CANBOARD is used elsewhere and may cause conflicts if used at the same time!! 
Action: Group naming is far too complex 
Action: are the groups always the same or is every spawn iteration totally random across four group classes?
*/

params ["_pilot", "_heli", "_spawnPos"];

CANBOARD2 = false;
// format ["DEBUG: Pickup System / CANBOARD2: %1", CANBOARD2] remoteExec ["systemChat", 0]; 
// format ["DEBUG: Pickup System / CANBOARD2: %1 %2", _pilot, _heli] remoteExec ["systemChat", 0]; 

// format [
// 	"DEBUG: Pickup System / Running fn_boardIndifor.sqf / _pilot: %1 / _heli: %2 / _spawnPos: %3", 
// 	_pilot, 
// 	_heli, 
// 	_spawnPos
// ] remoteExec ["systemChat", 0]; 

_freeCargoPositions = _heli emptyPositions "cargo";
// format ["DEBUG: Pickup System / _freeCargoPositions: %1", _freeCargoPositions] remoteExec ["systemChat", 0]; 

if (_freeCargoPositions == 0) then {	
	if !(isNull objectParent _pilot) then {
		// [[
		// 	["Incoming Telex", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
		// 	["YOUR HELICOPTER HAS NO FREE SEATS", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
		// 	["Telex End", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>", 30]
		// ]] remoteExec ["BIS_fnc_typeText", _pilot]; 
		["<t size='0.8' color='#ffffff' font='PuristaMedium' >YOUR HELICOPTER HAS NO FREE SEATS</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", _pilot];
		_checkCanRedeploy = true;
		// format ["DEBUG: Pickup System / _checkCanRedeploy: %1", _checkCanRedeploy] remoteExec ["systemChat", 0]; 
		while {_checkCanRedeploy} do {
			_heliPos = getPos _pilot;
			_distance = _heliPos distance _spawnPos;
			if (_distance > 30) then {
				_checkCanRedeploy = false;
				// format ["DEBUG: Pickup System / _checkCanRedeploy: %1", _checkCanRedeploy] remoteExec ["systemChat", 0]; 
				CANBOARD2 = true;
				// format ["DEBUG: Pickup System / CANBOARD: %1", CANBOARD] remoteExec ["systemChat", 0]; 
			};
			sleep 3;
		}; 
	} else {
		CANBOARD2 = true;
		// format ["DEBUG: Pickup System / CANBOARD: %1", CANBOARD] remoteExec ["systemChat", 0]; 
	};
} else {

	if (RGG_availableIndifor > 0) then {
	// format ["DEBUG: Pickup System / RGG_availableIndifor: %1", RGG_availableIndifor] remoteExec ["systemChat", 0]; 
		// add a arvn cap check here 

		_float = diag_tickTime;
		_stampToString = str _float;
		_stampToString = createGroup [independent, true];
		_stampToString setFormation "DIAMOND";

		_classes1 = [
			"vn_i_men_sf_02",
			"vn_i_men_sf_01",
			"vn_i_men_sf_03",
			"vn_i_men_sf_04",
			"vn_i_men_sf_05",
			"vn_i_men_sf_06",
			"vn_i_men_sf_07",
			"vn_i_men_sf_08",
			"vn_i_men_sf_09",
			"vn_i_men_sf_10",
			"vn_i_men_sf_11",
			"vn_i_men_sf_12"
		];

		_classes2 = [
			"vn_i_men_marine_09",
			"vn_i_men_marine_05",
			"vn_i_men_marine_02",
			"vn_i_men_marine_08",
			"vn_i_men_marine_03",
			"vn_i_men_marine_15",
			"vn_i_men_marine_16",
			"vn_i_men_marine_18",
			"vn_i_men_marine_11",
			"vn_i_men_marine_06",
			"vn_i_men_marine_07",
			"vn_i_men_marine_17",
			"vn_i_men_marine_20",
			"vn_i_men_marine_10",
			"vn_i_men_marine_04",
			"vn_i_men_marine_21"
		];

		_classes3 = [
			"vn_i_men_army_01",
			"vn_i_men_army_14",
			"vn_i_men_army_03",
			"vn_i_men_army_04",
			"vn_i_men_army_05",
			"vn_i_men_army_06",
			"vn_i_men_army_07",
			"vn_i_men_army_08",
			"vn_i_men_army_09",
			"vn_i_men_army_10",
			"vn_i_men_army_11",
			"vn_i_men_army_11",
			"vn_i_men_army_12",
			"vn_i_men_army_16",
			"vn_i_men_army_17",
			"vn_i_men_army_18",
			"vn_i_men_army_07",
			"vn_i_men_army_19",
			"vn_i_men_army_20",
			"vn_i_men_army_10",
			"vn_i_men_army_21",
			"vn_i_men_army_12",
			"vn_i_men_army_11"
		];

		_classes4 = [
			"vn_i_men_ranger_01",
			"vn_i_men_ranger_14",
			"vn_i_men_ranger_03",
			"vn_i_men_ranger_04",
			"vn_i_men_ranger_05",
			"vn_i_men_ranger_06",
			"vn_i_men_ranger_07",
			"vn_i_men_ranger_08",
			"vn_i_men_ranger_09",
			"vn_i_men_ranger_10",
			"vn_i_men_ranger_11",
			"vn_i_men_ranger_11",
			"vn_i_men_ranger_12",
			"vn_i_men_ranger_16",
			"vn_i_men_ranger_17",
			"vn_i_men_ranger_18",
			"vn_i_men_ranger_07",
			"vn_i_men_ranger_19",
			"vn_i_men_ranger_20",
			"vn_i_men_ranger_10",
			"vn_i_men_ranger_21",
			"vn_i_men_ranger_12",
			"vn_i_men_ranger_11"
		];

		_cargo = [];

		for "_i" from 1 to _freeCargoPositions do {
			if ((RGG_availableIndifor > 0)) then {

				RGG_indiforCreated = RGG_indiforCreated + 1;
				publicVariable "RGG_indiforCreated";
				RGG_availableIndifor = RGG_availableIndifor - 1;
				publicVariable "RGG_availableIndifor";
				profileNamespace setVariable ["RGG_availableIndifor", RGG_availableIndifor]; // can this be done at the end of the process, once?

				_classes = selectRandom [_classes1, _classes2, _classes3, _classes4];
				_class = selectRandom _classes;
				_unit = _stampToString createUnit [_class, _spawnPos, [], 0.1, "none"]; 

				_unit addMPEventHandler ["MPKilled", {
					params ["_unit", "_killer", "_instigator", "_useEffects"];
					RGG_indiforDeaths = RGG_indiforDeaths + 1;
					publicVariable "RGG_indiforDeaths";
				}];

				bluforZeus addCuratorEditableObjects [[_unit], true];
				_unit assignAsCargo _heli;
				[_unit] orderGetIn true;
				_cargo pushBack _unit;

				sleep 2;
			};
		};

		_num = str RGG_availableIndifor;
		// [[
		// 	["Incoming Telex", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
		// 	["ARVN REINFORCEMENTS STILL AVAILABLE FOR DEPLOYMENT:", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
		// 	[_num, "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7'>%1</t><br/>"],
		// 	["Telex End", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>", 30]
		// ]] remoteExec ["BIS_fnc_typeText", _pilot];  

		_checkCanRedeploy = true;
		// format ["DEBUG: Pickup System / _checkCanRedeploy: %1", _checkCanRedeploy] remoteExec ["systemChat", 0]; 
		while {_checkCanRedeploy} do {
			_heliPos = getPos _heli;
			_distance = _heliPos distance _spawnPos;
			if (_distance > 30) then {
				_checkCanRedeploy = false;
				// format ["DEBUG: Pickup System / _checkCanRedeploy: %1", _checkCanRedeploy] remoteExec ["systemChat", 0]; 
				CANBOARD2 = true;
				// format ["DEBUG: Pickup System / CANBOARD: %1", CANBOARD] remoteExec ["systemChat", 0]; 
			};
			sleep 3;
		};
		[_heli, _cargo] spawn RGGh_fnc_heli_checkDeploy;

	} else {
		// no units available at all 
		[[
			["Incoming Telex", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
			["There are currently no ARVN Units available", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>"],
			["Telex End", "<t valign='bottom' shadow = '1' color = '#99ffffff' size = '0.7' font='PuristaSemibold'>%1</t><br/>", 30]
		]] remoteExec ["BIS_fnc_typeText", _pilot]; 
	};
};