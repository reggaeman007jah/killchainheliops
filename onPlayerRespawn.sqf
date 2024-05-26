params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

// cutText ["","BLACK FADED",2];
// sleep 1;
// [parseText format  
// ["<t align='center' font='PuristaBold' size='2.8'>""Get ready""</t>" ], 
// true, nil,  7, 0.7, 0] spawn BIS_fnc_textTiles;

/*

_newUnit setCustomAimCoef 0.1;
_newUnit addEventHandler ['Respawn',{ _newUnit setCustomAimCoef 0.1 }];

_newUnit setVariable ["RGG_unitIsDown", false, true]; 
RGG_toHeal = []; 
_newUnit addMPEventHandler ["MPHit", {
	params ["_unit", "_causedBy", "_damage", "_instigator"];
	_checkingStatus = _unit getVariable ["RGG_unitIsDown", false]; 
	if (_checkingStatus == false) then {		
		RGG_toHeal pushBackUnique _unit;
		[_unit] execVM "functions_Revive\checkLifeState.sqf";
	};
}];

[_newUnit, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;

_newUnit addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	if ((_ammo == "vn_m18_red_ammo") or (_ammo == "vn_40mm_m682_smoke_r_ammo")) then {
		RGG_CAS = true;
		publicVariableServer "RGG_CAS";
		RGG_CASPROJ = _projectile;
		publicVariableServer "RGG_CASPROJ";
		[_unit] execVM "CAS_timeout.sqf";
		execVM "CAS_projPos.sqf";
	};
}];

_playerRole = roleDescription player;
switch (_playerRole) do {
	case "Viking 1:1 - Platoon Leader@Viking 1": {
		player addAction ["Order: Move to the Objective", { 
			[2] remoteExec ["RGGo_fnc_order_attack", 2];
		}, nil, 6, false, true];
		player addAction ["Order: Move to the Objective - Stealth", { 
			[1] remoteExec ["RGGo_fnc_order_attack", 2];
		}, nil, 6, false, true];
		player addAction ["Order: Move to the Objective - Charge", { 
			[3] remoteExec ["RGGo_fnc_order_attack", 2];
		}, nil, 6, false, true];
		player addAction ["Order: Fallback to my position Immediately", { 
			[] remoteExec ["RGGo_fnc_order_fallBack", 2];
		}, nil, 6, false, true];
		player addAction ["Order: ARVN to hold position", { 
			[] remoteExec ["RGGo_fnc_order_hold", 2];
		}, nil, 6, false, true];
		player addAction ["Order: Recon Overwatch", { 
			[] remoteExec ["RGGo_fnc_order_autoMove", 2];
		}, nil, 6, false, true];
		// player addAction ["Experimental - Enable ARVN Autocombat", { 
		// 	["<t size='1' color='#ffffff' font='PuristaMedium' >ARVN Autocombat Enabled</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", player, true];
		// 	[] remoteExec ["RGGo_fnc_order_enableAutoCombat", 2];
		// }, nil, 6, false, true];
		// player addAction ["Experimental - Disable ARVN Autocombat", { 
		// 	["<t size='1' color='#ffffff' font='PuristaMedium' >ARVN Autocombat Disabled</t>",0,0.2,3,1] remoteExec ["bis_fnc_dynamictext", player, true];
		// 	[] remoteExec ["RGGo_fnc_order_disableAutoCombat", 2];
		// }, nil, 6, false, true];

		player addAction ["Call CAS", { 
			[[player], "CAS_call.sqf"] remoteExec ["execVM", 2]; 
		}, nil, 6, false, true];

		vamp = false;
	};

	default { systemChat "" };
};

_raptors = false;
{
	_playerRole = roleDescription _x;
	if ( (_playerRole == "Raptor 1 - Squadron Leader@Raptor") or (_playerRole == "Raptor 2 - Squadron 2IC@Raptor") ) then {
		_raptors = true;
	};
} forEach allPlayers;

_respawningDesc = roleDescription _newUnit;  
if (((roleDescription _newUnit) == "Raptor 1 - Squadron Leader@Raptor") or (_respawningDesc == "Raptor 2 - Squadron 2IC@Raptor")) then {
	systemChat "placeholder for Raptor killed message - maybe Padre?";
} else {
	{
		_playerRole = roleDescription _x;

		if ( (_playerRole == "Raptor 1 - Squadron Leader@Raptor") or (_playerRole == "Raptor 2 - Squadron 2IC@Raptor") ) then {
			["SOULS AT PATHFINDER!"] remoteExec ["RGGi_fnc_information_lowerRight", _x];
		} else {
			if (_raptors) then {
				["PILOTS HAVE BEEN ALERTED!"] remoteExec ["RGGi_fnc_information_lowerRight", _newUnit];
			// } else {				
			// 	[_newUnit] spawn RGGh_fnc_heli_respawnPlayer;
			};
		};
	} forEach allPlayers;
};

player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	{
		[_vehicle, [-1]] enableInfoPanelComponent [_x,"SensorsDisplayComponent",false]
	} forEach ["left","right"];
	{
		[_vehicle, [-1]] enableInfoPanelComponent [_x,"MinimapDisplayComponent",false]
	} forEach ["left","right"];
	{
		[_vehicle, [-1]] enableInfoPanelComponent [_x,"SlingloadDisplayComponent",false]
	} forEach ["left","right"];
	{
		[_vehicle, [-1]] enableInfoPanelComponent [_x,"CrewDisplayComponent",false]
	} forEach ["left","right"];
}];


addMissionEventHandler ["Map", {
	params ["_mapIsOpened", "_mapIsForced"];
	if (_mapIsOpened) then {
		
		_text = "";
		[missionNamespace, "RGG_missionState", "PL to set patrol order"] call BIS_fnc_getServerVariable;
		switch (RGG_missionState) do {
			case 0: { _text = "Platoon Leader has yet to designate patrol order"; };
			case 1: { _text = "Pickup ARVN from the PZ at Pathfinder and deploy them at the designated Patrol LZ"; };
			case 2: { _text = "Focus all combat efforts on taking the current Patrol Objective"; };
			case 3: { _text = "Defend the Objective against incoming NVA Forces"; };
			case 4: { _text = "Mission Complete - All units return to FOB Pathfinder"; };
			case 5: { _text = "Patrol Stage Complete - Resupply and plan the next assault"; };
			case 6: { _text = "Patrol Objective has been overrun by NVA forces - Retake this at all costs"; };
			case 7: { _text = "Mission Failed - Return to FOB Pathfinder"; };
			default { };
		};
		[_text, ""] remoteExec ["RGGi_fnc_information_lowerLeft", player]; 

		_groups = allGroups; 
		private _RGG_bluforGroups = []; 
		private _RGG_indiforGroups = []; 
		{
			switch ((side _x)) do {
				case INDEPENDENT: { _RGG_indiforGroups pushBackUnique _x };
				case WEST: { _RGG_bluforGroups pushBackUnique _x };
			};
		} forEach _groups;
		{
			_size = count units _x; 
			if (_size > 0) then {
				_leader = leader _x;
				_leaderPos = getPos _leader;
				if (_leaderPos inArea "pathfinderBase") then {
				} else {
					_stampToString = str _x;
					deleteMarker _stampToString;
					_tempMarker = createMarker [_stampToString, _leaderPos];
					_tempMarker setMarkerType "n_inf";
					_sizeStr = str _size;
					if (_size > 1) then {
						_stampToString2 = _stampToString + " ¦ " + _sizeStr + " UNITS"; 
						_tempMarker setMarkerText _stampToString2;						
					};

				};
			};
		} forEach _RGG_indiforGroups;

		{
			_size = count units _x; 
			if (_size > 0) then {
				_leader = leader _x;
				_leaderPos = getPos _leader;
				if (_leaderPos inArea "pathfinderBase") then {
				} else {
					_stampToString = str _x;
					deleteMarker _stampToString;
					_tempMarker = createMarker [_stampToString, _leaderPos];
					_tempMarker setMarkerType "b_inf";
						_sizeStr = str _size;
					if (_size > 1) then {
						_stampToString2 = _stampToString + " ¦ " + _sizeStr + " UNITS"; 
						_tempMarker setMarkerText _stampToString2;						
					};
					if (isPlayer _leader) then {
						_name = str player;
						_tempMarker setMarkerText _name;					
					};

				};
			};
		} forEach _RGG_bluforGroups;
	};
	
	if (!_mapIsOpened) then {
		["", ""] remoteExec ["RGGi_fnc_information_lowerLeft", player]; 

		_groups = allGroups;  
		private _RGG_bluforGroups = []; 
		private _RGG_indiforGroups = []; 
		{
			switch ((side _x)) do {
				case INDEPENDENT: { _RGG_indiforGroups pushBackUnique _x };
				case WEST: { _RGG_bluforGroups pushBackUnique _x };
			};
		} forEach _groups;
		{
			_stampToString = str _x;
			deleteMarker _stampToString;
		} forEach _RGG_indiforGroups;
		{
			_stampToString = str _x;
			deleteMarker _stampToString;
		} forEach _RGG_bluforGroups;
	};

}];

