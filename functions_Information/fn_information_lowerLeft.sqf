/*
This will deliver key messages as RSC Text - lower right area 
*/

_messageText = _this select 0;
_messageVar = _this select 1;

disableSerialization;
701 cutRsc ["GENERAL_MESSAGE_LL", "PLAIN"];
waitUntil {!isNull (uiNameSpace getVariable "GENERAL_MESSAGE_LL")};
_displayOBJUNITS = uiNameSpace getVariable "GENERAL_MESSAGE_LL";
_setText = _displayOBJUNITS displayCtrl 999503;
_setText ctrlSetStructuredText (parseText format [_messageText, _messageVar]);
_setText ctrlSetBackgroundColor [0,0,0,0];
