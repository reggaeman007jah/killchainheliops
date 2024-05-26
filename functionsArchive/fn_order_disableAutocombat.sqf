FALLBACKREMAIN = false; // in case was running 
_selection = allUnits select {side _x isEqualTo independent};
{
	_clientID = owner _x;
	if (_clientID != 2) then { 
		_localityChanged = _x setOwner 2;
	};
	_x disableAI "autocombat";
	_x disableAI "autoTarget";
	_auto = _x checkAIFeature "autocombat";
	systemChat format ["TEST FNC / Unit %1 Autocombat: %2", _x, _auto];
} forEach _selection;