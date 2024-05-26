/*
This will return one random player deemed to be on the ground 
*/

// _playersOnGround = [];
// {
// 	_pos = getPos _x;
// 	_alt = _pos select 2;
// 	if (_alt < 2) then {
// 		_playersOnGround pushBack _x;
// 	};
// } forEach allPlayers;

// // systemChat format ["DEBUG / RAN PLAYER GROUND - returning all players on ground on ground: %1", _playersOnGround];
// _rndPlayerOnGround = selectRandom _playersOnGround;
// _rndPlayerOnGround;

// new code below, thanks to @Ripppe 
_playersOnGround = [];
{
    _pos = getPos _x;
    _alt = _pos select 2;
    if (_alt < 2) then {
        _playersOnGround pushBack _x;
    };
} forEach allPlayers;

_cnt = count _playersOnGround;

if (_cnt == 0) then {
    _playersOnGround pushBack objNull;
};

_rndPlayerOnGround = selectRandom _playersOnGround;

_rndPlayerOnGround;













// _cnt = count _rndPlayerOnGround;


// if (_playersOnGround == null) then {
// 	systemChat format ["DEBUG / RAN PLAYER GROUND - returning null: %1", _playersOnGround];
// };

// if (_cnt == 0) then {
// 	systemChat "DEBUG / RAN PLAYER GROUND - no players found, returning zero";
// 	_rndPlayerOnGround = 0;
// 	systemChat format ["DEBUG / RAN PLAYER GROUND - no players found, returning array: %1", _rndPlayerOnGround];
// } else {
	// systemChat "DEBUG / RAN PLAYER GROUND - at least one player found, returning array";
	// _rndPlayerOnGround = selectRandom _playersOnGround;
// 	systemChat format ["DEBUG / RAN PLAYER GROUND - at least one player found, returning array: %1", _rndPlayerOnGround];
// };

// _rndPlayerOnGround;
