/*
this function takes a group and a target and sends hunter to target until hunter is dead 
if target is dead will transition to a roaming function (random moves within AO)
will only chase target if mission is live and if target is in AO 

Action November 2021 - check how this is currently used 

*/

// _hunterGroup = _this select 0;
// _targetUnit = _this select 1;
// _moveSpeed = _this select 2;
// _cycleFreq = _this select 3;
params ["_hunterGroup", "_targetUnit", "_moveSpeed", "_cycleFreq"];
systemChat format ["DEBUG HUNT FNC - receives: %1 %2 %3 %4", _hunterGroup, _targetUnit, _moveSpeed, _cycleFreq];

sleep 3;

while {KILLCHAINISLIVE} do {
	
	if (alive _targetUnit) then {
		systemChat "APC target is alive - hunter moving to target";
		_moveTo = getPos _targetUnit;
		_hunterGroup doMove _moveTo;
	} else {
		systemChat "APC target is dead - going into roaming mode";
	};

	sleep _cycleFreq;
};
