_dataStore = [];
{ if ((roleDescription _x) == "Viking 1:1 - Platoon Leader@Viking 1") then { _dataStore pushback _x } } forEach allPlayers;
_commPos = getPos (_dataStore select 0);
_commPos;