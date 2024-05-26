/*
FNC Set Stance 
Updated: 19 Oct 2023 

Purpose: Takes a unit array, and a number for stance, and a number for delay to implement 

Notes:
	Stances: 1 DOWN / 2 MIDDLE / 3 UP / 4 AUTO 

*/

params ["_unitArray", "_stance", "_delay"];

sleep _delay;
{
	_x setUnitPos _stance;
	 _rnd = selectRandom [0.5,1,1.5];
	sleep _rnd; 
} forEach _unitArray;

