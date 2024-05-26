/*
One-shot course adjustment info for pilots 

Purpose: 
	This will tell the pilot:
	- Their current heading 
	- Heading of target LZ relative to them 
	- How much to adjust, in degrees, and whether left or right - but only if in roughly 
	  right direction 

*/

systemChat "DEBUG - wayfinder adj one-shot FNC running";



private _fnc_getCoPilots = {
	private _copilotTurrets = allTurrets _this select { getNumber ([_this, _x] call BIS_fnc_turretConfig >> "isCopilot") > 0 };
	private _copilots = _copilotTurrets apply { _this turretUnit _x };
	_copilots;
};



_marker = str player; // gets any marker using the player name as unique name - keeps things unique for each player 
_player = player; // does this work in MP?
_pos = getMarkerpos _marker; // gets position of created marker with player name 
_heli = vehicle _player; // heli of player using the system 
_cp = (_heli call _fnc_getCoPilots);
_coP = _cp select 0; // copilot object for sound 3d 
_loud = 30; // local control of loudness 



_new = 0; // to hold new heading value 
_diff = 0; // to hold relative difference heading 
_gap = 0.8; // sleep time for audio breaks (numbers)
 

_facing = floor (getdir _heli); // get current heading of heli 
_rel = floor (_heli getRelDir _pos); // get relative heading of target LZ in degrees (I think)


_dAhead = false; // do not adjust info bool init dec 
_aLeft = false; // adjust left info bool init dec 
_aRight = false; // adjust right info bool init dec 
// these ^^ bools are used later (here) to fire off the right audio 
switch (true) do {
	case (_rel == 0): { 
		systemChat format ["--- Debug - Do not adjust, Target is dead ahead at %1 degrees", _rel]; 
		_dAhead = true;
	};
	case (_rel > 315): { 
		_diff = 360 - _rel;
		_new = _facing - _diff;
		format ["--- Debug - Adjust left by %2 degrees, Target is at relative %1 degrees", _rel, _diff] remoteExec ["systemChat", _player]; 
		format ["--- Debug - Our Heading is %1, we need to adjust to heading %2", _facing, _new] remoteExec ["systemChat", _player]; 
		_aLeft = true;
	};
	case ((_rel > 0) && (_rel < 45)): { 
		_diff = 0 + _rel;
		_new = _facing + _diff;		
		format ["--- Debug - Adjust right by %2 degrees, Target is at relative %1 degrees", _rel, _diff] remoteExec ["systemChat", _player]; 
		format ["--- Debug - Our Heading is %1, we need to adjust to heading %2", _facing, _new] remoteExec ["systemChat", _player]; 
		_aRight = true;
	};
	default { default { systemChat "error, _adj diff switch" }; };
};


sleep 5;



_facingStr = str _facing; // heading value into string 
systemChat format ["DEBUG - _facingStr %1 _facing :%2", _facingStr, _facing];


if (_facing < 100) then {
	// insert 0 into _facingStr at zero index / example: string insert [index, substring]
	_facingStr = _facingStr insert [0, "0"];
	systemChat "facing is less than 100";
};
systemChat format ["DEBUG - _facingStr %1",_facingStr];
if (_facing < 10) then {
	// insert 0 into _facingStr at zero index
	_facingStr = _facingStr insert [0, "0"];
	systemChat "facing is less than 10";
};
systemChat format ["DEBUG - _facingStr %1",_facingStr];
if (_facing < 1) then {
	// insert 0 into _facingStr at zero index
	_facingStr = _facingStr insert [0, "0"];
	systemChat "facing is less than 1 - ie must be zero degrees";
};
systemChat format ["DEBUG - _facingStr %1",_facingStr];
// manage zeros end 


// populate _facingStrArray data array 
_x1 = _facingStr select [0,1];
_x2 = _facingStr select [1,1];
_x3 = _facingStr select [2,1];
systemChat format ["DEBUG - pushback _x1 %1", _x1];
systemChat format ["DEBUG - pushback _x2 %1", _x2];
systemChat format ["DEBUG - pushback _x3 %1", _x3];
_facingStrArray = [];
_facingStrArray pushBack _x1;
_facingStrArray pushBack _x2;
_facingStrArray pushBack _x3;
systemChat format ["DEBUG - _facingStrArray %1",_facingStrArray];
// populate _facingStrArray data array end 


