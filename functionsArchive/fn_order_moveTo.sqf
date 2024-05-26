/*
Will move given group to given 10-grid:
*/

params ["_grp", "_grids"];
// systemChat format ["_grp: %1, _grids: %2", _grp, _grids];
_latData = _grids select 0;
_lonData = _grids select 1;
_group = _grp select 0;

_lat = format ["%1%2%3%4%5", (_latData select 0), (_latData select 1), (_latData select 2), (_latData select 3), (_latData select 4)]; 
_lon = format ["%1%2%3%4%5", (_lonData select 0), (_lonData select 1), (_lonData select 2), (_lonData select 3), (_lonData select 4)]; 

// systemChat format ["Lat: %1", _lat];
// systemChat format ["Lon: %1", _lon];

_movePos = [];
_parsedLat = parseNumber _lat;
_parsedLon = parseNumber _lon;

// systemChat format ["_parsedLat: %1", _parsedLat];
// systemChat format ["_parsedLon: %1", _parsedLon];

_movePos pushBack _parsedLat;
_movePos pushBack _parsedLon;

// systemChat format ["_movePos: %1", _movePos];

_group move _movePos;
systemChat format ["Group: %1 is moving to grid: %2", _group, _movePos];

// _realLatData = [];
// _realLonData = [];

// _realLatData set [0, (_latData select 0)];
// _realLatData set [0, (_latData select 1)];
// _realLatData set [0, (_latData select 2)];
// _realLatData set [0, (_latData select 3)];
// _realLonData set [0, (_lonData select 0)];
// _realLonData set [0, (_lonData select 1)];
// _realLonData set [0, (_lonData select 2)];
// _realLonData set [0, (_lonData select 3)];

// systemChat format ["_realLatData: %1, _realLonData: %2", _realLatData, _realLonData];


// _lat1 = false;
// _lat2 = false;
// _lat3 = false;
// _lat4 = false;
// _lon1 = false;
// _lon2 = false;
// _lon3 = false;
// _lon4 = false;

// if ((_latData select 0) == 0) then {
// 	_lat1 = true;
// };
// if ((_latData select 1) == 0) then {
// 	_lat2 = true;
// };
// if ((_latData select 2) == 0) then {
// 	_lat3 = true;
// };
// if ((_latData select 3) == 0) then {
// 	_lat4 = true;
// };
// if ((_lonData select 0) == 0) then {
// 	_lon1 = true;
// };
// if ((_lonData select 1) == 0) then {
// 	_lon2 = true;
// };
// if ((_lonData select 2) == 0) then {
// 	_lon3 = true;
// };
// if ((_lonData select 3) == 0) then {
// 	_lon4 = true;
// };

// systemChat format ["%1 %2 %3 %4 %5 %6 %7 %8", _lat1, _lat2, _lat3, _lat4, _lon1, _lon2, _lon3, _lon4];





// _stringTestLan = [_lat] joinString "";
// _countTestLan = count _stringTestLan;
// _stringTestLon	= [_lon] joinString "";
// _countTestLon = count _stringTestLon;

// if (_countTestLan == 3) then {
// 	systemChat "Lat";
// 	_fourNum = "0" + _stringTestLan;
// 	_stringTestLan = _fourNum;
// }; 





// systemChat "now adding zeros";

// if (_lat1 == true) then {
// 	_latData set [0,0];
// };


// _array = ["A"];
// _array set [2, "C"]; // _array is now ["A", nil, "C"]
// _array set [1, "B"]; // _array is now ["A", "B", "C"]





// _finalLan = toArray _stringTestLan;









// sleep 2;

// if (_lat1 = true;) then {
// 	_lat1 = true;
// };




// _cntLat = count _lat;
// _cntLon = count _lon;

// if (_cntLat != 4) then {
// 	systemChat format ["LAT DID NOT PASS VALIDATION - ONLY HAS %1 ELEMENTS", _cntLat];
// 	// add zeros here 
// } else {
// 	systemChat "LAT PASSED VALIDATION";
// };

// if (_cntLon != 4) then {
// 	systemChat format ["LON DID NOT PASS VALIDATION - ONLY HAS %1 ELEMENTS", _cntLon];
// 	// add zeros here 
// } else {
// 	systemChat "LON PASSED VALIDATION";
// // };

// _group move _movePos;
// systemChat format ["Group: %1 is moving to grid: %2", _group, _movePos];


// deleteMarker "test";
// _mkr = createMarker ["test", _movePos];
// _mkr setMarkerType "warning";
// _mkr setMarkerColor "green";




/*
Notes:

e.g. 

Group 1 move to grid 1234 5678 
or 
Group 1, move 700m north west 

Proof of concept 

Player - Group 1 come in 

AI - Group 1 receives, what's the order? 

Player - Group 1, move some distance in some direction 

AI - Copy will move some distance in some direction 

Player - good copy, out (confirms) 



also 

Player - Group 1 come in 

AI - Go for Group 1 Actual 

Player - Group 1, pos rep 

AI - current pos: grid 
AI - currently x meters from objective

Player - Group 1 sitrep 

AI - we have 8 in the group, 2 are badly injured, ammo count is good 




*/

// systemchat str _lan;
// systemchat str _lon;

// _stringTestLan = [_lan] joinString "";
// // _countTestLan = count _stringTestLan;
// _stringTestLon	= [_lon] joinString "";
// // _countTestLon = count _stringTestLon;

// systemchat str _stringTestLan;
// systemchat str _stringTestLon;


// _parseData1	= _parsed_VAHCO_gridSelect2 joinString "";


// parsed_VAHCO_GroupSelect2 	= parseNumber _parsed_VAHCO_GroupSelect;
