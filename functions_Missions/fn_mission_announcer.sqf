/*
Mission Announcer FNC 
Purpose: To inform players wwhat to do next 
Updated: 24 May 24 
Author: Reggs 

Note: 
{
	// eventuially to only players in a heli 
	{playSound "Left01"} remoteExec ["call", _x];
} forEach allPlayers;
*/

params ["_lzRef", "_missionType"];

systemChat "running FNC missionAnnouncer";


_num = selectRandom [1,2];
if (_num == 1) then {
	{ {playSound "thisIsKCCa"} remoteExec ["call", _x];} forEach allPlayers;
} else {
	{ {playSound "thisIsKCCb"} remoteExec ["call", _x];} forEach allPlayers;
};


sleep 3;

{ {playSound "medivacTask"} remoteExec ["call", _x];} forEach allPlayers;

sleep 3;

switch (_lzRef) do {
	case 1: 	{ { {playSound "extractAlpha"} remoteExec ["call", _x];} forEach allPlayers; }; 
	case 2: 	{ { {playSound "extractBravo"} remoteExec ["call", _x];} forEach allPlayers; }; 
	case 3: 	{ { {playSound "extractCharlie"} remoteExec ["call", _x];} forEach allPlayers; };
	case 4: 	{ { {playSound "extractDelta"} remoteExec ["call", _x];} forEach allPlayers; };
	case 5: 	{ { {playSound "extractEcho"} remoteExec ["call", _x];} forEach allPlayers; };
	case 6: 	{ { {playSound "extractFoxtrot"} remoteExec ["call", _x];} forEach allPlayers; };
	case 7: 	{ { {playSound "extractGolf"} remoteExec ["call", _x];} forEach allPlayers; };
	case 8: 	{ { {playSound "extractHotel"} remoteExec ["call", _x];} forEach allPlayers; };
	case 9: 	{ { {playSound "extractIndia"} remoteExec ["call", _x];} forEach allPlayers; };
	case 10: 	{ { {playSound "extractJuliette"} remoteExec ["call", _x];} forEach allPlayers; };
	case 11: 	{ { {playSound "extractKilo"} remoteExec ["call", _x];} forEach allPlayers; };
	case 12: 	{ { {playSound "extractLima"} remoteExec ["call", _x];} forEach allPlayers; };
	case 13: 	{ { {playSound "extractMike"} remoteExec ["call", _x];} forEach allPlayers; };
	case 14: 	{ { {playSound "extractNovember"} remoteExec ["call", _x];} forEach allPlayers; };
	case 15: 	{ { {playSound "extractOscar"} remoteExec ["call", _x];} forEach allPlayers; };
	case 16: 	{ { {playSound "extractPapa"} remoteExec ["call", _x];} forEach allPlayers; };
	case 17: 	{ { {playSound "extractQuebec"} remoteExec ["call", _x];} forEach allPlayers; };
	case 18: 	{ { {playSound "extractRomeo"} remoteExec ["call", _x];} forEach allPlayers; };
	case 19: 	{ { {playSound "extractSierra"} remoteExec ["call", _x];} forEach allPlayers; };
	case 20: 	{ { {playSound "extractTango"} remoteExec ["call", _x];} forEach allPlayers; };
	case 21: 	{ { {playSound "extractUniform"} remoteExec ["call", _x];} forEach allPlayers; };
	case 22: 	{ { {playSound "extractVictor"} remoteExec ["call", _x];} forEach allPlayers; };
	case 23: 	{ { {playSound "extractWhiskey"} remoteExec ["call", _x];} forEach allPlayers; };
	case 24: 	{ { {playSound "extractXray"} remoteExec ["call", _x];} forEach allPlayers; };
	case 25: 	{ { {playSound "extractYankee"} remoteExec ["call", _x];} forEach allPlayers; };
	case 26: 	{ { {playSound "extractZulu"} remoteExec ["call", _x];} forEach allPlayers; };
	default 	{ systemChat "switch error left diff" };
};

sleep 3;

{ {playSound "howCopy"} remoteExec ["call", _x];} forEach allPlayers;




// hint "MISSION INCOMING - STAND BY";
// sleep 1;
// hint "";
// sleep 1;
// hint "MISSION INCOMING - STAND BY";
// sleep 1;
// hint "";
// sleep 1;
// hint "MISSION INCOMING - STAND BY";
// sleep 1;
// hint "";
// sleep 1;
// hint format ["%1 REQUIRED AT LZ %2, LZ IS CURRENTLY %3", _missionType, _lzRef, _currentHeat];