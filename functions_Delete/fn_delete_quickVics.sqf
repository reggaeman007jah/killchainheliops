/*
This will manage the deleting of disposable vics like quads from the battlefield without breaking immersion 
run a check on each held item in RGG_quickVics - if no players nearby then delete 
*/

while {true} do {
	
	_cnt = count RGG_quickVics;

	if (_cnt > 0) then {
		{
			_pos = getPos _x;
			_dataStore = [];
			{
				_playerPos = getPos _x;  
				_dist = _pos distance _playerPos;  

				if (_dist < 1000) then {
					_dataStore pushback _x;
				};
			} forEach allPlayers;

			_players = count _dataStore;

			if (_players == 0) then {
				deleteVehicle _x;	
			}; 

		} forEach RGG_quickVics;
	};
	sleep 600;
};