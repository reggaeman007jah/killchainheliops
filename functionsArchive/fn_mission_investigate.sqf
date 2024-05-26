// --- mission - investigate --- // 

/*
random generated order to check out a building 
can have injured to extract 
can have gear - to do
can have enemy 

once generated can last for limited time then despawns 

Takes:
	an area pos relative to the main obj as a marker anchor 
	a building 

Generates:
	an extraction of injured civvies 
	weapons stash (good stuff) - to do
	has enemies 
	has combo of all three - to do
	has nothing - to do maybe 

*/

_target = _this select 0; // passed in area pos used for intel (?) and also anchor for first building 
_buildingData = _this select 1; // data of all buildings found previously (100m prox to anchor)
_countBD = count _buildingData; // debug count building results 
// systemChat format ["DEBUG / INVESTIGATE - _buildingData is: %1", _buildingData]; // not needed 
systemChat format ["DEBUG / INVESTIGATE - _buildingData contains %1 buildings", _countBD];
// sleep 2;

_classes = [
	"C_Man_casual_4_v2_F_asia",
	"C_Man_casual_9_F_asia",
	"C_man_p_fugitive_F_asia",
	"C_man_polo_4_F_asia"
];

_enemyClasses = [
	"LOP_BH_Infantry_AT",
	"LOP_BH_Infantry_GL",
	"LOP_BH_Infantry_AR",
	"LOP_BH_Infantry_SL",
	"LOP_BH_Infantry_TL",
	"LOP_BH_Infantry_AR_Asst",
	"LOP_BH_Infantry_Rifleman",
	"LOP_BH_Infantry_Corpsman",
	"LOP_BH_Infantry_Rifleman_lite",
	"LOP_BH_Infantry_Marksman"
];

// area marker 
_objective1 = createMarker ["Extract", _target];
_objective1 setMarkerShape "ELLIPSE";
_objective1 setMarkerColor "ColorBlack";
_objective1 setMarkerAlpha 0.5;
_objective1 setMarkerSize [300, 300];

// sleep 2;
// // debug markers 
// {
// 	_pos = getPos _x;
// 	_markerName = str _x;
// 	// deleteMarker "_markerName";
// 	_objective1 = createMarker [_markerName, _pos];
// 	_objective1 setMarkerShape "ELLIPSE";
// 	_objective1 setMarkerColor "ColorRed";
// 	_objective1 setMarkerSize [10, 10];
// 	// sleep 3;
// } forEach _buildingData;



// wait for players to be near 
// _activateCheck = true;

// while {_activateCheck} do {
// 	_dataStore = [];
// 	{
// 		_playerPos = getPos _x;
// 		_dist = _target distance _playerPos;

// 		if (_dist < 2500) then {
// 			_dataStore pushback _x;
// 		};
// 	} forEach allPlayers;

// 	_cnt = count _dataStore;

// 	if (_cnt >= 1) then {
// 		systemChat "players are near - SAD mission activated";
// 		_activateCheck = false;
// 	} else {
// 		_activateCheck = true;
// 		systemChat "players are not near - do not delete SAD Misison";
// 	};

// 	sleep 20; // cycle frequency 
// };

// use scripted trigger for player detection
investigateMission = false;
_trg = createTrigger ["EmptyDetector", _target];
_trg setTriggerArea [1250, 1250, 0, false];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trg setTriggerStatements [
	"this", 
	"investigateMission = true; systemChat 'INV TRIGGER ACTIVATED :)'", 
	"systemChat 'no player near - do not trigger inv mission'"
];

waitUntil { investigateMission == true };

_toExtract = []; // init dec for data of civilians to be extracted 
_iteration = 0; // used for controlling the overall count 
_spawnedInjured = 0; // used as a cutoff system, here we stop processing at 5 civilians 
_markersToDelete = []; // used to manage cleanup of markers after extract 

