params ["_pos", "_cp", "_player"];

_heli = vehicle _player;
_coP = _cp select 0; 
_loud = 30; 

_stampToString = str _player;
deleteMarker _stampToString;
_tempMarker = createMarker [_stampToString, _pos];
_tempMarker setMarkerType "c_air";

_currentPos = getPos _player;
_currentPos deleteAt 2;
_targetPos = _pos;
_targetPos deleteAt 2;

_dist = floor (_currentPos distance _targetPos);

_facing = floor (getdir _heli);
_rel = floor (_heli getRelDir _targetPos);

_coP say3D ["squelch", _loud, 1, true];
sleep 0.3;
_coP say3D ["plotted", _loud, 1, true];
sleep 1.8;
_coP say3D ["squelch", _loud, 1, true];
sleep 3;

switch (true) do {
	case ((_rel > 345) or (_rel <= 15)):   	{ _coP say3D ["12OC", _loud, 1, true] }; 
	case ((_rel > 15)  && (_rel <= 45)):   	{ _coP say3D ["1OC", _loud, 1, true] }; 
	case ((_rel > 45)  && (_rel <= 75)):   	{ _coP say3D ["2OC", _loud, 1, true] }; 
	case ((_rel > 75)  && (_rel <= 105)):  	{ _coP say3D ["3OC", _loud, 1, true] }; 
	case ((_rel > 105) && (_rel <= 135)):  	{ _coP say3D ["4OC", _loud, 1, true] }; 
	case ((_rel > 135) && (_rel <= 165)):  	{ _coP say3D ["5OC", _loud, 1, true] }; 
	case ((_rel > 165) && (_rel <= 195)):  	{ _coP say3D ["6OC", _loud, 1, true] }; 
	case ((_rel > 195) && (_rel <= 225)):  	{ _coP say3D ["7OC", _loud, 1, true] }; 
	case ((_rel > 225) && (_rel <= 255)):  	{ _coP say3D ["8OC", _loud, 1, true] }; 
	case ((_rel > 255) && (_rel <= 285)):  	{ _coP say3D ["9OC", _loud, 1, true] }; 
	case ((_rel > 285) && (_rel <= 315)):  	{ _coP say3D ["10OC", _loud, 1, true] }; 
	case ((_rel > 315) && (_rel <= 345)):	{ _coP say3D ["11OC", _loud, 1, true] };
	default 								{ systemChat "error, wayfinder clock switch" };
};

sleep 3;

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

