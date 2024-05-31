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

params ["_lzRef", "_missionType", "_numInj", "_raptorNum"];

systemChat "running FNC missionAnnouncer";


/*
this is KC 
raptor x 
you have medivac task 
x injured to extract 
location lz x 
kc out 
*/

// raptor 2
switch (_raptorNum) do {
	case raptor1: { { {playSound "rap1_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case raptor2: { { {playSound "rap2_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case raptor3: { { {playSound "rap3_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case raptor4: { { {playSound "rap4_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case raptor5: { { {playSound "rap5_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case raptor6: { { {playSound "rap6_old"} remoteExec ["call", _x];} forEach allPlayers; };
	default { systemChat "error, old raptor selector"};
};

sleep 2;

// this is kilo charlie
_kc = selectRandom [1,2,3];
switch (_kc) do {
	case 1: { { {playSound "thisisKC_old_a"} remoteExec ["call", _x];} forEach allPlayers; };
	case 2: { { {playSound "thisisKC_old_b"} remoteExec ["call", _x];} forEach allPlayers; };
	case 3: { { {playSound "thisisKC_old_c"} remoteExec ["call", _x];} forEach allPlayers; };
	default { systemChat "error, old kc selector"};
};

sleep 2; 

// you have a medivac task 
{
	{playSound "mediTask_old"} remoteExec ["call", _x];
} forEach allPlayers;


sleep 3;

// 4 units to extract 
switch (_numInj) do {
	case 2: { { {playSound "extract2_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case 3: { { {playSound "extract3_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case 4: { { {playSound "extract4_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case 5: { { {playSound "extract5_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case 6: { { {playSound "extract6_old"} remoteExec ["call", _x];} forEach allPlayers; };
	default { systemChat "error, old inj selector"};
};

sleep 3;

// extraction lz alpha niner 
switch (_lzRef) do {
	case "lza1": { { {playSound "lzA1_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lza2": { { {playSound "lzA2_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lza3": { { {playSound "lzA3_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lza4": { { {playSound "lzA4_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lza5": { { {playSound "lzA5_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lza6": { { {playSound "lzA6_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lza7": { { {playSound "lzA7_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lza8": { { {playSound "lzA8_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lza9": { { {playSound "lzA9_old"} remoteExec ["call", _x];} forEach allPlayers; };
	
	case "lzb1": { { {playSound "lzB1_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzb2": { { {playSound "lzB2_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzb3": { { {playSound "lzB3_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzb4": { { {playSound "lzB4_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzb5": { { {playSound "lzB5_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzb6": { { {playSound "lzB6_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzb7": { { {playSound "lzB7_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzb8": { { {playSound "lzB8_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzb9": { { {playSound "lzB9_old"} remoteExec ["call", _x];} forEach allPlayers; };

	case "lzc1": { { {playSound "lzC1_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzc2": { { {playSound "lzC2_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzc3": { { {playSound "lzC3_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzc4": { { {playSound "lzC4_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzc5": { { {playSound "lzC5_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzc6": { { {playSound "lzC6_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzc7": { { {playSound "lzC7_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzc8": { { {playSound "lzC8_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzc9": { { {playSound "lzC9_old"} remoteExec ["call", _x];} forEach allPlayers; };

	case "lzd1": { { {playSound "lzD1_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzd2": { { {playSound "lzD2_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzd3": { { {playSound "lzD3_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzd4": { { {playSound "lzD4_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzd5": { { {playSound "lzD5_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzd6": { { {playSound "lzD6_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzd7": { { {playSound "lzD7_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzd8": { { {playSound "lzD8_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lzd9": { { {playSound "lzD9_old"} remoteExec ["call", _x];} forEach allPlayers; };

	case "lze1": { { {playSound "lzE1_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lze2": { { {playSound "lzE2_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lze3": { { {playSound "lzE3_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lze4": { { {playSound "lzE4_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lze5": { { {playSound "lzE5_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lze6": { { {playSound "lzE6_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lze7": { { {playSound "lzE7_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lze8": { { {playSound "lzE8_old"} remoteExec ["call", _x];} forEach allPlayers; };
	case "lze9": { { {playSound "lzE9_old"} remoteExec ["call", _x];} forEach allPlayers; };

	default { systemChat "error, old lz selector"};

};

sleep 3; 

// {playSound "kcOut_old"} remoteExec ["call", _x]; forEach allPlayers;

// kilo charlie out 
{
	{playSound "kcOut_old"} remoteExec ["call", _x];
} forEach allPlayers;

systemChat "announcement over";


/*


// below was v1 of this system - worked fine, but was a bit basic 

// raptor this is killchain command 
_num = selectRandom [1,2];
if (_num == 1) then {
	{ {playSound "thisIsKCCa"} remoteExec ["call", _x];} forEach allPlayers;
} else {
	{ {playSound "thisIsKCCb"} remoteExec ["call", _x];} forEach allPlayers;
};


sleep 5;

// you have a medivac task
{ {playSound "medivacTask"} remoteExec ["call", _x];} forEach allPlayers;

sleep 6;

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

sleep 2;

{ {playSound "howCopy"} remoteExec ["call", _x];} forEach allPlayers;


