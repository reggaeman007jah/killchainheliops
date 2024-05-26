/*
Tinman Advanced 
This will merge group x into group y 
*/

params ["_group", "_groupTo"];

_units = units _group;
_units joinSilent _groupTo;
