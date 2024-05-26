/*
Mission Announcer FNC 
Purpose: To inform players wwhat to do next 
Updated: 24 May 24 
Author: Reggs 

Note: 
Needs voice effects and marker indicators 
*/

params ["_lzRef", "_missionType", "_currentHeat"];

hint "MISSION INCOMING - STAND BY";
sleep 1;
hint "";
sleep 1;
hint "MISSION INCOMING - STAND BY";
sleep 1;
hint "";
sleep 1;
hint "MISSION INCOMING - STAND BY";
sleep 1;
hint "";
sleep 1;
hint format ["%1 REQUIRED AT LZ %2, LZ IS CURRENTLY %3", _missionType, _lzRef, _currentHeat];