// say "heading"  
_coP say3D ["squelch", _loud, 1, true];
sleep 0.3;
_coP say3D ["currentH", _loud, 1, true];
sleep 1.4;
{
	switch (_x) do {
		case ("0"): { _coP say3D ["n0", _loud, 1, true]; sleep _gap; systemChat format ["_x: %1", _x]; };
		case ("1"): { _coP say3D ["n1", _loud, 1, true]; sleep _gap; systemChat format ["_x: %1", _x]; };
		case ("2"): { _coP say3D ["n2", _loud, 1, true]; sleep _gap; systemChat format ["_x: %1", _x]; };
		case ("3"): { _coP say3D ["n3", _loud, 1, true]; sleep _gap; systemChat format ["_x: %1", _x]; };
		case ("4"): { _coP say3D ["n4", _loud, 1, true]; sleep _gap; systemChat format ["_x: %1", _x]; };
		case ("5"): { _coP say3D ["n5", _loud, 1, true]; sleep _gap; systemChat format ["_x: %1", _x]; };
		case ("6"): { _coP say3D ["n6", _loud, 1, true]; sleep _gap; systemChat format ["_x: %1", _x]; };
		case ("7"): { _coP say3D ["n7", _loud, 1, true]; sleep _gap; systemChat format ["_x: %1", _x]; };
		case ("8"): { _coP say3D ["n8", _loud, 1, true]; sleep _gap; systemChat format ["_x: %1", _x]; };
		case ("9"): { _coP say3D ["n9", _loud, 1, true]; sleep _gap; systemChat format ["_x: %1", _x]; };
		default { systemChat "ERROR - heading number not found..."; };
	};
} forEach _facingStrArray;



sleep 2.4; // this sleep enables above audio to play out ^^
_coP say3D ["squelch", _loud, 1, true];
sleep 0.3;


// TARGET - AUDIO SECTION 
_relStr = str _rel; // target value into string 
systemChat format ["DEBUG - _relStr %1 _rel :%2", _relStr, _rel];


// manage zeros 
if (_rel < 100) then {
	// insert 0 into _newStr at zero index
	// string insert [index, substring]
	_relStr = _relStr insert [0, "0"];
	systemChat "facing is less than 100";
};
systemChat format ["DEBUG - _relStr %1",_relStr];
if (_rel < 10) then {
	// insert 0 into _newStr at zero index
	_relStr = _relStr insert [0, "0"];
	systemChat "facing is less than 10";
};
systemChat format ["DEBUG - _facingStr %1",_facingStr];
if (_rel < 1) then {
	// insert 0 into _newStr at zero index
	_relStr = _relStr insert [0, "0"];
	systemChat "facing is less than 1 - ie must be zero degrees";
};
systemChat format ["DEBUG - _newStr %1", _relStr];
// manage zeros end 


// populate _newStrArray data array 
_x1 = _relStr select [0,1];
_x2 = _relStr select [1,1];
_x3 = _relStr select [2,1];
systemChat format ["DEBUG - pushback _x1 %1", _x1];
systemChat format ["DEBUG - pushback _x2 %1", _x2];
systemChat format ["DEBUG - pushback _x3 %1", _x3];
_relStrArray = [];
_relStrArray pushBack _x1;
_relStrArray pushBack _x2;
_relStrArray pushBack _x3;
systemChat format ["DEBUG - _newStrArray %1",_relStrArray];
// populate _facingStrArray data array end 


