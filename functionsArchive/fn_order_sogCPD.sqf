/*
SOG CPD FNC 
Updated: 30 Nov 2023
Purpose: keeps any assigned SOG units always near your location 
Author: Reggs 

Params:
* _player / the player the SOG team is assigned to 
* _grp / the SOG group name 

Action:
- needs more thought on how to despawn this - what if player is in heli for example?
- what if two or three groups get added over the course of the mission?
- can a player keep adding units like this?
*/

params ["_player", "_grp"];

_chk = true;
while {_chk} do {

	if (isNull _player) exitWith {
		_chk = false;
		_data = units _grp;
		// to test this I need a close prox value, 50m, to enable a second player to monitor 
		// I also need a 10-sec check, should be longer when knows works 
		[_data, (getPos (leader _grp)), 50, 10] spawn RGGd_fnc_delete_whenNoPlayers;
	};

	if ((getPos _player) inArea "redzone") then {
		if ((count (units _grp)) > 0) then {
					
			_pos1 = getPos _player;
			_dir1 = getDirVisual _player;
			sleep 3;
			_pos2 = getPos _player;
			_dir2 = getDirVisual _player;
			_distMoved = _pos1 distance _pos2; // establish if moving

			if (_distMoved > 3) then {
				if (
					(_dir2 == _dir1) or 
					((_dir2 - _dir1) < 10) or 
					((_dir2 - _dir1) > 10)
				) then {
					_moveDir = _pos1 getDir _pos2;
					{
						_x setUnitPos "up";
						sleep .1;
						_x setUnitPos "auto";
					} forEach (units _grp);
					_goTo = _pos2 getPos [20, _moveDir];
					_grp move _goTo;
				} else {
					// systemChat "No clear direction - no action taken";
					// surround and take a knee - TO DO 
					_endPoint1 = _plr getPos [(selectRandom [15, 20, 25]), (random 359)];
					_x doMove _endPoint1;
				};
			} else {
				_dir = [] call RGGg_fnc_get_currentObj;
				{
					_x setUnitPos "middle";							
					_x doWatch _dir;
				} forEach (units _grp);
			};

		} else {
			_chk = false; // SOG team is KIA 
			["Your assigned S.O.G. Fire Team is KIA", _player, 3] spawn RGGi_fnc_information_dyText;
		};
	} else {
		_chk = false; // player is out of the redzone 
		// ACTION - send group to nearPlayer checker FNC and delete if noone is near 
		systemChat "player is not in redzone";
		_data = units _grp;
		[_data, (getPos (leader _grp)), 500, 10] spawn RGGd_fnc_delete_whenNoPlayers;
	};
	sleep 2;
};
