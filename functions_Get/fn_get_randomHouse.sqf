// --- get random house --- // 

/*
takes: 
	a pos as an anchor, 

returns: 
	a suitable house 
*/

_anchor = _this select 0;
_ranHouse = nearestBuilding _anchor;

_ranHouse;