if (!BESILENT) then {
	
	COMMANDSPEAKING = true;

	sleep 1;

	{playSound "opforNeutralised1"} remoteExec ["call",0];

	sleep 3;

	{playSound "commandOut"} remoteExec ["call",0];

	sleep 3;

	COMMANDSPEAKING = false;

};