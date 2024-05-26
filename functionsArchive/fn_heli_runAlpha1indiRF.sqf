/*
Alpha 1 unitPlay Indi RF FNC
Updated: 16 Nov 2023 

Purpose: Manages the auto-deployment of indifor reinforcements via heli  

Notes:
- runs in server nameSpace
- similar to two other versions, this should be consolidated!
- needs a safety check!!
*/

// heli setup 
_heli = [[15135,113.244,200], 180, "vn_b_air_uh1d_02_07", west] call BIS_fnc_spawnVehicle;
_heli2 = _heli select 0;
[_heli2] execVM "unitCapture\alpha0.sqf";

_indiCargo = [];
for "_i" from 1 to 8 do {
	_indiGroup = createGroup [independent, true];
	_unit = _indiGroup createUnit [[1] call RGGg_fnc_get_randomIndiforClassname, [0,0,100], [], 0.1, "none"];
	_unit moveInCargo _heli2;
	_indiCargo pushBack _unit;
	bluforZeus addCuratorEditableObjects [[_unit], true];
};
[_heli2, _indiCargo] spawn RGGe_fnc_effects_eject;



