/*
spawn_opforHKNear FNC 
Updated: 08 Nov 2023
Purpose: Spawns single HK VC Units and gets them to hunt players 
Author: Reggs 
*/

params ["_delay"]; 

sleep _delay;
_specOps = [
	"vn_o_men_vc_regional_01",
	"vn_o_men_vc_regional_02",
	"vn_o_men_vc_regional_03",
	"vn_o_men_vc_regional_04",
	"vn_o_men_vc_regional_05",
	"vn_o_men_vc_regional_06",
	"vn_o_men_vc_regional_07",
	"vn_o_men_vc_regional_08",
	"vn_o_men_vc_regional_09",
	"vn_o_men_vc_regional_10",
	"vn_o_men_vc_regional_11",
	"vn_o_men_vc_regional_12"
];
waitUntil {KILLCHAINISLIVE};
_chk = true;
while {_chk} do {
	
	if (KILLCHAINISLIVE) then {
		_chk = false;
	} else {
		_chk = true;
	};
	sleep 30;
};

while {SPECOPSATTACKS2} do {
	_dataStore = [];
	{
		_playerPos = getPos _x;
		if ((_playerPos select 2) < 2) then {
			_dataStore pushback _x;
		};
	} forEach allPlayers;
	_dataStore2 = [];
	{
		_dist = ammo1 distance _x;
		_check = _x inArea "missionCore";
		if ((_dist > 1500) && (_check == false)) then {
			_dataStore2 pushback _x;
		};
	} forEach _dataStore;
	_cnt = count _dataStore2;
	if (_cnt > 0) then {
		_ranTarget = selectRandom _dataStore2; 
		_objPos = [] call RGGg_fnc_get_currentObj;
		_direction = _ranTarget getDir _objPos;
		_anchor = _ranTarget getPos [150, _direction];
		_spawnPosData = [_anchor, 50, 1] call RGGg_fnc_get_nearestBushes;
		if ((count _spawnPosData) == 0) exitWith {};
		_opGroup = createGroup [east, true];
		_ehUnits = [];
		{
			_unit = _opGroup createUnit [(selectRandom _specOps), _x, [], 0.1, "none"]; 
			_ehUnits pushBack _unit;
			bluforZeus addCuratorEditableObjects [[_unit], true];
			sleep 0.2;		
		} forEach _spawnPosData; 
		_opGroup setCombatMode "white";
		[_ehUnits] execVM "eventHandlers\addMP_Killed_EH.sqf";
		sleep 10;
		_hunt = true;
		while {_hunt} do {			
			if (count (units _opGroup) < 1) then { 
				sleep 30;
				_hunt = false;
			} else {
				_target = getPos _ranTarget;
				_opGroup move _target;
			};
			_targetPos = getPos _ranTarget;
			_ldrPos = getPos (leader _opGroup);
			_chkDist = _targetPos distance _ldrPos;
			if (_chkDist > 2000) then {
				_delCheck = true;
				while {_delCheck} do {					  
					if ((count (units _opGroup)) > 0) then {
						_ldrPos = getPos (leader _opGroup);
						_dataStore = [];
						{
							_dist = (getPos _x) distance _ldrPos;
							if (_dist < 200) then {
								_dataStore pushback _x;
							};
						} forEach allPlayers;
						if ((count _dataStore) == 0) then {
							_hunt = false;
							_delCheck = false;
							{
								deleteVehicle _x;
							} forEach (units _opGroup);
						} else {
							sleep 60;
						};
					} else {
						_delCheck = false;
						_hunt = false;
					};					
					sleep 60;
				};
			};
			sleep 60;
		};
	} else {
		systemChat "";
	};
	sleep 20;  
};
