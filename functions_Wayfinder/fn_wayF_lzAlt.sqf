private _fnc_getCoPilots = {
	private _copilotTurrets = allTurrets _this select { getNumber ([_this, _x] call BIS_fnc_turretConfig >> "isCopilot") > 0 };
	private _copilots = _copilotTurrets apply { _this turretUnit _x };
	_copilots;
};

_marker = str player; 
_player = player; 
_pos = getMarkerpos _marker; 
_heli = vehicle _player; 
_cp = (_heli call _fnc_getCoPilots);
_coP = _cp select 0; 
_loud = 30;   
_gap = 0.8; 
_markerASL = _pos select 2;
_aslHeli = getPosASL _heli;
_coP say3D ["squelch", _loud, 1, true]; sleep 0.3;
