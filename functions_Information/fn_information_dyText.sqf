/*
Dynamic Text FNC 
Updated: 05 Dec 23 
Purpose: Sends given message to given target player (singular)
Author: Reggs 
Example: ["An ARVN Combat-Medic has been assigned to you", _player, 3] spawn RGGi_fnc_information_dyText;
*/

params ["_text", "_target", "_duration"];
_part1 = "<t size='0.8' color='#ffffff' font='PuristaMedium' >";
_part2 = "</t>";
[_part1 + _text + _part2,-1,-1,_duration,2] remoteExec ["bis_fnc_dynamictext", _target];	
