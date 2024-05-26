/*
Get Direction of Travel FNC 
Updated: 10 Nov 2023 

Purpose: Runs over a set time and returns whether the target is moving in a set direction (and if so, the dir), or not 

Notes:
- the idea here is that if wee detect that a player is moving in one directio, we sent the SOG team ahead of the player 
- if not clear, they roughly surround the player if stationary 
- or if player is moving, they trail behind player pos 
- only run this if the upstream system detects movement 
*/

params ["_target"];

// init rtn 
_data = [false];

_pos1 = getPos _target;
_dir1 = getRelDir _target;
sleep 5;
_pos2 = getPos _target;
_dir2 = getRelDir _target;

// establish if moving 
_distMoved = _pos1 distance _pos2;

if (_distMoved > 5) then {
	// we have some movement 
	systemChat "target is Oscar Mike";
	// now establish if dir is similar - if not clear direction, then just return false  
	systemChat format ["first dir check: %1", _dir1];
	systemChat format ["second dir check: %1", _dir2];

	if (
		(_dir2 == _dir1) or 
		(_dir2 < 10) or 
		(_dir2 > 350)
	) then {
		systemChat "We have a clear direction - get ahead pos";
		_goTo = _pos2 getPos [40, (getDir _target)];
		_data = [false, _goTo];
	} else {
		_data = [false];
	};

} else {
	// we have no movement - return array with false
	_data = [false];
};

_data;