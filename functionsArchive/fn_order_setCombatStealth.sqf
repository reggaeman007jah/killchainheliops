FALLBACKREMAIN = false; // in case was running 

_selection = allGroups select {side _x isEqualTo independent};
{
	_clientID = groupOwner _x;
	if (_clientID != 2) then { 
		_localityChanged = _x setGroupOwner 2;
	};
	_x setBehaviourStrong  "stealth";
	// _beh = combatBehaviour _x;
	// systemChat format ["TEST FNC / Group %1 set to %2", _x, _beh];
} forEach _selection;