/*
TINMAN BASIC - AUTOMOVE FNC 
Updated: 06 Dec 2023
Purpose: Default group-level order to ARVN that ensures units automatically move up to Tinman's position  
Author: Reggs

Params: none 

Notes:
- This is the default movement order for ARVN 
- It enables the mission to be played without the player issuing any orders 
- ARVN units will move forward only as far as Tinman's position (sometimes slightly ahead, sometimes slightly behind))
- ARVN will not progress significantly forward unless Tinman moves forward first 
- Any ARVN within the core will not be covered by this order (as they have reached their auto-target dest)
- Essentially this tries to get any groups 'not' on the frontline 
- Groups closer to OBJ that Tinman are not covered in this order 
- Also, it should not affect groups/units close to Tinman 

Actions:
- ensure only units in redzone are managed - ignore all else 
- apply speed based on distance - those further back will sprint, those close back will walk 
- ensure does not run when in a heli 
- ensure does not work in core
- check I can only run this once!! 
- ARVN form a rough line perpendicular to the attack line if in Zones 1 or 2, in Zone 3 they will home in on the objective but still only as far as Tinman 
- ensure teleport is improved to get player to zone three is appropriate 
- align the forward ellipse marker 
*/
systemChat "AUTOMOVE ENABLED";
if (RGG_AUTOMOVE == false) then {
	
	RGG_AUTOMOVE = true;

	while { RGG_AUTOMOVE } do {

		_moveUp = []; // holds groups that will be affected by auto-move order to move up 
		// _moveAdv = []; // holds currently near groups that should move forward slightly 
		_tinPos = [] call RGGg_fnc_get_tinmanPos;
		_currObj = [] call RGGg_fnc_get_currentObj;
		
		{
			_distObjArvn = (getPos (leader _x)) distance _currObj;
			_distObjTinm = _tinPos distance _currObj;
			if ((_distObjArvn > _distObjTinm) && (((getPos (leader _x)) distance _tinPos) > 30) && (((getPos (leader _x)) distance _currObj) > 50)) then {
				if ((getPos (leader _x)) inArea "redzone") then {
					_moveUp pushBack _x;
				};
			};
		} forEach (allGroups select {side _x isEqualTo independent});

		// remove any active healers 
		if ((count _moveUp) > 0) then {
			if ((count RGG_dutyMedic) > 0) then {
				{
					if (_x == (RGG_dutyMedic select 0)) then {
						_moveUp deleteAt _forEachIndex;
						systemChat format ["removing %1 from move order as they are on medic duties", _x];
					};
				} forEach _moveUp;
			};
			// this ^^ is not good, it only manages to remove a healer if there is only one in the array, but there could be more than one, if other players are being healed!!
		};

		if ((count _moveUp) > 0) then {

			// create zone ahead and send to random spot in zone 
			_forwardPosDir = _tinPos getDir _currObj;
			_forwardPos = _tinPos getPos [35, _forwardPosDir];
			
			_moveZone = createMarkerLocal ["_moveZone", _forwardPos];
			_moveZone setMarkerSizeLocal [25,40];
			_moveZone setMarkerShapeLocal "ELLIPSE"; 
			_moveZone setMarkerAlphaLocal 0; 

			{
				systemChat format ["Automove Order: %1", _x];

				if ((groupOwner _x) != 2) then {  
					_x setGroupOwner 2;
				};

				_tinDist = (getPos (leader _x)) distance _tinPos;
				_movePos = _moveZone call BIS_fnc_randomPosTrigger;
				_x setSpeedMode "full"; // init dec 
				
				{
					_x setUnitPos "up";
					_x forcespeed (3.8 + (selectRandom [0.1, 0.2]));
					sleep (selectRandom [0.1,0.2,0.3]);
				} forEach (units _x);

				// switch (true) do {
				// 	case (_tinDist >= 100): 			{ _x setSpeedMode "full" };
				// 	case (_tinDist < 100) && (>= 30): 	{ _x setSpeedMode "normal" };
				// 	case (_tinDist < 30): 				{ _x setSpeedMode "limited" };
				// 	default 							{ systemChat "switch error - speed auto"} ;
				// };
				_x move _movePos;

				[_x, _movePos, 15, 2, 45, "stanceMiddle"] spawn RGGo_fnc_order_watchDest;

				sleep (random 2);
			} forEach _moveUp;
			deleteMarkerLocal "_moveZone";
		} else {
			// systemChat "No Groups Available";
		};

		sleep 10;
	};

} else {
	systemChat "you can't call this twice";
};

// note - maybe add a repeat call if no protectors or medics found .. it will time out after 5 eventually, but might catch newly added units?

