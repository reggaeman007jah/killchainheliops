
FALLBACKREMAIN = false; // in case was running 

_selection = allGroups select {side _x isEqualTo independent};
{
	_clientID = groupOwner _x;
	if (_clientID != 2) then { 
		_localityChanged = _x setGroupOwner 2;
	};
	_x setSpeedMode "limited";
	{
		_vari = selectRandom [0.1, 0.2];
		_x forcespeed (2 + _vari);
		// _x forceWalk true;
		sleep (selectRandom [0.1,0.2,0.3]);
		
	} forEach (units _x);
	// _spe = speedMode _x;
	// systemChat format ["TEST FNC / Group %1 set to %2", _x, _spe];
} forEach _selection;