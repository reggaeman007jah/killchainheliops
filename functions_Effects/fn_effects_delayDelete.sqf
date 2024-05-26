/*
Delay Delete FNC 
Updated: 08 May 2024
Purpose: Manages a delayed deletion of an object for all clients  
Author: Reggs 

Params:
	Delay to detonate eg: 10
	Object to destroy 
*/

params ["_delay", "_target"];

sleep _delay;
deleteVehicle _target;


