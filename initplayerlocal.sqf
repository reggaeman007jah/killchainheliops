params ["_player", "_didJIP"];

// if ((roleDescription _player) == "Viking 1:1 - Platoon Leader@Viking 1") then {
// 	[player] call RGGg_fnc_get_initLoadout;
// };

// sleep 4;

// if (KILLCHAINMISSIONSTART == false) then {
	
// 	if ((roleDescription _player) == "Viking 1:1 - Platoon Leader@Viking 1") then {
// 		[player] call RGGg_fnc_get_initLoadout;
// 		sleep 3;
// 		{playSound "welcome"} remoteExec ["call", _player];
// 		sleep 2;
// 		{playSound "loadout"} remoteExec ["call", _player];
// 		sleep 12;
// 		{playSound "luck"} remoteExec ["call", _player];
// 	} else {
// 		sleep 3;
// 		{playSound "welcome"} remoteExec ["call", _player];
// 		sleep 2;
// 		{playSound "authority"} remoteExec ["call", _player];			
// 	};
// };

// RGG_toHeal = [];
// _player addMPEventHandler ["MPHit", {
// 	params ["_unit", "_causedBy", "_damage", "_instigator"];
// 	_checkingStatus = _unit getVariable ["RGG_unitIsDown", false]; 
// 	if ((_checkingStatus == false) && (KILLCHAINMISSIONSTART)) then {		
// 		RGG_toHeal pushBackUnique _unit;
// 		[_unit] execVM "functions_Revive\checkLifeState.sqf";
// 	};
// }]; // move to lower levels so can check for missionIsLive before running heal system 

// [_player] call RGGe_fnc_effects_camoCoef;

// ["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;

// onMapSingleClick {_shift};

// _player addEventHandler ["Fired", {
// 	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

// 	if ((_ammo == "vn_m18_red_ammo") or (_ammo == "vn_40mm_m682_smoke_r_ammo")) then {
// 		RGG_CAS = true;
// 		publicVariableServer "RGG_CAS";
// 		RGG_CASPROJ = _projectile;
// 		publicVariableServer "RGG_CASPROJ";
// 		[_unit] execVM "CAS_timeout.sqf";
// 		[] execVM "CAS_projPos.sqf";
// 	};
// }];

// _id = addMissionEventHandler ["MapSingleClick", {
// 	params ["_units", "_pos", "_alt", "_shift"];

// 	if (!KILLCHAINMISSIONSTART) then {
// 		[_pos, player] execVM "onMapClick.sqf";
// 		// removeMissionEventHandler ["MapSingleClick", _id];
// 	};

// 	// if (_shift) then {
// 	// 	[_pos, player] spawn RGGw_fnc_wayF_wayfinderCheck;
// 	// };
// }];

// RGG_cpOn = true; 
// RGG_canCallLight = true; 

// _player setCustomAimCoef 0.1;
// _player addEventHandler ['Respawn',{ _player setCustomAimCoef 0.1 }];

// sleep 1;

// _res = getResolution;
// _interfaceSize = _res select 5;

// publicVariable "KILLCHAINMISSIONSTART"; 

// _playerRole = roleDescription _player;

