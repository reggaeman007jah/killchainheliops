/*
shows PL status of indifor troops 
*/

_dataArray = _this select 0; // array of data elements 

disableSerialization;
601 cutRsc ["COL1", "PLAIN"];
602 cutRsc ["COL2", "PLAIN"];
603 cutRsc ["COL3", "PLAIN"];
604 cutRsc ["COL4", "PLAIN"];
605 cutRsc ["COL5", "PLAIN"];
606 cutRsc ["COL6", "PLAIN"];
607 cutRsc ["COL7", "PLAIN"];
608 cutRsc ["COL8", "PLAIN"];
waitUntil {!isNull (uiNameSpace getVariable "COL1")};


_cnt = count _dataArray;  
systemChat format ["THERE ARE %1 GROUPS TO DISPLAY", _cnt];
_display = [];
switch (_cnt) do {
	case 1: 	{ _display = [1,0,0,0,0,0,0,0,0,0,0,0] };
	case 2: 	{ _display = [1,1,0,0,0,0,0,0,0,0,0,0] };
	case 3: 	{ _display = [1,1,1,0,0,0,0,0,0,0,0,0] };
	case 4: 	{ _display = [1,1,1,1,0,0,0,0,0,0,0,0] };
	case 5: 	{ _display = [1,1,1,1,1,0,0,0,0,0,0,0] };
	case 6: 	{ _display = [1,1,1,1,1,1,0,0,0,0,0,0] };
	case 7: 	{ _display = [1,1,1,1,1,1,1,0,0,0,0,0] };
	case 8: 	{ _display = [1,1,1,1,1,1,1,1,0,0,0,0] };
	case 9: 	{ _display = [1,1,1,1,1,1,1,1,1,0,0,0] };
	case 10: 	{ _display = [1,1,1,1,1,1,1,1,1,1,0,0] };
	case 11: 	{ _display = [1,1,1,1,1,1,1,1,1,1,1,0] };
	case 12: 	{ _display = [1,1,1,1,1,1,1,1,1,1,1,1] };

	default { systemChat "SITREP ISSUE - NO GROUPS" };
};
sleep 1;

