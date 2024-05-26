/*
Get RFCHECK FNC 
Updated: 29 Oct 2023 

Purpose: Returns key stats needed to manage the attack stage of any patrol 

*/

//init dec 
_data = [];

// total numbers 
_unitsRedzone = allUnits inAreaArray "redzone";	// get overall numbers of troops in redzone 
_unitsCore = allUnits inAreaArray "missionCore"; // get overall numbers of troops in obj core area 

// Redzone stats 
_redzoneIndi = 0;
_redzoneOpfor = 0;
{
	switch ((side _x)) do
	{
		case INDEPENDENT: {_redzoneIndi = _redzoneIndi + 1};
		case EAST: {_redzoneOpfor = _redzoneOpfor + 1};
	};
} forEach _unitsRedzone;

// Core stats 
_coreIndi = 0;
_coreOpfor = 0;
{
	switch ((side _x)) do
	{
		case INDEPENDENT: {_coreIndi = _coreIndi + 1};
		case EAST: {_coreOpfor = _coreOpfor + 1};
	};
} forEach _unitsCore;

// debug stats 
// systemChat "RFCHECK1";
// systemChat format ["TOTAL INDI: %1", _indi]; 
// systemChat format ["TOTAL OPFOR: %1", _east];
// systemChat ".....";
// systemChat format ["FNC - REDZONE INDI: %1", _redzoneIndi];
// systemChat format ["FNC - REDZONE OPFR: %1", _redzoneOpfor];
// systemChat ".....";
// systemChat format ["FNC - CORE INDI:    %1", _coreIndi];
// systemChat format ["FNC - CORE OPFR:    %1", _coreOpfor];
// action ^^ turn into useful telex stats for PL or in-map for players 

// _redzoneIndi, _redzoneOpfor, _coreIndi, _coreOpfor
_players = allPlayers inAreaArray "redzone";
_cntPlrs = count _players;
_data pushBack _redzoneIndi;
_data pushBack _redzoneOpfor;
_data pushBack _coreIndi;
_data pushBack _coreOpfor;
_data pushBack _cntPlrs;
_data;