// switch (_playerRole) do {
// 	case "Viking 1:1 - Platoon Leader@Viking 1": {
// 		player addAction ["Order: Move to the Objective", { 
// 			[2] remoteExec ["RGGo_fnc_order_attack", 2];
// 		}, nil, 6, false, true];
// 		player addAction ["Order: Move to the Objective - Stealth", { 
// 			[1] remoteExec ["RGGo_fnc_order_attack", 2];
// 		}, nil, 6, false, true];
// 		player addAction ["Order: Move to the Objective - Charge", { 
// 			[3] remoteExec ["RGGo_fnc_order_attack", 2];
// 		}, nil, 6, false, true];
// 		player addAction ["Order: Fallback to my position Immediately", { 
// 			[] remoteExec ["RGGo_fnc_order_fallBack", 2];
// 		}, nil, 6, false, true];
// 		player addAction ["Order: ARVN to hold position", { 
// 			[] remoteExec ["RGGo_fnc_order_hold", 2];
// 		}, nil, 6, false, true];
// 		player addAction ["Order: Recon Overwatch", { 
// 			[] remoteExec ["RGGo_fnc_order_autoMove", 2];
// 		}, nil, 6, false, true];
// 		// player addAction ["Experimental - Enable ARVN Autocombat", { 
// 		// 	["<t size='1' color='#ffffff' font='PuristaMedium' >ARVN Autocombat Enabled</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", player, true];
// 		// 	[] remoteExec ["RGGo_fnc_order_enableAutoCombat", 2];
// 		// }, nil, 6, false, true];
// 		// player addAction ["Experimental - Disable ARVN Autocombat", { 
// 		// 	["<t size='1' color='#ffffff' font='PuristaMedium' >ARVN Autocombat Disabled</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", player, true];
// 		// 	[] remoteExec ["RGGo_fnc_order_disableAutoCombat", 2];
// 		// }, nil, 6, false, true];
// 		player addAction ["Call CAS", { 
// 			[[player], "CAS_call.sqf"] remoteExec ["execVM", 2]; 
// 		}, nil, 6, false, true];

			
// 		// player addAction ["Set Patrol Route - Alpha", { 
// 		// 	["<t size='1' color='#ffffff' font='PuristaMedium' >ALPHA PATROL SELECTED</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", 0];
// 		// 	[1] remoteExec ["RGGp_fnc_patrol_routeManager", 2];
// 		// 	removeAllActions player;
// 		// }, nil, 6, false, true];			
	
	
// 		// player addAction ["Set Patrol Route - Bravo", { 
// 		// 	["<t size='1' color='#ffffff' font='PuristaMedium' >BRAVO PATROL SELECTED</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", 0];
// 		// 	[2] remoteExec ["RGGp_fnc_patrol_routeManager", 2];
// 		// 	removeAllActions player;
// 		// }, nil, 6, false, true];			
	
// 		// player addAction ["Set Patrol Route - Charlie", { 
// 		// 	["<t size='1' color='#ffffff' font='PuristaMedium' >CHARLIE PATROL SELECTED</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", 0];
// 		// 	[3] remoteExec ["RGGp_fnc_patrol_routeManager", 2];
// 		// 	removeAllActions player;
// 		// }, nil, 6, false, true];		
	
// 		// player addAction ["Set Patrol Route - Delta", { 
// 		// 	["<t size='1' color='#ffffff' font='PuristaMedium' >DELTA PATROL SELECTED</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", 0];
// 		// 	[4] remoteExec ["RGGp_fnc_patrol_routeManager", 2];
// 		// 	removeAllActions player;
// 		// }, nil, 6, false, true];		
	
// 		// player addAction ["Set Patrol Route - Echo", { 
// 		// 	["<t size='1' color='#ffffff' font='PuristaMedium' >ECHO PATROL SELECTED</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", 0];
// 		// 	[5] remoteExec ["RGGp_fnc_patrol_routeManager", 2];
// 		// 	removeAllActions player;
// 		// }, nil, 6, false, true];	
	
// 		// player addAction ["Set Patrol Route - Foxtrot", { 
// 		// 	["<t size='1' color='#ffffff' font='PuristaMedium' >FOXTROT PATROL SELECTED</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", 0];
// 		// 	[6] remoteExec ["RGGp_fnc_patrol_routeManager", 2];
// 		// 	removeAllActions player;
// 		// }, nil, 6, false, true];	
	
// 		// player addAction ["Set Patrol Route - Golf", { 
// 		// 	["<t size='1' color='#ffffff' font='PuristaMedium' >GOLF PATROL SELECTED</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", 0];
// 		// 	[7] remoteExec ["RGGp_fnc_patrol_routeManager", 2];
// 		// 	removeAllActions player;
// 		// }, nil, 6, false, true];
	