if ((_display select 0 ) == 1) then {
	_displayOBJUNITS2 = uiNameSpace getVariable "COL1";
	_setText = _displayOBJUNITS2 displayCtrl 999506;
	_data = _dataArray select 0;
	_grp = _data select 0; 
	_cnt = _data select 3; 
	_leaderPos = _data select 2; 
	_lat = floor (_leaderPos select 0);
	_lon = floor (_leaderPos select 1);
	_cntInj = _data select 4;
	_distPL = _data select 5;
	_distObj = _data select 6;
	_setText ctrlSetStructuredText (parseText format ["
		<t>
			%1 SITREP<br /><br /><br />
			<br /><br />
			Size: %2<br /><br />
			Current Position: <br />
			LAT: %3<br />
			LON: %4<br /><br />
			Injured: %5<br /><br />
			Distance from you: %6<br /><br />
			Distance from Objective: %7<br /><br />
		</t>
	", _grp, _cnt, _lat, _lon, _cntInj, _distPL, _distObj]);
	_setText ctrlSetBackgroundColor [0,0,0,0.5];
} else {
	_displayOBJUNITS1 = uiNameSpace getVariable "COL1";
	_setText = _displayOBJUNITS1 displayCtrl 999506;
	_text = "NO GROUP DATA";
	_setText ctrlSetStructuredText (parseText format ["
		<t>
			%1
		</t>
	", _text]);
	_setText ctrlSetBackgroundColor [0,0,0,0.5];
};

if ((_display select 1 ) == 1) then {
	_displayOBJUNITS2 = uiNameSpace getVariable "COL2";
	_setText = _displayOBJUNITS2 displayCtrl 999507;
	_data = _dataArray select 1;
	_grp = _data select 0; 
	_cnt = _data select 3; 
	_leaderPos = _data select 2; 
	_lat = floor (_leaderPos select 0);
	_lon = floor (_leaderPos select 1);
	_cntInj = _data select 4;
	_distPL = _data select 5;
	_distObj = _data select 6;
	_setText ctrlSetStructuredText (parseText format ["
		<t>
			%1 SITREP<br /><br /><br />
			<br /><br />
			Size: %2<br /><br />
			Current Position: <br />
			LAT: %3<br />
			LON: %4<br /><br />
			Injured: %5<br /><br />
			Distance from you: %6<br /><br />
			Distance from Objective: %7<br /><br />
		</t>
	", _grp, _cnt, _lat, _lon, _cntInj, _distPL, _distObj]);
	_setText ctrlSetBackgroundColor [0,0,0,0.5];
} else {
	_displayOBJUNITS1 = uiNameSpace getVariable "COL2";
	_setText = _displayOBJUNITS1 displayCtrl 999507;
	_text = "NO GROUP DATA";
	_setText ctrlSetStructuredText (parseText format ["
		<t>
			%1
		</t>
	", _text]);
	_setText ctrlSetBackgroundColor [0,0,0,0.5];
};

if ((_display select 2 ) == 1) then {
	_displayOBJUNITS2 = uiNameSpace getVariable "COL3";
	_setText = _displayOBJUNITS2 displayCtrl 999508;
	_data = _dataArray select 2;
	_grp = _data select 0; 
	_cnt = _data select 3; 
	_leaderPos = _data select 2; 
	_lat = floor (_leaderPos select 0);
	_lon = floor (_leaderPos select 1);
	_cntInj = _data select 4;
	_distPL = _data select 5;
	_distObj = _data select 6;
	_setText ctrlSetStructuredText (parseText format ["
		<t>
			%1 SITREP<br /><br /><br />
			<br /><br />
			Size: %2<br /><br />
			Current Position: <br />
			LAT: %3<br />
			LON: %4<br /><br />
			Injured: %5<br /><br />
			Distance from you: %6<br /><br />
			Distance from Objective: %7<br /><br />
		</t>
	", _grp, _cnt, _lat, _lon, _cntInj, _distPL, _distObj]);
	_setText ctrlSetBackgroundColor [0,0,0,0.5];
} else {
	_displayOBJUNITS1 = uiNameSpace getVariable "COL3";
	_setText = _displayOBJUNITS1 displayCtrl 999508;
	_text = "NO GROUP DATA";
	_setText ctrlSetStructuredText (parseText format ["
		<t>
			%1
		</t>
	", _text]);
	_setText ctrlSetBackgroundColor [0,0,0,0.5];
};


if ((_display select 3 ) == 1) then {
	_displayOBJUNITS2 = uiNameSpace getVariable "COL4";
	_setText = _displayOBJUNITS2 displayCtrl 999509;
	_data = _dataArray select 3;
	_grp = _data select 0; 
	_cnt = _data select 3; 
	_leaderPos = _data select 2; 
	_lat = floor (_leaderPos select 0);
	_lon = floor (_leaderPos select 1);
	_cntInj = _data select 4;
	_distPL = _data select 5;
	_distObj = _data select 6;
	_setText ctrlSetStructuredText (parseText format ["
		<t>
			%1 SITREP<br /><br /><br />
			<br /><br />
			Size: %2<br /><br />
			Current Position: <br />
			LAT: %3<br />
			LON: %4<br /><br />
			Injured: %5<br /><br />
			Distance from you: %6<br /><br />
			Distance from Objective: %7<br /><br />
		</t>
	", _grp, _cnt, _lat, _lon, _cntInj, _distPL, _distObj]);
	_setText ctrlSetBackgroundColor [0,0,0,0.5];
} else {
	_displayOBJUNITS1 = uiNameSpace getVariable "COL4";
	_setText = _displayOBJUNITS1 displayCtrl 999509;
	_text = "NO GROUP DATA";
	_setText ctrlSetStructuredText (parseText format ["
		<t>
			%1
		</t>
	", _text]);
	_setText ctrlSetBackgroundColor [0,0,0,0.5];
};
