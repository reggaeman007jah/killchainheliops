/*
shows PL status of indifor troops 
*/


disableSerialization;
600 cutRsc ["FULLSCREEN", "PLAIN"];

waitUntil {!isNull (uiNameSpace getVariable "FULLSCREEN")};

_displayOBJUNITS2 = uiNameSpace getVariable "FULLSCREEN";
_setText = _displayOBJUNITS2 displayCtrl 999505;
_setText ctrlSetStructuredText (parseText format ["
	<t>
		MISSION DATA<br /><br /><br />
		<br /><br />
		CIVILIANS KILLED BY OUR ACTIONS: %1<br /><br />
		CIVILIANS SAVED BY OUR ACTIONS: %2<br /><br />
		TOTAL INDIFOR CREATED: %3<br /><br />
		TOTAL INDIFOR KIA: %7<br /><br />
		OPFOR NEUTRALISED BY BLUFOR: %4<br /><br />
		OPFOR NEUTRALISED BY INDIFOR: %5<br /><br />
		AA DESTROYED BY BLUFOR: %6
	</t>
", RGG_civviesKilled, RGG_civviesSaved, RGG_indiforCreated, RGG_bluforKills, RGG_indiforKills, RGG_destroyedAA, RGG_indiforDeaths]);
_setText ctrlSetBackgroundColor [0,0,0,0.5];

