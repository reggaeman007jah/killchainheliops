/*
spawn_opforHK FNC 
Updated: 08 Nov 2023
Purpose: Spawns HK VC Teams and gets them to hunt players 
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
while {SPECOPSATTACKS} do {
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
		if (_dist > 1500) then {
			_dataStore2 pushback _x;
		};
	} forEach _dataStore;

	_cnt = count _dataStore2;
	if (_cnt > 0) then {

		_ranTarget = selectRandom _dataStore2; 
		_spawnPosX = [(getPos _ranTarget), 200, 400, 10, 0, 1, 0, 400] call RGGf_fnc_find_locationNoPlayers;
		_spawnPosData = [_spawnPosX, 100, 6] call RGGg_fnc_get_nearestBushes;
		_opGroup = createGroup [east, true];
		_ehUnits = [];
		_cnt = count _spawnPosData;
		if (_cnt > 0) then {
			{
				_unit = _opGroup createUnit [(selectRandom _specOps), _x, [], 0.1, "none"]; 
				_ehUnits pushBack _unit;
				bluforZeus addCuratorEditableObjects [[_unit], true];
				sleep 0.2;		
			} forEach _spawnPosData; 
		} else {
			for "_i" from 1 to 6 do {
				_pos = _spawnPosX getPos [(random 25), (random 359)];
				_unit = _opGroup createUnit [(selectRandom _specOps), _pos, [], 0.1, "none"]; 
				_ehUnits pushBack _unit;
				bluforZeus addCuratorEditableObjects [[_unit], true];
				sleep 0.2;
			};		
		};
		_opGroup setCombatMode "white";
		[_ehUnits] execVM "eventHandlers\addMP_Killed_EH.sqf";
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
	sleep 120;  
};
