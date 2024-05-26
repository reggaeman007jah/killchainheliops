params ["_pos", "_player"];

private _fnc_getCoPilots = {
	private _copilotTurrets = allTurrets _this select { getNumber ([_this, _x] call BIS_fnc_turretConfig >> "isCopilot") > 0 };
	private _copilots = _copilotTurrets apply { _this turretUnit _x };
	_copilots;
};

if !(isNull objectParent _player) then {
	_vic = vehicle _player;

	if (_vic isKindOf "helicopter") then {

		_crew = fullCrew _vic;
		_turrets = [];
		{
			if (_x select 1 == "turret") then {
				_turrets pushBack _x;
			};
		} forEach _crew;

		_cnt = count _turrets;
		if (_cnt > 0) then {
			_cp = (_vic call _fnc_getCoPilots);
			RGG_cpOn = false;
			_coP = _cp select 0;
			_loud = 30;
			_coP say3D ["squelch", _loud, 1, true];
			sleep 0.3;
			_coP say3D ["standby", _loud, 1, true];
			sleep 1.2;
			_coP say3D ["squelch", _loud, 1, true];
			RGG_cpOn = true;
			[_pos, _cp, _player] spawn RGGw_fnc_wayF_wayfinder; 
		} else {
			systemChat ""; 
		};
	} else {
		systemChat "";
	};
} else {
	systemChat "";
};



