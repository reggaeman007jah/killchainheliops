/*
Degroup All FNC 
Updated: 04 Nov 2023 

Purpose: Degroups all ARVN units into single unit groups, to make end-of-mission extractions easier 

Notes: 
- This is needed as some units seem to get stuck .. this is an attempt to resolve this.
*/

private _arvnUnits = allUnits select {side _x == independent};
{
	_grp = createGroup [independent, true];
	[_x] joinSilent _grp;	
} forEach _arvnUnits;