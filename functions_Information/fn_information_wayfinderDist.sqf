// oneshot distance reading 
// { _coP say3D ["dUnder20", 3, 1, true]; };
// one shot dist info on pilot request 

// question - this does not seem to have the same 'in heli?' and 'is there a cp?' checks as the main waypoint function - why?

systemChat "DEBUG - wayfinder ONESHOT DIST running";

// CP FNC 
private _fnc_getCoPilots = {
	private _copilotTurrets = allTurrets _this select { getNumber ([_this, _x] call BIS_fnc_turretConfig >> "isCopilot") > 0 };
	private _copilots = _copilotTurrets apply { _this turretUnit _x };
	_copilots;
};
// CP FNC END 

// init vals 
_marker = str player; // gets any marker using the player name as unique name - keeps things unique for each player 
_player = player; // does this work in MP?
_pos = getMarkerpos _marker; // gets position of created marker with player name 
_heli = vehicle _player; // heli of player using the system 
_cp = (_heli call _fnc_getCoPilots);
_coP = _cp select 0; // copilot object for sound 3d 
// init dec 
_cnt = 3;

// remove z from player pos and target pos, so all dist calcs are 2d not 3d 
_currentPos = getPos _player;
_currentPos deleteAt 2;
_targetPos = _pos;
_targetPos deleteAt 2;

// calc dist 
_dist = floor (_currentPos distance _targetPos);
// systemChat format ["DEBUG - _dist %1",_dist];

_loud = 30;

_coP say3D ["squelch", _loud, 1, true];
sleep 0.3;

switch (true) do {
	case (_dist < 20):   							{ _coP say3D ["dUnder20", _loud, 1, true]; };
	case ((_dist >= 20)  && (_dist < 30)):  		{ _coP say3D ["d20m", _loud, 1, true]; };
	case ((_dist >= 30)  && (_dist < 50)):  		{ _coP say3D ["d40m", _loud, 1, true]; };
	case ((_dist >= 50)  && (_dist < 70)):  		{ _coP say3D ["d60m", _loud, 1, true]; };
	case ((_dist >= 70)  && (_dist < 90)):  		{ _coP say3D ["d80m", _loud, 1, true]; };
	case ((_dist >= 90)  && (_dist < 110)):  		{ _coP say3D ["d100m", _loud, 1, true]; };
	case ((_dist >= 110)  && (_dist < 135)):  		{ _coP say3D ["d120m", _loud, 1, true]; };
	case ((_dist >= 135)  && (_dist < 160)):  		{ _coP say3D ["d150m", _loud, 1, true]; };
	case ((_dist >= 160)  && (_dist < 185)):  		{ _coP say3D ["d170m", _loud, 1, true]; };
	case ((_dist >= 185)  && (_dist < 225)):  		{ _coP say3D ["d200m", _loud, 1, true]; };
	case ((_dist >= 225)  && (_dist < 275)):  		{ _coP say3D ["d250m", _loud, 1, true]; };
	case ((_dist >= 275)  && (_dist < 325)):  		{ _coP say3D ["d300m", _loud, 1, true]; };
	case ((_dist >= 325)  && (_dist < 375)):  		{ _coP say3D ["d350m", _loud, 1, true]; };
	case ((_dist >= 375)  && (_dist < 425)):  		{ _coP say3D ["d400m", _loud, 1, true]; };
	case ((_dist >= 425)  && (_dist < 475)):  		{ _coP say3D ["d450m", _loud, 1, true]; };
	case ((_dist >= 475)  && (_dist < 550)):  		{ _coP say3D ["d500m", _loud, 1, true]; };
	case ((_dist >= 550)  && (_dist < 650)):  		{ _coP say3D ["d600m", _loud, 1, true]; };
	case ((_dist >= 650)  && (_dist < 750)):  		{ _coP say3D ["d700m", _loud, 1, true]; };
	case ((_dist >= 750)  && (_dist < 850)):  		{ _coP say3D ["d800m", _loud, 1, true]; };
	case ((_dist >= 850)  && (_dist < 950)):  		{ _coP say3D ["d900m", _loud, 1, true]; };
	case ((_dist >= 950)  && (_dist < 1250)):  		{ _coP say3D ["d1km", _loud, 1, true]; };
	case ((_dist >= 1250)  && (_dist < 1750)): 		{ _coP say3D ["d1halfkm", _loud, 1, true]; };
	case ((_dist >= 1750)  && (_dist < 2250)): 		{ _coP say3D ["d2km", _loud, 1, true]; };
	case ((_dist >= 2250)  && (_dist < 2750)): 		{ _coP say3D ["d2halfkm", _loud, 1, true]; };
	case ((_dist >= 2750)  && (_dist < 3500)): 		{ _coP say3D ["d3km", _loud, 1, true]; };
	case ((_dist >= 3500)  && (_dist < 4500)): 		{ _coP say3D ["d4km", _loud, 1, true]; };
	case ((_dist >= 4500)  && (_dist < 5500)): 		{ _coP say3D ["d5km", _loud, 1, true]; };
	case ((_dist >= 5500)  && (_dist < 6500)): 		{ _coP say3D ["d6km", _loud, 1, true]; };
	case ((_dist >= 6500)  && (_dist < 7500)): 		{ _coP say3D ["d7km", _loud, 1, true]; };
	case ((_dist >= 7500)  && (_dist < 8500)): 		{ _coP say3D ["d8km", _loud, 1, true]; };
	case ((_dist >= 8500)  && (_dist < 9500)): 		{ _coP say3D ["d9km", _loud, 1, true]; };
	case ((_dist >= 9500)  && (_dist < 11000)): 	{ _coP say3D ["d10km", _loud, 1, true]; };
	case ((_dist >= 11000)  && (_dist < 13000)):	{ _coP say3D ["d12km", _loud, 1, true]; };
	case ((_dist >= 13000)  && (_dist < 15000)):	{ _coP say3D ["d14km", _loud, 1, true]; };
	case ((_dist >= 15000)  && (_dist < 17000)):	{ _coP say3D ["d16km", _loud, 1, true]; };
	case ((_dist >= 17000)  && (_dist < 19000)):	{ _coP say3D ["d18km", _loud, 1, true]; };
	case ((_dist >= 19000)  && (_dist < 20000)):	{ _coP say3D ["d20km", _loud, 1, true]; };
	case (_dist >= 20000):							{ _coP say3D ["dLongWay", _loud, 1, true]; };
	default 										{ systemChat "error, wayfinder clock switch" }; 
};
sleep 3;
_coP say3D ["squelch", _loud, 1, true];

