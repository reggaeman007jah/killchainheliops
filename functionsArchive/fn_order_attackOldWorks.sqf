/*
TINMAN BASIC - Attack FNC 
Updated: 16 Nov 2023

Purpose: one off attack order - instructs -all- indifor move in to attack objective 

Notes:
- adding a move check and telporting them if no movement on order 
*/

// "All ARVN Groups are assaulting the objective" remoteExec ["systemChat", -2];
// {playSound "attack"} remoteExec ["call",-2];
// {playSound "commandOut"} remoteExec ["call",0];
// systemChat "played sound";

params ["_speed"]; // num value, 1 2 3 

	_x setSpeedMode "limited";
	{
		_vari = selectRandom [0.1, 0.2];
		_x forcespeed (2 + _vari);
		// _x forceWalk true;
		sleep (selectRandom [0.1,0.2,0.3]);
		
	} forEach (units _x);

	_x setSpeedMode "normal";
	{
		// _x forceWalk true;
		_x forceSpeed 3;
		sleep (selectRandom [0.1,0.2,0.3]);
	} forEach (units _x);

	_x setSpeedMode "full";
	{
		// _x forceWalk true;
		_x forceSpeed 4;
		sleep (selectRandom [0.1,0.2,0.3]);
	} forEach (units _x);


FALLBACKREMAIN = false; // in case was running 

_movePos = getMarkerPos 'REDZONE'; // objective pos 

_selection = allGroups select {side _x isEqualTo independent};
{
	systemChat format ["DEBUG - MOVE ORDER / Group %1 moving to %2", _x, _movePos];
	// format ["DEBUG - MOVE ORDER / Group %1 moving to %2", _x, _movePos] remoteExec ["systemChat", 0];
	_clientID = groupOwner _x;
	// systemChat format ["DEBUG - MOVE ORDER / Group %1 owner is: %2", _x, _clientID];
	// format ["DEBUG - MOVE ORDER / Group %1 owner is: %2", _x, _clientID] remoteExec ["systemChat", 0];
	if (_clientID != 2) then { // give it to the server 
		_localityChanged = _x setGroupOwner 2;
	};
	_x move _movePos; 
	_x setBehaviourStrong "aware";
	_x setSpeedMode "limited";
	_x setFormation "STAG COLUMN";
	{
		_x setUnitPos "up";
		sleep 0.4;
		// _x setUnitPos "auto";	
		_x disableAI "autocombat";
		_x disableAI "autoTarget";	
		// _x forceWalk true; 
		_x forceSpeed (selectRandom [1.9, 2, 2.1, 2.2]);  

	} forEach (units _x);

	// _combatbehaviour = combatbehaviour _x;
	// _speedMode = speedMode _x;
	// systemChat format ["DEBUG - Group %2 combatbehaviour: %1", _combatbehaviour, _x];
	// systemChat format ["DEBUG - Group %2 speedMode: %1", _speedMode, _x];
	// {
	// 	_x disableAI "AUTOCOMBAT";
	// 	_x enableAttack false;
	// } foreach (units _x);
	// {
	// 	_x disableAI "AUTOCOMBAT"
	// } forEach units _x; 
	
	// {
	// 	_x disableAI "COVER"
	// } forEach units _x;  
	
	// {
	// 	_x disableAI "TARGET"
	// } forEach units _x;   
	
	// {
	// 	_x disableAI "AUTOTARGET"
	// } forEach units _x;  


	_lrdPos = getPos (leader _x);
	_distObj = _lrdPos distance _movePos;
	if (_distObj > 50) then {
		[_x, _movePos] spawn RGGu_fnc_utilities_chkIfMoved; // send group and move order pos 
		// systemChat "paused teleport system for now"; 
	};

} forEach _selection;

// Degroup Strays System 
// [_selection, _movePos] spawn RGGu_fnc_utilities_deGroupIndiStrays; // sends an array of indi groups and re-orders the strays to attack the obj 
// sleep 5;
[_selection, _movePos] spawn RGGu_fnc_utilities_processIndiStrays; // sends an array of indi groups and re-orders the strays to attack the obj 

// ok, so maybe here we could filter all groups by owner .. and use the above if server-owned, and 
// re-do the remoteExec on the owner (if not server) again here ?





// old snippets might be useful: 

// _units = allUnits inAreaArray "Redzone";

// _indi = [];
// {
// 	if ((side _x) == INDEPENDENT) then {_indi pushBack _x};
// } forEach _units;

// _indiGroups = [];
// {
// 	_indiGroups pushBack _x;
// } forEach allGroups "independent";

// // get indi player
// _dataStore = [];
// {
// 	if ((side _x) == INDEPENDENT) then { _dataStore pushback _x }
// } forEach allPlayers;
// _commander = _dataStore select 0;
// _commPos = getPos _commander; // ?
// {_commander say3D "attack";} remoteExec ["call",0];


// {
// 	switch ((side _x)) do
// 	{
// 		case INDEPENDENT: {
// 			_randomDir = selectRandom [270, 310, 00, 50, 90];
// 			_randomDist = selectRandom [5, 10, 15, 20, 25, 30];
// 			_endPoint1 = _movePos getPos [_randomDist,_randomDir];					
// 			_x setBehaviour "COMBAT";
// 			_x doMove _endPoint1;
// 			sleep 0.2;
// 		};
// 	};
// } forEach _indi;