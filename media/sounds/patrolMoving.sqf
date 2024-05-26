
if (!BESILENT) then {
	
	COMMANDSPEAKING = true;

	{playSound "thisIsCommand1"} remoteExec ["call",0];

	sleep 3;

	{playSound "patrolMoving1"} remoteExec ["call",0];

	sleep 3.2;

	{playSound "commandOut"} remoteExec ["call",0];

	sleep 3;

	COMMANDSPEAKING = false;

};