// 		// player addAction ["Set Patrol Route - Hotel", { 
// 		// 	["<t size='1' color='#ffffff' font='PuristaMedium' >HOTEL PATROL SELECTED</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", 0];
// 		// 	[8] remoteExec ["RGGp_fnc_patrol_routeManager", 2];
// 		// 	removeAllActions player;
// 		// }, nil, 6, false, true];
	
// 		// player addAction ["Set Patrol Route - Indigo", { 
// 		// 	["<t size='1' color='#ffffff' font='PuristaMedium' >INDIGO PATROL SELECTED</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", 0];
// 		// 	[9] remoteExec ["RGGp_fnc_patrol_routeManager", 2];
// 		// 	removeAllActions player;
// 		// }, nil, 6, false, true];
			



// 		vamp = false;
// 	};
// 	default { systemChat "" };
// };

// [missionnamespace,"arsenalClosed", {
// 	[player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory;
// 	titletext ["LOADOUT SAVED", "PLAIN DOWN", 1];
// }] call bis_fnc_addScriptedEventhandler;

// player addEventHandler ["GetInMan", {
// 	params ["_unit", "_role", "_vehicle", "_turret"];
// 	{
// 		[_vehicle, [-1]] enableInfoPanelComponent [_x,"SensorsDisplayComponent",false]
// 	} forEach ["left","right"];
// 	{
// 		[_vehicle, [-1]] enableInfoPanelComponent [_x,"MinimapDisplayComponent",false]
// 	} forEach ["left","right"];
// 	{
// 		[_vehicle, [-1]] enableInfoPanelComponent [_x,"SlingloadDisplayComponent",false]
// 	} forEach ["left","right"];
// 	{
// 		[_vehicle, [-1]] enableInfoPanelComponent [_x,"CrewDisplayComponent",false]
// 	} forEach ["left","right"];
// }];


// RGG_Fire = true;

// if (KILLCHAINMISSIONSTART) then {
// 	[] remoteExec ["RGGd_fnc_delete_markersJIP", player];
// };

// addMissionEventHandler ["Map", {
// 	params ["_mapIsOpened", "_mapIsForced"];
// 	if (_mapIsOpened) then {
		
// 		_text = "";
// 		[missionNamespace, "RGG_missionState", "PL to set patrol order"] call BIS_fnc_getServerVariable;
// 		switch (RGG_missionState) do {
// 			case 0: { _text = "Platoon Leader has yet to designate patrol order"; };
// 			case 1: { _text = "Pickup ARVN from the PZ at Pathfinder and deploy them at the designated Patrol LZ"; };
// 			case 2: { _text = "Focus all combat efforts on taking the current Patrol Objective"; };
// 			case 3: { _text = "Defend the Objective against incoming NVA Forces"; };
// 			case 4: { _text = "Mission Complete - All units return to FOB Pathfinder"; };
// 			case 5: { _text = "Patrol Stage Complete - Resupply and plan the next assault"; };
// 			case 6: { _text = "Patrol Objective has been overrun by NVA forces - Retake this at all costs"; };
// 			case 7: { _text = "Mission Failed - Return to FOB Pathfinder"; };
// 			default { };
// 		};
// 		[_text, ""] remoteExec ["RGGi_fnc_information_lowerLeft", player]; 

// 		_groups = allGroups; 
// 		private _RGG_bluforGroups = []; 
// 		private _RGG_indiforGroups = []; 
// 		{
// 			switch ((side _x)) do {
// 				case INDEPENDENT: { _RGG_indiforGroups pushBackUnique _x };
// 				case WEST: { _RGG_bluforGroups pushBackUnique _x };
// 			};
// 		} forEach _groups;

// 		{
// 			_size = count units _x; 
// 			if (_size > 0) then {
// 				_leaderPos = getPos (leader _x);

// 				if ((_leaderPos select 2) < 2) then {				