// say "target"  
_coP say3D ["squelch", _loud, 1, true];
sleep 0.3;
_coP say3D ["targetH", _loud, 1, true];
sleep 1.4;
{
	switch (_x) do {
		case ("0"): { { _coP say3D ["n0", _loud, 1, true]; }; sleep _gap; };
		case ("1"): { { _coP say3D ["n1", _loud, 1, true]; }; sleep _gap; };
		case ("2"): { { _coP say3D ["n2", _loud, 1, true]; }; sleep _gap; };
		case ("3"): { { _coP say3D ["n3", _loud, 1, true]; }; sleep _gap; };
		case ("4"): { { _coP say3D ["n4", _loud, 1, true]; }; sleep _gap; };
		case ("5"): { { _coP say3D ["n5", _loud, 1, true]; }; sleep _gap; };
		case ("6"): { { _coP say3D ["n6", _loud, 1, true]; }; sleep _gap; };
		case ("7"): { { _coP say3D ["n7", _loud, 1, true]; }; sleep _gap; };
		case ("8"): { { _coP say3D ["n8", _loud, 1, true]; }; sleep _gap; };
		case ("9"): { { _coP say3D ["n9", _loud, 1, true]; }; sleep _gap; };
		default { systemChat "ERROR - target heading number not found..."; };
	};
} forEach _relStrArray;
sleep 2;
_coP say3D ["squelch", _loud, 1, true];
// say "target" end 
// TARGET - AUDIO SECTION END 


sleep 2.4; // this sleep enables above audio to play out ^^
_coP say3D ["squelch", _loud, 1, true];
sleep 0.3;


if ((_dAhead) or (_aLeft) or (_aRight)) then {
	// do the corridor adjust thing 	

	switch (true) do {
		case (_diff == 0): {
			systemChat "diff is zero degrees - dead on audio here // 00";
			// we need an audio file to run that says "perfect heading, maintain exact course"
			// ACTION - create this file 
		}; 
		case ((_diff > 0) && (_diff < 10)): {
			systemChat "diff is greater than zero and less than ten // 1-9";

			switch (true) do {
				case (_aLeft): 	{
					switch (_diff) do {
						case 1: { _coP say3D ["Lzero1", _loud, 1, true] }; // BEAR LEFT ONE DEGREE 
						case 2: { _coP say3D ["Lzero2", _loud, 1, true] };
						case 3: { _coP say3D ["Lzero3", _loud, 1, true] };
						case 4: { _coP say3D ["Lzero4", _loud, 1, true] };
						case 5: { _coP say3D ["Lzero5", _loud, 1, true] };
						case 6: { _coP say3D ["Lzero6", _loud, 1, true] };
						case 7: { _coP say3D ["Lzero7", _loud, 1, true] };
						case 8: { _coP say3D ["Lzero8", _loud, 1, true] };
						case 9: { _coP say3D ["Lzero9", _loud, 1, true] };
						default { };
						// ACTION - create these files  
					};
				}; 
				case (_aRight): {
					switch (_diff) do {
						case 1: { _coP say3D ["Rzero1", _loud, 1, true] };
						case 2: { _coP say3D ["Rzero2", _loud, 1, true] };
						case 3: { _coP say3D ["Rzero3", _loud, 1, true] };
						case 4: { _coP say3D ["Rzero4", _loud, 1, true] };
						case 5: { _coP say3D ["Rzero5", _loud, 1, true] };
						case 6: { _coP say3D ["Rzero6", _loud, 1, true] };
						case 7: { _coP say3D ["Rzero7", _loud, 1, true] };
						case 8: { _coP say3D ["Rzero8", _loud, 1, true] };
						case 9: { _coP say3D ["Rzero9", _loud, 1, true] };
						default { };
						// ACTION - create these files  
					};
				}; 
				default	{ systemChat "error, strawberry" }; 
			};
		}; 
		case (_diff >= 10): {

			switch (true) do {
				case (_aLeft): 	{ _coP say3D ["adjL", _loud, 1, true] }; 
				case (_aRight): { _coP say3D ["adjL", _loud, 1, true] }; 
				default			{ systemChat "error, banana" }; 
			};

			// then we relay the diff in numbers - we know here there are two numbers that make up the diff 
			_diffStr = str _diff; // target value into string 
			systemChat format ["DEBUG - _newStr %1 _new :%2", _newStr, _new];

			// populate _diffArray data array 
			_x1 = _diffStr select [0,1];
			_x2 = _diffStr select [1,1];
			systemChat format ["DEBUG - pushback _x1 %1", _x1];
			systemChat format ["DEBUG - pushback _x2 %1", _x2];
			_diffArray = [];
			_diffArray pushBack _x1;
			_diffArray pushBack _x2;
			systemChat format ["DEBUG - _newStrArray %1",_diffArray];
			// populate _facingStrArray data array end 

			{
				switch (_x) do {
					case ("0"): { { _coP say3D ["n0", _loud, 1, true]; }; sleep _gap; };
					case ("1"): { { _coP say3D ["n1", _loud, 1, true]; }; sleep _gap; };
					case ("2"): { { _coP say3D ["n2", _loud, 1, true]; }; sleep _gap; };
					case ("3"): { { _coP say3D ["n3", _loud, 1, true]; }; sleep _gap; };
					case ("4"): { { _coP say3D ["n4", _loud, 1, true]; }; sleep _gap; };
					case ("5"): { { _coP say3D ["n5", _loud, 1, true]; }; sleep _gap; };
					case ("6"): { { _coP say3D ["n6", _loud, 1, true]; }; sleep _gap; };
					case ("7"): { { _coP say3D ["n7", _loud, 1, true]; }; sleep _gap; };
					case ("8"): { { _coP say3D ["n8", _loud, 1, true]; }; sleep _gap; };
					case ("9"): { { _coP say3D ["n9", _loud, 1, true]; }; sleep _gap; };
					default { systemChat "ERROR - target heading number not found..."; };
				};
			} forEach _diffArray;
		}; 
		default { systemChat "error, diff audio switch" }; 
	};

	// ACTION - create squelch 
};






























