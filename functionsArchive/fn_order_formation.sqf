/*
Tinman Advanced FNC 
Updated: 09 Nov 2023 

Purpose: Sets formation of given group 

*/

params ["_grp", "_form"];

systemChat format ["_grp: %1, _form: %2", _grp, _form];
_group = _grp select 0;

switch (_form) do {
	case 1 : { _group setFormation "LINE" };
	case 2 : { _group setFormation "STAG COLUMN" };
	case 3 : { _group setFormation "WEDGE" };
	case 4 : { _group setFormation "ECH LEFT" };
	case 5 : { _group setFormation "ECH RIGHT" };
	case 6 : { _group setFormation "VEE" };
	case 7 : { _group setFormation "FILE" };
	case 8 : { _group setFormation "DIAMOND" };
	default { systemChat "ERROR - formation switch" };
};
