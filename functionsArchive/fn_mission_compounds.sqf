/*
This mission will run constantly and generate opfor near to players, within buildings 
*/

// init sleep 
sleep 15;

// classes 
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

_civvieClasses = [
	"C_Man_casual_4_v2_F_asia",
	"C_Man_casual_9_F_asia",
	"C_man_p_fugitive_F_asia",
	"C_man_polo_4_F_asia"
];

// create basic enemy spawner always around players  
_canSpawn = false; // init dec / controls if a opfor populate system should run

while {TRUE} do {
	
	// determine if spawning should take place or not - ie are you too close to Pathfinder Base 
	_targetAnchor = selectRandom allPlayers;
	_pos = getPos _targetAnchor;
	_base = getPos ammo1;
	_dist = _pos distance _base;
	if (_dist < 1000) then {
		systemChat "you are too near to base - no mission";
		_canSpawn = false;
	} else {
		systemChat "you are not near base - checking for new compound";
		_canSpawn = true;
	};
	
	// compound spawner 
	if (_canSpawn) then {
		// find a compound / area to explore / create opfor
		// _dist = selectRandom [100,200,300];
		// _dir = random 359;
		_spawnPos = _pos getPos [(selectRandom [100,200,300]),(random 359)];
		_building1 = [_spawnPos] call RGGg_fnc_get_randomHouse; // get 1 building closest to player - we can increase later  
		_bldPos = getPos _building1;

		// break out if dist of player vs building is just too far away 
		_howFar = _pos distance _bldPos;
		if (_howFar > 800) exitWith {
			systemChat "DEBUG - PL Role system - no buildings within 500m - re-running";
		};

		// break out if dist of building vs blacklist is too close   
		_blkCheck = RGG_bldBlacklist select 0;
		_howFar2 = _blkCheck distance _bldPos;
		systemChat format ["DEBUG - PL Role system - _blkCheck is %1 / _bldPos is %2 / _howFar2 is %3", _blkCheck,_bldPos,_howFar2];
		sleep 1;
		if (_howFar2 < 500) exitWith {
			systemChat "DEBUG - PL Role system - selected building too close to last point break out and re-run";
		};

		systemChat "DEBUG - PL Role system - if you can see this there must be a building within 500m";

		// debug marker - can make invisible when all works ok 
		_base = createMarker ["populateOpforSL", _bldPos];
		_base setMarkerShape "ELLIPSE";
		_base setMarkerSize [50, 50];
		_base setMarkerAlpha 0.5;

		// // make sure no players are in the spawn area!
		_unitsSpawn = allUnits inAreaArray "populateOpforSL";
		_nearPlayers = [];
		{
			if (_x == player) then {
				_nearPlayers pushBackUnique _x;
			};
		} forEach _unitsSpawn;

		_cnt1 = count _nearPlayers;
		if (_cnt1 >= 1) exitWith {
			systemChat "can't spawn, players are too near";
			deleteMarker "populateOpforSL"; 
		};

		// there are no players near, so can carry on 
		_buildingData = []; // to hold one or more buildings 
		_buildingData pushBack _building1;


		_iteration = 0; // used for controlling the overall count 
		// _spawnedInjured = 0; // used as a cutoff system, here we stop processing at 5 civilians 
		_spawnedEnemy = 0; // used as a cutoff system, here we stop processing at 5 enemy  
		_markersToDelete = []; // used to manage cleanup of debug markers after extract 
		// build a limiter that reflects number of players nearby eventually 
		{
			_iteration = _iteration +1; 
			// exit if limit reached 
			if (_spawnedEnemy == 5) exitWith { systemChat "DEBUG / PL Role System - spawn limit of 5 enemy reached" };
			
			systemChat format ["DEBUG / POPULATE -  spawn iteration %1", _iteration];

			_pos = getPos _x; // get building pos of each iterated item in building data - used for markers 
			_positions = [_x] call BIS_fnc_buildingPositions; // get building positions of each iterated item in building data 
			
			_countPositions = count _positions;
			systemChat format ["DEBUG / POPULATE - selected PL building has %1 available positions", _countPositions];

			if (_countPositions > 0) then {

				_base2 = createMarker ["populateOpforIcon", _bldPos];
				_base2 setMarkerType "hd_objective";
				_base2 setMarkerColor "ColorRed";

				RGG_bldBlacklist set [0, _bldPos]; // replaces old with new pos for blacklisting 

				// choose random number of available positions in the building 
				_posit1 = random _countPositions;
				_posit2 = (floor _posit1) + 1; // in case 0
				systemChat format ["DEBUG / POPULATE - selected PL building has %1 available positions, we selected %2 at random", _countPositions, _posit2];

				for "_i" from 1 to _posit2 do { 
				
					// limiter 
					if (_spawnedEnemy > 8) exitWith {};

					_randomPosition = selectRandom _positions; // one random pos from above array 
					_opGroup = createGroup [east, true]; 
					_class = selectRandom _enemyClasses;
					_unit = _opGroup createUnit [_class, _randomPosition, [], 0.1, "none"]; 

					_unit addMPEventHandler ["MPKilled", {
						params ["_unit", "_killer", "_instigator", "_useEffects"];
						if (RGG_indiRF) then {
							// indiFor are responsible for their own RF numbers 
							if (isPlayer _killer) then {
								RGG_bluforKills = RGG_bluforKills + 1;
								publicVariable "RGG_bluforKills";
							} else {
								RGG_indiforKills = RGG_indiforKills + 1;
								publicVariable "RGG_indiforKills";
								RGG_availableIndifor = RGG_availableIndifor + 1;
								publicVariable "RGG_availableIndifor";
							};				
						} else {
							// players are responsible for indiFor RF numbers 
							if (isPlayer _killer) then {
								RGG_bluforKills = RGG_bluforKills + 1;
								publicVariable "RGG_bluforKills";
								RGG_availableIndifor = RGG_availableIndifor + 1;
								publicVariable "RGG_availableIndifor";
							} else {
								RGG_indiforKills = RGG_indiforKills + 1;
								publicVariable "RGG_indiforKills";
							};				
						};
					}];

					// tinmanModule addCuratorEditableObjects [[_unit], true];
					bluforZeus addCuratorEditableObjects [[_unit], true];

					_spawnedEnemy = _spawnedEnemy +1;
					_unit disableAI "path";
					_unit forceSpeed 0; 
					_stance = selectRandom [1,2,3];
					switch (_stance) do {
						case 1: { _unit setUnitPos "down" };
						case 2: { _unit setUnitPos "up" };
						case 3: { _unit setUnitPos "middle" };
						default { systemChat "error with injured stances" };
					};

					sleep 1;
				};
				
				// ACTION get dir of player and point opfor in that dir 

				// now do civvie 1 in 4 chance 
				_chance = selectRandom [1,2,3,4];
				if (_chance == 1) then {
					_randomPosition = selectRandom _positions; 
					_opGroup = createGroup [civilian, true]; 
					_class = selectRandom _civvieClasses;
					_unit2 = _opGroup createUnit [_class, _randomPosition, [], 0.1, "none"]; 
					_unit2 setUnitPos "middle";

					_unit2 setDamage 0.6;
					_unit2 removeItem "Item_Medikit";
					_unit2 removeItem "Item_Medikit";
					_unit2 removeItem "Item_Medikit";
					_unit2 removeItem "Item_Medikit";
					_unit2 forceSpeed 0; 

					// tinmanModule addCuratorEditableObjects [[_unit2], true];
					bluforZeus addCuratorEditableObjects [[_unit2], true];
				};
			};

			if (_countPositions == 0) exitWith {
				systemChat "building found but had no good positions";
				deleteMarker "populateOpforSL";
			};

			sleep 0.5;
		} forEach _buildingData;
	
		// now control so only one per time 
		_activeSpawn = true;
		while {_activeSpawn} do {
			// check for prox and deaths, release when ok to release
			// we need to count all opfor in area - only close when all are dead 
			// also check for distance - if no players close, then delete all civs and opfor 
			_dataStore = [];
			{
				_playerPos = getPos _x;
				_dist = _bldPos distance _playerPos;

				if (_dist < 500) then {
					_dataStore pushback _x;
				};
			} forEach allPlayers;

			_cnt = count _dataStore;
			if (_cnt == 0) then {
				systemChat "no players are near - PL mission can be shut down";
				_activeSpawn = false;
			} else {
				systemChat "players are near - do not delete Compound Misison";
			};

			_opfor = [_bldPos, 50, EAST] call RGGc_fnc_count_unitsClose;

			if (_opfor == 0) then {
				_activeSpawn = false;
				systemChat "WELL DONE - KILL MISSION COMPLETE";
			};

			sleep 30;
		};

		// you are here as spawn system is finished 
		// note, civilians are not deleted here - you need to ensure there is a system to delete them if there are no players 
		// nearby - but that dist should be bigger, as we may want to come back for them after healing 
		// also, all civvies healed should have a map marker to assist extraction duties 
		_proc = allUnits inAreaArray "populateOpforSL";
		{
			// if (((side _x) == CIVILIAN) or ((side _x) == EAST)) then {
			if ((side _x) == EAST) then {
				deleteVehicle _x;
				systemChat format ["deleting opfor %1", _x];
			};
		} forEach _proc;

		deleteMarker "populateOpforSL"; 
		deleteMarker "populateOpforIcon";
		_canSpawn = false;
	};
	
	sleep 120; 
};

/*
Note - I want to prevent opfor from re-spawning in areas that have previously been checked - that would break immersion 
So, initially I thought having a blacklist of buildings so as to remove any building from being repeated. However, this is 
not ideal, as say you have 5 buildings, with one populated - players might clear all 5, then find soon after that one  
of the buildings that was cleared and was empty might have enemy inside - which would be too 'spawny'.

So, instead of using buildings, I need to use building positions. 

When I seach for a suitable building, it cannot be within xm of any point on the blacklist array. This will ideally create a 
buffer around each point, meaning areas are not overlapped. 

However, this might end up being quite large, so I need a standalone script that runs always, and checks for length, and if say 
has 11, then delete the oldest one - which is realistic as over that time it could realistically be re-populated 

This will not solve the issue of units spawning in areass that have been checked recently - there could be cases where the 
team needs to backtrack - but this will do for now 

Also consider, for each garrisonned enemy, you get one pesh fighter - 25% of a civvie 

---

Consider running this each loop against a random player - and not limiting it to the SL 
*/

