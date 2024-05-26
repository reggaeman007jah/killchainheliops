// one shot info on pilot request 
// uses an existing target marker - need to work out what to do if does not exist! 
// maybe an initial isExist bool? but for now work around assumption oneshot is always done after LZ has been created 


_marker = str player;
_player = player;
_pos = getMarkerpos _marker;

// systemChat format ["_playerPos: %1 _marker %2 _targetPos %3", _playerPos, _marker, _targetPos];


systemChat "wayfinder ONESHOT running";

// params ["_pos", "_cp", "_player"];

// systemChat format ["_pos: %1 _cp: %2 _player: %3", _pos, _cp, _player];
_heli = vehicle _player;
_slp = 20; // default sleep val 


// init decs 
_ner = false;
_med = false;
_far = false;
_adj = true;
// controls level/type of detail given 


_currentPos = getPos player;
_currentPos deleteAt 2;

_targetPos = _pos;
_targetPos deleteAt 2;

_dist = floor (_currentPos distance _targetPos);

// systemChat format ["DEBUG - Your target LZ is %1m away", _dist];
_facing = floor (getdir _heli);
// systemChat format ["DEBUG - Your current heading: %1", _facing];
_rel = floor (_heli getRelDir _targetPos);
// systemChat format ["DEBUG - Target is at %1 degrees relative", _rel];

switch (true) do {	
	case (_dist > 1000):  						{ _slp = 20; _ner = false; _med = false; _far = true };
	case ((_dist < 1000) && (_dist > 500)):  	{ _slp = 10; _ner = false; _med = true; _far = false };
	case (_dist < 500): 						{ _slp = 4; _ner = true; _med = false; _far = false };
	default { systemChat "error, wayfinder dist switch" };
};


switch (true) do {
	case ((_rel > 345) or (_rel <= 15)):   { format ["--- Target is %1m at your 12", _dist] remoteExec ["systemChat", _player]; _adj = true; };
	case ((_rel > 15)  && (_rel <= 45)):   { format ["--- Target is %1m at your 1 O'Clock", _dist] remoteExec ["systemChat", _player]; _adj = true; };
	case ((_rel > 45)  && (_rel <= 75)):   { format ["--- Target is %1m at your 2 O'Clock", _dist] remoteExec ["systemChat", _player]; _adj = true; };
	case ((_rel > 75)  && (_rel <= 105)):  { format ["--- Target is %1m at your 3 O'Clock", _dist] remoteExec ["systemChat", _player]; _adj = true; };
	case ((_rel > 105) && (_rel <= 135)):  { format ["--- Target is %1m at your 4 O'Clock", _dist] remoteExec ["systemChat", _player]; _adj = true; };
	case ((_rel > 135) && (_rel <= 165)):  { format ["--- Target is %1m at your 5 O'Clock", _dist] remoteExec ["systemChat", _player]; _adj = true; };
	case ((_rel > 165) && (_rel <= 195)):  { format ["--- Target is %1m at your 6", _dist] remoteExec ["systemChat", _player]; _adj = true; };
	case ((_rel > 195) && (_rel <= 225)):  { format ["--- Target is %1m at your 7 O'Clock", _dist] remoteExec ["systemChat", _player]; _adj = true; };
	case ((_rel > 225) && (_rel <= 255)):  { format ["--- Target is %1m at your 8 O'Clock", _dist] remoteExec ["systemChat", _player]; _adj = true; };
	case ((_rel > 255) && (_rel <= 285)):  { format ["--- Target is %1m at your 9 O'Clock", _dist] remoteExec ["systemChat", _player]; _adj = true; };
	case ((_rel > 285) && (_rel <= 315)):  { format ["--- Target is %1m at your 10 O'Clock", _dist] remoteExec ["systemChat", _player]; _adj = true; };
	case ((_rel > 315) && (_rel <= 345)):  { format ["--- Target is %1m at your 11 O'Clock", _dist] remoteExec ["systemChat", _player]; _adj = true; };
	default { systemChat "error, wayfinder clock switch" };
};

// get heading diff and adjust 
if (_adj) then {
	switch (true) do {
		case (_rel == 0): { systemChat format ["--- Do not adjust to right, Target is at %1 degrees", _rel]; };
		case (_rel > 315): { 
			_diff = 360 - _rel;
			_new = _facing - _diff;
			format ["--- Adjust left by %2 degrees, Target is at relative %1 degrees", _rel, _diff] remoteExec ["systemChat", _player]; 
			format ["--- Our Heading is %1, we need to adjust to heading %2", _facing, _new] remoteExec ["systemChat", _player]; 
		};
		case ((_rel > 0) && (_rel < 45)): { 
			_diff = 0 + _rel;
			_new = _facing + _diff;		
			format ["--- Adjust right by %2 degrees, Target is at relative %1 degrees", _rel, _diff] remoteExec ["systemChat", _player]; 
			format ["--- Our Heading is %1, we need to adjust to heading %2", _facing, _new] remoteExec ["systemChat", _player]; 
		};
		default { default { systemChat "error, _adj diff switch" }; };
	};
};