// 					if (_leaderPos inArea "pathfinderBase") then {
// 						systemChat "";
// 					} else {
// 						_stampToString = str _x;
// 						deleteMarkerLocal _stampToString;
// 						_tempMarker = createMarkerLocal [_stampToString, _leaderPos];
// 						_tempMarker setMarkerTypeLocal "n_inf";						
// 						_sizeStr = str _size;
// 						if (_size > 1) then {
// 							_stampToString2 = _stampToString + " ¦ " + _sizeStr + " UNITS"; 
// 							_tempMarker setMarkerTextLocal _stampToString2;						
// 						};
// 						// _tinManPos = [] call RGGg_fnc_get_tinmanPos;					
// 						// _checkDist = _tinManPos distance _leaderPos;
// 						// if (_checkDist < 500) then {
// 						// 	_tempMarker setMarkerAlphaLocal 0.9;
// 						// } else {
// 						// 	_tempMarker setMarkerAlphaLocal 0.5;
// 						// };
// 					};
// 				};
// 			};
// 		} forEach _RGG_indiforGroups;

// 		{
// 			_size = count units _x; 
// 			if (_size > 0) then {
				
// 				_leaderPos = getPos (leader _x);

// 				if ((_leaderPos select 2) > 2) then {
// 					_stampToString = str _x;
// 					deleteMarkerLocal _stampToString;
// 					_tempMarker = createMarkerLocal [_stampToString, _leaderPos];
// 					_tempMarker setMarkerTypeLocal "b_air";
// 				} else {
// 					if (_leaderPos inArea "pathfinderBase") then {
// 					} else {
// 						_stampToString = str _x;
// 						deleteMarkerLocal _stampToString;
// 						_tempMarker = createMarkerLocal [_stampToString, _leaderPos];
// 						_tempMarker setMarkerTypeLocal "b_inf";
// 						_sizeStr = str _size;
// 						if (_size > 1) then {
// 							if ((_leaderPos select 2) < 2) then {
// 								_stampToString2 = _stampToString + " ¦ " + _sizeStr + " UNITS"; 
// 								_tempMarker setMarkerTextLocal _stampToString2;		
// 							};
// 						};
// 						// if (isPlayer _leader) then {
// 						// 	_name = str player;
// 						// 	_tempMarker setMarkerTextLocal _name;					
// 						// };
// 						if (isPlayer (leader _x)) then {
// 							_tempMarker setMarkerTextLocal (name player);					
// 						};
// 					};
// 				};
// 			};
// 		} forEach _RGG_bluforGroups;
// 	};
	
// 	if (!_mapIsOpened) then {
// 		["", ""] remoteExec ["RGGi_fnc_information_lowerLeft", player]; 

// 		_groups = allGroups;  
// 		private _RGG_bluforGroups = []; 
// 		private _RGG_indiforGroups = [];
// 		{
// 			switch ((side _x)) do {
// 				case INDEPENDENT: { _RGG_indiforGroups pushBackUnique _x };
// 				case WEST: { _RGG_bluforGroups pushBackUnique _x };
// 			};
// 		} forEach _groups;

// 		{
// 			_stampToString = str _x;
// 			deleteMarkerLocal _stampToString;
// 		} forEach _RGG_indiforGroups;
// 		{
// 			_stampToString = str _x;
// 			deleteMarkerLocal _stampToString;
// 		} forEach _RGG_bluforGroups;
// 	};

// }];

// if (_didJIP) then {	

// 	if (KILLCHAINMISSIONSTART) then {
// 		sleep 4;
// 		{playSound "alreadyLive"} remoteExec ["call", _player];
// 		sleep 4;
// 		[0, "BLACK", 3, 1] spawn BIS_fnc_fadeEffect;  
// 		[_player] remoteExec ["RGGu_fnc_utilities_teleportJIP", 2];
// 		sleep 5;
// 		[1, "BLACK", 5, 1] spawn BIS_fnc_fadeEffect; 
// 	};
// };




