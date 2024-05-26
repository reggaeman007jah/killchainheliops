/*
This will deliver key messages as RSC Text - lower right area 
*/

_text = _this select 0;

disableSerialization;
700 cutRsc ["GENERAL_MESSAGE", "PLAIN"];
waitUntil {!isNull (uiNameSpace getVariable "GENERAL_MESSAGE")};
_displayOBJUNITS = uiNameSpace getVariable "GENERAL_MESSAGE";
_setText = _displayOBJUNITS displayCtrl 999502;
_setText ctrlSetStructuredText (parseText _text);
_setText ctrlSetBackgroundColor [0,0,0,0.5];