// _x1 = 0; // init dec 
// if (_new < 100) then {
// 	// manually force a zero at index 0 
// 	_x1 = 0;
// 	systemChat format ["DEBUG - _x1 %1", _x1];
// } else {
// 	_x1 = _newStr select [0,1];
// 	systemChat format ["DEBUG - _x1 %1", _x1];
// };
// _x2 = _newStr select [1,1];
// systemChat format ["DEBUG - _x2 %1", _x2];
// _x3 = _newStr select [2,1];
// systemChat format ["DEBUG - _x3 %1", _x3];

// _newStrArray = [];
// _newStrArray pushBack _x1;
// _newStrArray pushBack _x2;
// _newStrArray pushBack _x3;
// systemChat format ["DEBUG - _newStrArray %1",_newStrArray];

// // say "target" here 
// _coP say3D ["targetH", 3, 1, true];
// sleep 1.4;
// {
// 	switch (_x) do {
// 		case ("0"): { {playSound "n0"} remoteExec ["call",_player]; sleep _gap; };
// 		case ("1"): { {playSound "n1"} remoteExec ["call",_player]; sleep _gap; };
// 		case ("2"): { {playSound "n2"} remoteExec ["call",_player]; sleep _gap; };
// 		case ("3"): { {playSound "n3"} remoteExec ["call",_player]; sleep _gap; };
// 		case ("4"): { {playSound "n4"} remoteExec ["call",_player]; sleep _gap; };
// 		case ("5"): { {playSound "n5"} remoteExec ["call",_player]; sleep _gap; };
// 		case ("6"): { {playSound "n6"} remoteExec ["call",_player]; sleep _gap; };
// 		case ("7"): { {playSound "n7"} remoteExec ["call",_player]; sleep _gap; };
// 		case ("8"): { {playSound "n8"} remoteExec ["call",_player]; sleep _gap; };
// 		case ("9"): { {playSound "n9"} remoteExec ["call",_player]; sleep _gap; };
// 		default { systemChat "ERROR - target number not found..."; };
// 	};
// } forEach _newStrArray;
// // TARGET AUDIO END 














// below is stuff to use ... 

