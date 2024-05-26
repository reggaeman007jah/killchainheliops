/*
Bomb Blast FNC 
Updated: 17 Dec 23 
Purpose: takes position, and radius, then inflicts a range of damage (from light to full) on units in blast radius 
Author: Reggs 
*/

params ["_pos", "_rad"];

_mrk = createMarker [(str _pos), _pos];
_mrk setMarkershape "ellipse";
_mrk setMarkerColor "colorRed";
_mrk setMarkerSize [40, 40];
_mrk setMarkerAlpha 0.8;

[_pos] remoteExec ["RGGe_fnc_effects_smokeFire", -2];

_units = allunits inAreaArray _mrk;
{
	_dist = (getPos _x) distance _pos;

	if ((_dist > 4) && (_dist < 15)) then {
		_side = side _x;
		_grp = createGroup [_side, true];
		[_x] joinSilent _grp;
		_x setDamage 0.8;
		if ((selectRandom [0,1]) == 0) then {
			removeAllWeapons _x;
		};
		_x setBehaviour "careless";
		_x setUnitPos "up";
		_x forceSpeed 1;
		_x doMove ((getPos _x) getPos [150, (random 359)]);
		[_x, (45 + (random 45))] spawn RGGe_fnc_effects_delayDeath;
	};

	if (_dist < 4) then {
		_x setDamage 1;
	};
} forEach _units;

[_pos, 5] call RGGd_fnc_Delete_AllWithinArea;

deleteMarker _mrk;
