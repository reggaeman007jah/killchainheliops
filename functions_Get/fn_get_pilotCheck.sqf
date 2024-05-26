/*
Get Pilot Check FNC 
Updated: 16 Nov 2023

Purpose: Checks whether there are any assigned pilots in the mission 

Notes:
- returns bool, true if yes 
- used to automate reinforcements (i.e. pilots do this if they exist, we utomate if not)

Actions:
- make sure to use this where needed, and not run this check locally, e.g. onPlayerRespawn uses this, but what else?
*/

_raptors = false;
{
	_playerRole = roleDescription _x;
	if ( 
			(_playerRole == "Raptor 1 - Squadron Leader@Raptor") or 
			(_playerRole == "Raptor 2 - Squadron 2IC@Raptor") 
		) then {
		_raptors = true;
	};
} forEach allPlayers;
_raptors;