/*


params ["_pos", "_cp", "_player"];

// systemChat format ["_pos: %1 _cp: %2 _player: %3", _pos, _cp, _player];
_heli = vehicle _player;
_slp = 20; // default sleep val 

// debug marker 
// _anchor = createMarker ["radarPos", _pos];
// _anchor setMarkerShape "ELLIPSE";
// _anchor setMarkerSize [800,800];
// _anchor setMarkerAlpha 0.3;
// _anchor setMarkerDir _dir;
_stampToString = str _player;
deleteMarker _stampToString;
_tempMarker = createMarker [_stampToString, _pos];
_tempMarker setMarkerType "hd_pickup";
// _tempMarker setMarkerText _stampToString;

// init decs 
_ner = false;
_med = false;
_far = false;
_adj = true;
// controls level/type of detail given 

while {RGG_cpOn} do {
	_currentPos = getPos _player;
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

	// _distance = "20 Kliks";
	// switch (true) do {
	// 	case (_dist >= 20000): { _distance = "20+ kliks" }
	// 	case ((_dist >= 19000) && (_dist < 20000)): { _distance = "19 kliks"  };
	// 	case ((_dist >= 18000) && (_dist < 19000)): { _distance = "18 kliks"  };
	// 	case ((_dist >= 17000) && (_dist < 18000)): { _distance = "17 kliks"  };
	// 	case ((_dist >= 16000) && (_dist < 17000)): { _distance = "16 kliks"  };
	// 	case ((_dist >= 15000) && (_dist < 16000)): { _distance = "15 kliks"  };
	// 	case ((_dist >= 14000) && (_dist < 15000)): { _distance = "14 kliks"  };
	// 	case ((_dist >= 13000) && (_dist < 14000)): { _distance = "13 kliks"  };
	// 	case ((_dist >= 12000) && (_dist < 13000)): { _distance = "12 kliks"  };
	// 	case ((_dist >= 11000) && (_dist < 12000)): { _distance = "11 kliks"  };
	// 	case ((_dist >= 10000) && (_dist < 11000)): { _distance = "10 kliks"  };
	// 	default { };
	// };
	// if (_ner) then {
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
	// };
// format ["debug - running runCPD, deploying: %1", _cpdGroup] remoteExec ["systemChat", 0]; // does this work??
	// use iteration counts to make the distance happen once in three, but adjustments every time 

	// this is turniong into a looping nightmare - maybe this needs to be reactive, responsive to commands?
	// they can be one off of order to cycle 

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

	// so i have realised that the distance from target has a bearing on your 'ahead tolerance'. If you are say 5km from target, at your actual and 
	// rel degree heading is off by 1, then I'd say you are on track, and no adjustment is needed. Lets get this working then refine 
	// also, enable player to toggle diff readings and general clock info 

	


	// if (_med) then {
	// 	switch (true) do {
	// 		case ((_rel > 345) or (_rel <= 15)):   { systemChat format ["--- Target is %1m at your 12 O'Clock DEAD AHEAD", _dist] };
	// 		case ((_rel > 15)  && (_rel <= 45)):   { systemChat format ["--- Target is %1m at your 1 O'Clock", _dist] };
	// 		case ((_rel > 45)  && (_rel <= 75)):   { systemChat format ["--- Target is %1m at your 2 O'Clock", _dist] };
	// 		case ((_rel > 75)  && (_rel <= 105)):  { systemChat format ["--- Target is %1m at your 3 O'Clock", _dist] };
	// 		case ((_rel > 105) && (_rel <= 135)):  { systemChat format ["--- Target is %1m at your 4 O'Clock", _dist] };
	// 		case ((_rel > 135) && (_rel <= 165)):  { systemChat format ["--- Target is %1m at your 5 O'Clock", _dist] };
	// 		case ((_rel > 165) && (_rel <= 195)):  { systemChat format ["--- Target is %1m at your 6 O'Clock", _dist] };
	// 		case ((_rel > 195) && (_rel <= 225)):  { systemChat format ["--- Target is %1m at your 7 O'Clock", _dist] };
	// 		case ((_rel > 225) && (_rel <= 255)):  { systemChat format ["--- Target is %1m at your 8 O'Clock", _dist] };
	// 		case ((_rel > 255) && (_rel <= 285)):  { systemChat format ["--- Target is %1m at your 9 O'Clock", _dist] };
	// 		case ((_rel > 285) && (_rel <= 315)):  { systemChat format ["--- Target is %1m at your 10 O'Clock", _dist] };
	// 		case ((_rel > 315) && (_rel <= 345)):  { systemChat format ["--- Target is %1m at your 11 O'Clock", _dist] };
	// 		default { systemChat "error, wayfinder clock switch" };
	// 	};
	// };


	sleep _slp;
};