{
	_iteration = _iteration +1; 

	// exit if limit reached 
	if (_spawnedInjured == 5) exitWith { systemChat "DEBUG / INVESTIGATE 1 - extract limit of 5 reached" };
	
	systemChat format ["DEBUG / INVESTIGATE 1 -  spawn iteration %1", _iteration];

	_pos = getPos _x; // get building pos of each iterated item in building data - used for markers 
	_positions = [_x] call BIS_fnc_buildingPositions; // get building positions of each iterated item in building data 
	
	_countPositions = count _positions;
	systemChat format ["DEBUG / INVESTIGATE 1 - this building has %1 available positions", _countPositions];
	systemChat format ["DEBUG / INVESTIGATE 1 - positions are: %1", _positions];

	if (_countPositions > 0) then {
		
		_randomPosition = selectRandom _positions; // one random pos from above array 
		systemChat format ["DEBUG / INVESTIGATE 1 - _randomPosition chosen: %1", _randomPosition];
		
		_civGroup = createGroup [civilian, true]; 
		_class = selectRandom _classes;
		_unit = _civGroup createUnit [_class, _randomPosition, [], 0.1, "none"]; 
		_unit addMPEventHandler ["MPKilled", {
			params ["_unit", "_killer", "_instigator", "_useEffects"];
			if (isPlayer _killer) then {
				_name = groupId (group _killer);
				// systemChat format ["%1 Killed a Civilian", _name];
				// ["%1 Killed a Civilian", _name] call RGGi_fnc_information_leadershipGroup;
				["%1 Killed a Civilian", _name] remoteExec ["RGGi_fnc_information_leadershipGroup", 0]; 
				RGG_civviesKilled = RGG_civviesKilled + 1;
				publicVariable "RGG_civviesKilled";
			};
		}];

		// tinmanModule addCuratorEditableObjects [[_unit], true];
		bluforZeus addCuratorEditableObjects [[_unit], true];

		_spawnedInjured = _spawnedInjured +1;
		_toExtract pushback _unit;
		_markerName = str _unit;
		_markersToDelete pushBack _markerName;

		_objective1 = createMarker [_markerName, _randomPosition];
		// _objective1 setMarkerShape "ELLIPSE";
		_objective1 setMarkerColor "ColorBlue";
		_objective1 setMarkerSize [1, 1];
		_objective1 setMarkerType "loc_heal";
		// loc_heal


		systemChat format ["DEBUG / INVESTIGATE 1 - unit %1 created at position %2", _unit, _randomPosition];
		_unit setDamage 0.6;
		_unit removeItem "Item_Medikit";
		_unit removeItem "Item_Medikit";
		_unit removeItem "Item_Medikit";
		_unit removeItem "Item_Medikit";
		_unit forceSpeed 0; // testing this 
		// _unit disableAI "move";
		_stance = selectRandom [2,3];
		switch (_stance) do {
			// case 1: { _unit setUnitPos "down" };
			case 2: { _unit setUnitPos "up" };
			case 3: { _unit setUnitPos "middle" };
			default { systemChat "error with injured stances" };
		};	

		// now do opfor sneakies 1 in 4 chance 
		_chance = selectRandom [1,2,3,4];
		if (_chance == 1) then {
			_randomPosition = selectRandom _positions; 
			_opGroup = createGroup [east, true]; 
			_class = selectRandom _enemyClasses;
			_unit2 = _opGroup createUnit [_class, _randomPosition, [], 0.1, "none"]; 
			_unit2 addMPEventHandler ["MPKilled", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				if (isPlayer _killer) then {
					RGG_bluforKills = RGG_bluforKills + 1;
					publicVariable "RGG_bluforKills";
				} else {
					RGG_indiforKills = RGG_indiforKills + 1;
					publicVariable "RGG_indiforKills";
				};	
			}];
			_unit2 setUnitPos "middle";
			// tinmanModule addCuratorEditableObjects [[_unit2], true];
			bluforZeus addCuratorEditableObjects [[_unit2], true];
		};
	};
	sleep 0.5;
} forEach _buildingData;

// wait until players are near before starting timer and before triggering spawning 
[_target, _markersToDelete] execVM "killchain\systems\deSpawnerSystems\despawnCivilianMission.sqf";

systemChat "DEBUG / INVESTIGATE 1 - Injured units spawning now complete";
systemChat format ["DEBUG / INVESTIGATE 1 - units spawned %1", _spawnedInjured];
systemChat format ["DEBUG / INVESTIGATE 1 - array to extract %1", _toExtract];










// [_target, _markersToDelete] spawn RGGd_delete_extractLeftBehind; // delete timer // why not work?




// // extract trigger - is needed still ??
// _trgSmk = createTrigger ["EmptyDetector", _target];
// _trgSmk setTriggerArea [300, 300, 0, false];
// _trgSmk setTriggerActivation ["ANYPLAYER", "PRESENT", true];
// _trgSmk setTriggerStatements ["this", "systemChat 'PLAYER IS ZONE'", "systemChat 'no player near'"];

// _smoke = createVehicle ['G_40mm_smokeYELLOW', _missionPos, [], 0, 'none']; 


// _positions1 = [_building1] call BIS_fnc_buildingPositions;
// _cnt = count _positions1;
// systemChat format ["DEBUG / INVESTIGATE 1 - number of available building positions: %1", _cnt];
// systemChat format ["DEBUG / INVESTIGATE 1 - available building positions: %1", _positions1];
// // generate units in available spots 
// _civGroup = createGroup civilian;
// {
// 	_class = selectRandom _classes;
// 	_unit = _civGroup createUnit [_class, _x, [], 0.1, "none"]; 
// 	_unit setDamage 0.9;
// 	_stance = selectRandom [1,2,3];
// 	switch (_stance) do {
// 		case 1: { _unit setUnitPos "down" };
// 		case 2: { _unit setUnitPos "up" };
// 		case 3: { _unit setUnitPos "middle" };
// 		default { systemChat "error with injured stances" };
// 	};
// 	sleep 1;
// } forEach _positions1;


















