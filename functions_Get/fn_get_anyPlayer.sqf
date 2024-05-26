// --- returns any random player --- //

_players = [];

{
	_players pushBack _x;

} forEach allPlayers;

_rand = selectRandom _players;

_rand;