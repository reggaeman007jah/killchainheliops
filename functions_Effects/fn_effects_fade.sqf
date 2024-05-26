/*
Fade FNC 
Updated: 7 May 2024  
Purpose: Manages fadeouts/ins for players on mission start   
Author: Reggs 
*/

sleep 1.4;
openMap false; 
sleep 1.6;
[0, "BLACK", 3, 1] spawn BIS_fnc_fadeEffect; 
sleep 9;
[1, "BLACK", 5, 1] spawn BIS_fnc_fadeEffect; 