// building 1 
// deleteMarker "ExtractBld1"; 
// _objective1 = createMarker ["ExtractBld1", _building1Pos];
// _objective1 setMarkerShape "ELLIPSE";
// _objective1 setMarkerColor "ColorRed";
// _objective1 setMarkerSize [30, 30];
// sleep 5;

// building 2
// _building2 = [_bldPos1] call RGGg_fnc_get_randomHouse; // the actual building 
// systemChat format ["DEBUG / INVESTIGATE - returned building 2 is: %1", _building2];
// _bldPos2 = getPos _building2;
// deleteMarker "ExtractBld2"; 
// _objective1 = createMarker ["ExtractBld2", _building2Pos];
// _objective1 setMarkerShape "ELLIPSE";
// _objective1 setMarkerColor "ColorGreen";
// _objective1 setMarkerSize [30, 30];
// sleep 5;

// building 3 
// _building3 = [_bldPos2] call RGGg_fnc_get_randomHouse; // the actual building 
// systemChat format ["DEBUG / INVESTIGATE = returned building 3 is: %1", _building3];
// _bldPos3 = getPos _building3;
// deleteMarker "ExtractBld3"; 
// _objective1 = createMarker ["ExtractBld3", _building3Pos];
// _objective1 setMarkerShape "ELLIPSE";
// _objective1 setMarkerColor "ColorBlue";
// _objective1 setMarkerSize [30, 30];
// sleep 5;



// // _type = selectRandom [1,2,3,4,5];
// _type = selectRandom [1]; // testing  

// // basic rescue with no loot and no threrats
// if (_type == 1) then {



// 	_positions1 = [_building1] call BIS_fnc_buildingPositions;
// 	_cnt = count _positions1;
// 	systemChat format ["DEBUG / INVESTIGATE 1 - number of available building positions: %1", _cnt];
// 	systemChat format ["DEBUG / INVESTIGATE 1 - available building positions: %1", _positions1];
// 	// generate units in available spots 
// 	_civGroup = createGroup civilian;
// 	{
// 		_class = selectRandom _classes;
// 		_unit = _civGroup createUnit [_class, _x, [], 0.1, "none"]; 
// 		_unit setDamage 0.9;
// 		_stance = selectRandom [1,2,3];
// 		switch (_stance) do {
// 			case 1: { _unit setUnitPos "down" };
// 			case 2: { _unit setUnitPos "up" };
// 			case 3: { _unit setUnitPos "middle" };
// 			default { systemChat "error with injured stances" };
// 		};
// 		sleep 1;
// 	} forEach _positions1;

// 	sleep 5;

// 	_positions2 = [_building2] call BIS_fnc_buildingPositions;
// 	_cnt2 = count _positions2;
// 	systemChat format ["DEBUG / INVESTIGATE 2 - number of available building positions: %1", _cnt2];
// 	systemChat format ["DEBUG / INVESTIGATE 2 - available building positions: %1", _positions2];
// 	// generate units in each available spot 
// 	_civGroup = createGroup civilian;
// 	{
// 		_class = selectRandom _classes;
// 		_unit = _civGroup createUnit [_class, _x, [], 0.1, "none"]; 
// 		_unit setDamage 0.9;
// 		_stance = selectRandom [1,2,3];
// 		switch (_stance) do {
// 			case 1: { _unit setUnitPos "down" };
// 			case 2: { _unit setUnitPos "up" };
// 			case 3: { _unit setUnitPos "middle" };
// 			default { systemChat "error with injured stances" };
// 		};
// 		sleep 1;
// 	} forEach _positions2;

// 	sleep 5;

// 	_positions3 = [_building3] call BIS_fnc_buildingPositions;
// 	_cnt3 = count _positions3;
// 	systemChat format ["DEBUG / INVESTIGATE 3 - number of available building positions: %1", _cnt3];
// 	systemChat format ["DEBUG / INVESTIGATE 3 - available building positions: %1", _positions3];
// 	// generate units in each available spot 
// 	_civGroup = createGroup civilian;
// 	{
// 		_class = selectRandom _classes;
// 		_unit = _civGroup createUnit [_class, _x, [], 0.1, "none"]; 
// 		_unit setDamage 0.9;
// 		_stance = selectRandom [1,2,3];
// 		switch (_stance) do {
// 			case 1: { _unit setUnitPos "down" };
// 			case 2: { _unit setUnitPos "up" };
// 			case 3: { _unit setUnitPos "middle" };
// 			default { systemChat "error with injured stances" };
// 		};
// 		sleep 1;
// 	} forEach _positions3;

// };

// note - agree to use three buildings here for this mission .. can you chain anchors to get three buildings in proximity to eachother?
// test does switch for stances work ok?
// does building selection chain work ok?
// do buildings get created and markers wrk?



// switch (_type) do {
// 	case 1: { [_building] call RGGm_mission_investigate_1; }; // extract injured civvies 
// 	// case 2: { };
// 	// case 3: { };
// 	// case 4: { };
// 	// case 5: { };
// 	default { };
// };