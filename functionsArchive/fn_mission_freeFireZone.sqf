/*
Free Fire Zone 
Updated: 15 May 2022 

This funs on server start, and watches for players near - once players are near, it will spawn opfor and move them into the player's location 
This can be used for quick training, as well as to earn additional reinforcements if needed. 

This is a VC situation. But, there are civilians in the area also, which will impact on reinforcement score if killed 

*/

// run loop to check for near players 

while { true } do {
	
	_ffz = false;
	{
		_pos = getPos _x;
		_near = _pos inArea "freeFireZone";
		if (_near) exitWith {
			_ffz = true;
		};
	} forEach allPlayers;

	if (_ffz) then {
		// At least one player is in the FFZ 
		// get random pos in area 
		_posGen = true;
		while {_posGen} do {
			_spawnPos = "freeFireZone" call BIS_fnc_randomPosTrigger;
			_dist = _pos distance _spawnPos;
			if (_dist > 100) then {
				_posGen = false;
				// spawn mini-mission at _spawnPos and create marker 
				// this could be civilian or opfor, or both - for now, just keep it simple and have an opfor team there 
				// once team is killed, create a new inv, 100-200m away in FFZ zone 
				[_posGen] spawn RGGs_fnc_spawn_ffzUnits;
				_cnt = true;
				while {_cnt} do {
					// check opfor numbers? or player numbers? this needs a massive think 
				};
			} else {
				systemChat "Debug - FFZ - rerunning BIS_fnc_randomPosTrigger";
			};
		};
		
	} else {
		// despawn anything in the zone when players are sufficiently far away 
	};


	sleep 180;
};// unfinished 
/*
ideas 
do we always have a target in the map, as an enticer, and have players trigger spawning when they are near?
can we use the river?