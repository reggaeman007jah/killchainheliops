/*
Mission proxCheck FNC 
Updated: 21 May 24 
Purpose: Checks for blufor player proximity to a given starting point
Author: Reggs

Notes:
	Requires a follow-on FNC as a param 
*/

params ["_lzPos", "_onActivation"];

// _isNear = false; 
_checkCycle = true;
while {_checkCycle} do {	

	systemChat "proxCheckCycle";

	{
		_playerPos = getPos _x;
		_actChk = _lzPos distance _playerPos;
		if (_actChk < 1600) then {
			// _isNear = true;
			[_lzPos] spawn RGGs_fnc_spawn_advanceTeam;
			// [_lzPos] spawn RGGs_fnc_spawn_hotLZ;
			deleteMarker "LZ_Target"; 
			_checkCycle = false;
			[_lzPos] call _onActivation;
			hint "is near";
		};
		sleep 0.1;
	} forEach allPlayers; 

	// if (_isNear) then {
		// _cnt = count allPlayers; // do we check for raptors here?
		// if (_cnt == 1) then {
			// ["<t size='1' color='#ffffff' font='PuristaMedium' >PROCEED TO OBJECTIVE 1</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", 0];
		// } else {
			// ["<t size='1' color='#ffffff' font='PuristaMedium' >1.5 CLICKS OUT - LRRPS HAVE POPPED YELLOW SMOKE - DISMOUNT AND PROCEED TO OBJECTIVE 1</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", 0];
		// };
		// [_lzPos] spawn RGGs_fnc_spawn_advanceTeam;
		// // [_lzPos, _objPos] spawn RGGP_fnc_patrol_mainCycle;
		// // [_lzPos] spawn RGGs_fnc_spawn_hotLZ;
		// deleteMarker "LZ_Target"; 
		// _checkCycle = false;
		// [_lzPos] call _onActivation;
		// hint "is near";
	// };

	sleep 7;
}; 




