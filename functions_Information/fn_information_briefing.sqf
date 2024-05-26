/*
This will send short message to players in center of screen  
*/

_text = _this select 0;

disableSerialization;
800 cutRsc ["GENERAL_MESSAGE_MM", "PLAIN"];

waitUntil {!isNull (uiNameSpace getVariable "GENERAL_MESSAGE_MM")};

_displayOBJUNITS = uiNameSpace getVariable "GENERAL_MESSAGE_MM";
_setText = _displayOBJUNITS displayCtrl 999504;
_setText ctrlSetStructuredText (parseText _text);
_setText ctrlSetBackgroundColor [0,0,0,0.5];


