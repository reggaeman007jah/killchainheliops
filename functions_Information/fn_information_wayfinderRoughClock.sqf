/*
Gives rough clock-based direction to pilot (not distance )

question - isn;t thius already done using the "vector" command in VA?

*/

// params ["_pos", "_cp", "_player"];
systemChat "DEBUG - wayfinder clock dir running";

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
_loud = 30;


// get 2D positions 
_currentPos = getPos _player;
_currentPos deleteAt 2;
_targetPos = _pos;
_targetPos deleteAt 2;
// get 2D positions end 

// calc dist 
_dist = floor (_currentPos distance _targetPos); // is needed?

// get heading and target heading 
_facing = floor (getdir _heli); // ? is needed here?
_rel = floor (_heli getRelDir _targetPos);

_coP say3D ["squelch", _loud, 1, true];
sleep 0.3;

// feedback / debug 
switch (true) do {
	case ((_rel > 345) or (_rel <= 15)):   { _coP say3D ["12OC", _loud, 1, true] }; 
	case ((_rel > 15)  && (_rel <= 45)):   { _coP say3D ["1OC", _loud, 1, true] }; 
	case ((_rel > 45)  && (_rel <= 75)):   { _coP say3D ["2OC", _loud, 1, true] }; 
	case ((_rel > 75)  && (_rel <= 105)):  { _coP say3D ["3OC", _loud, 1, true] }; 
	case ((_rel > 105) && (_rel <= 135)):  { _coP say3D ["4OC", _loud, 1, true] }; 
	case ((_rel > 135) && (_rel <= 165)):  { _coP say3D ["5OC", _loud, 1, true] }; 
	case ((_rel > 165) && (_rel <= 195)):  { _coP say3D ["6OC", _loud, 1, true] }; 
	case ((_rel > 195) && (_rel <= 225)):  { _coP say3D ["7OC", _loud, 1, true] }; 
	case ((_rel > 225) && (_rel <= 255)):  { _coP say3D ["8OC", _loud, 1, true] }; 
	case ((_rel > 255) && (_rel <= 285)):  { _coP say3D ["9OC", _loud, 1, true] }; 
	case ((_rel > 285) && (_rel <= 315)):  { _coP say3D ["10OC", _loud, 1, true] }; 
	case ((_rel > 315) && (_rel <= 345)):  { _coP say3D ["11OC", _loud, 1, true] }; 
	default { systemChat "error, wayfinder clock switch" };
};

sleep 3;
_coP say3D ["squelch", _loud, 1, true];