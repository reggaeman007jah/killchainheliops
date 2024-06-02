



RGG_medBase = [9197,6322]; // ie Pathfinder base 
RGG_currentObj = [0,0];

// these globals declare whether a particular raptor heli is available for tasking 
// RGG_rap1OnStat = false;
// RGG_rap2OnStat = false;
// RGG_rap3OnStat = false;
// RGG_rap4OnStat = false;
// RGG_rap5OnStat = false;
// RGG_rap6OnStat = false;

// manages whether individual raptors can take a new task or not 
RGG_rap1onTask = false;
RGG_rap2onTask = false;
RGG_rap3onTask = false;
RGG_rap4onTask = false;
RGG_rap5onTask = false;
RGG_rap6onTask = false;

// send rap number through function chain to ensure it gets to deleteAllInArea - so when run, can free up said raptor 



// RGG_MISSIONLIVE = false;

// [[4685.11,3682.24,0], RGGm_fnc_mission_extractInjured] spawn RGGm_fnc_mission_proxCheck;


/*
KILLCHAINMISSIONSTART = false; 
publicVariable "KILLCHAINMISSIONSTART";

setDate [1970, 2, 25, (selectRandom [06]), 40]; 

// [west, pathfinderRespawn, "pathfinder"] call BIS_fnc_addRespawnPosition;
// [west, "ammo1", "pathfinder"] call BIS_fnc_addRespawnPosition;


RGG_FASTNIGHTS = false; 

KILLCHAINISLIVE = false; 
KCCOMPLETE = false; 

["Initialize", [true]] call BIS_fnc_dynamicGroups;

patrolPointsTaken = 0;
publicVariable "patrolPointsTaken";

RGG_initHeliRunning = false;
publicVariable "RGG_initHeliRunning";

RGG_heliRunning = false;
publicVariable "RGG_heliRunning";

RGG_AUTOMOVE = false;

RGG_dutyMedic = [];

saveLoadoutPoster setObjectTextureGlobal [0,"media\images\saveLoadout2.jpg"];
dontForget setObjectTextureGlobal [0, "media\images\vnMap3.jpg"];
fobPathfinder setObjectTextureGlobal [0, "media\images\pathfinderImage.jpg"];
foodSign setObjectTextureGlobal [0, "media\images\foodSupplies.paa"];
ammoSign setObjectTextureGlobal [0, "media\images\ammoSupplies.paa"];
medicalSign setObjectTextureGlobal [0, "media\images\medicalLZ.paa"];
customFlag2 setObjectTextureGlobal [0, "media\images\flag3.jpg"];
ammoRepairSign setObjectTextureGlobal [0, "media\images\rearmHere.jpg"];

BLUMAN = true; 
publicVariable "BLUMAN";

SPECOPSATTACKS = true; 
SPECOPSATTACKS2 = true;
[30] spawn RGGs_fnc_spawn_opforHK; 
[30] spawn RGGs_fnc_spawn_opforHKNear; 

VAA_Activate = true; 


SIDEMISSIONSTART = false; 
RAPTOROPS = false; 
ROPEBREAK = false;  

execVM "eventHandlers\checkCargo.sqf";
execVM "eventHandlers\unassign.sqf";

HUNTERKILLER = true;
CPD = false;
publicVariable "HUNTERKILLER";
publicVariable "CPD";

CANBOARD = true; 
CANBOARD2 = true; 
CANBOARDGUN = true; 

RGG_isDay = true; 
publicVariable "RGG_isDay";

REARMONSPAWN = true; 

RGG_sentryQueue = []; 
RGG_supplyQueue = []; 
RESPAWNQUEUE = false; 
RGG_potentialEnemyCamps = [];
RGG_destroyedEnemyCamps = [];
RGG_Barracks_Food = 0;
RGG_Barracks_Ammo = 0;
RGG_Barracks_Fuel = 0;
RGG_Barracks_Sentries = 0;
publicVariable "RGG_Barracks_Food";
publicVariable "RGG_Barracks_Ammo";
publicVariable "RGG_Barracks_Fuel";
publicVariable "RGG_Barracks_Sentries";

DISRUPTEVADE = false;

RGG_ciaChecking = false;

[] spawn RGGa_fnc_ambient_lowbys;
[] spawn RGGa_fnc_ambient_baseActivity; 

[] spawn RGGc_fnc_count_ammoBox;

RGG_checkDestroy = [];
publicVariable "RGG_checkDestroy";

RGG_checkDestroyBlufor = [];
publicVariable "RGG_checkDestroyBlufor";

RGG_civviesSaved = 0;
publicVariable "RGG_civviesSaved";

RGG_civviesKilled = 0;
publicVariable "RGG_civviesKilled";

RGG_availableIndifor = profileNamespace getVariable ["RGG_availableIndifor", 1000]; 
profileNamespace setVariable ["RGG_availableIndifor", RGG_availableIndifor];

publicVariable "RGG_availableIndifor";

RGG_indiforCreated = 0;
publicVariable "RGG_indiforCreated";

RGG_destroyedAA = 0;
publicVariable "RGG_destroyedAA";

RGG_indiforKills = 0;
publicVariable "RGG_indiforKills";

RGG_bluforKills = 0;
publicVariable "RGG_bluforKills";

RGG_bluforDeaths = 0;
publicVariable "RGG_bluforDeaths";

RGG_indiforDeaths = 0;
publicVariable "RGG_indiforDeaths";

RGG_bldBlacklist = [[0,0,0]]; 
publicVariable "RGG_bldBlacklist";

RGG_ARVNEXTRACT = true;

RGG_lrrpMulti = 0;

RGG_telex = false; 

RGG_indiRF = false;

MUSIC = false;

AP = profileNamespace getVariable ["AP", false]; 
BP = profileNamespace getVariable ["BP", false]; 
CP = profileNamespace getVariable ["CP", false]; 
DP = profileNamespace getVariable ["DP", false];  
EP = profileNamespace getVariable ["EP", false];  
FP = profileNamespace getVariable ["FP", false]; 
GP = profileNamespace getVariable ["GP", false]; 
HP = profileNamespace getVariable ["HP", false];  
IP = profileNamespace getVariable ["IP", false]; 
publicVariable "AP";
publicVariable "BP";
publicVariable "CP";
publicVariable "DP";
publicVariable "EP";
publicVariable "FP";
publicVariable "GP";
publicVariable "HP";
publicVariable "IP";

RGG_activePatrol = []; 

_lzMarkers = [];
{
	_hook = _x select [0,2]; 
	if (_hook == "LZ") then {
		_lzMarkers pushBack _x;
	};
} forEach allMapMarkers;
{
	_x setMarkerAlpha 0.1;	
} forEach _lzMarkers;

_objMarkers = [];
{
	_hook = _x select [2,3]; 
	if (_hook == "OBJ") then {
		_objMarkers pushBack _x;
	};
} forEach allMapMarkers;
{
	_x setMarkerAlpha 0.25;	
} forEach _objMarkers;

RGG_missionState = 0; 

RGG_staticsToDel = []; 

RFCHECK = false;
RFCHECK2 = false;
publicVariable "RFCHECK";
publicVariable "RFCHECK2";

_allVics = vehicles inAreaArray "pathFinderBase";
_baseHelis = [];
{
	_pos = getPos _x;
	_alt = _pos select 2;
	if ( (_x isKindOf "helicopter") && (_alt < 4) ) then {
		_classStr = typeOf _x;
		_baseHelis pushBack _classStr;	
	};
} forEach _allVics;

// [REPAIRZONE,5] call BIS_fnc_drawAO;
// [PZ1,5] call BIS_fnc_drawAO;
// [PZ2,5] call BIS_fnc_drawAO;
// [bluforCrew,5] call BIS_fnc_drawAO;

RGG_CAS = false;
publicVariable "RGG_CAS";

RGG_patrolSpawn = [0,0];
publicVariable "RGG_patrolSpawn";