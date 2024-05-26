// params ["_oldUnit", "_killer", "_respawn", "_respawnDelay"];

// cutText [
// 	"SEARCHING FOR AN AVAILABLE HELI - STAND BY FOR REDEPLOYMENT",
// 	"BLACK FADED",
// 	5
// ];

// addCamShake [1, 6, 100]; 

// if !(isNull objectParent player) then {
// 	systemChat "debug - player died while in a vehicle";
// 	_vic = vehicle player;
// 	if (currentPilot _vic == driver _vic) then {
// 		systemChat "The dead player was the pilot";
// 		private _fnc_getCoPilots = {
// 			private _copilotTurrets = allTurrets _this select { getNumber ([_this, _x] call BIS_fnc_turretConfig >> "isCopilot") > 0 };
// 			private _copilots = _copilotTurrets apply { _this turretUnit _x };
// 			_copilots;
// 		}; // thank you KK!
		
// 		_cp = (_vic call _fnc_getCoPilots);
// 		_coPilot = _cp select 0;
// 		_cpGrp = group _coPilot;

// 		[_vic, _coPilot] remoteExec ["RGGo_fnc_order_enableCp", 0];
// 	};
// };
