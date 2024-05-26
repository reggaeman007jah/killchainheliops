/*
Server Move FNC 
Updated: 13 Oct 2023 
Purpose: Some move orders are generated from the player's nameSpace. I have split out the elements that the server should run, 
so this can be remoteExec'd in order to get the server-owned units respond to a player's orders 

[_x, _lzPos, _name] remoteExec ["RGGo_fnc_order_serverMove", 2];
*/

params ["_grp", "_dest", "_name"];

"RUNNING SERVER MOVE FNC" remoteExec ["systemChat", 0]; 

_clientID = groupOwner _grp;
format ["Owner: %1", _clientID] remoteExec ["systemChat", 0]; 

	_clientID = groupOwner _grp;
	if (_clientID != 2) then {
		_localityChanged = _grp setGroupOwner 2;
		// systemChat format ["Changing locality of %1 to Server", _x];
		format ["From Server - Changing locality of %1 to Server", _grp] remoteExec ["systemChat", 0]; 
	} else {
		// systemChat format ["Locality of %1 is already Server", _x];
		format ["From Server - Locality of %1 is already Server", _grp] remoteExec ["systemChat", 0]; 
	};

_grp move _dest;
_grp setFormation "diamond";
// systemchat format ["From Server - Group %1 moving to position: %2", _grp, _dest];
format ["From Server - Group %1 moving to position: %2", _grp, _dest] remoteExec ["systemChat", 0]; 
// systemchat format ["From Server - Destination: %1", _name];
format ["From Server - Destination: %1", _name] remoteExec ["systemChat", 0]; 


// _group = _grp select 0;

// _anchor = getPos leader _group;
// _dest = _anchor getPos [_dist, _dir];
// _group move _dest;
// _group setSpeedMode "LIMITED";
// _group setCombatMode "GREEN";
// systemchat format ["Group %1 moving %2m at heading %3", _group, _dist, _dir];