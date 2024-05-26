class RGGe {
	tag = "RGGe";
	class functions_Effects {
		file = "functions_Effects";

		class effects_bleedOut {
			Description = "This function will kill unit's health in increments until dead";
		};
		class effects_bombBlast {
			Description = "Applies damage effects to units and vehicles in given blast zone";
		};
		class effects_camoCoef {
			Description = "Manages camo coef for players - used when playing stealth";
		};
		class effects_cargoCheck {
			Description = "Sends alert when given heli has no more seats";
		};
		class effects_delayBlast {
			Description = "Manages a delayed explosion and destroyes passed object - BROKEN";
		};
		class effects_delayDeath {
			Description = "Kills given unit after given delay expires - used for bomb blasts";
		};
		class effects_delayDelete {
			Description = "Manages a delayed deletion of an object for all clients";
		};
		class effects_eject {
			Description = "Ejects AI cargo when heli near ground";
		};
		class effects_ejectPlayer {
			Description = "Ejects Player cargo when heli near ground";
		};
		class effects_fade {
			Description = "Manages fadeouts/ins for players on mission start";
		};
		class effects_setCaptiveArea {
			Description = "applies given setCaptive effect (bool) to all units inside given area";
		};
		class effects_setCharge {
			Description = "Triggers burn-down effects for a set charge";
		};
		class effects_setChargeCamp {
			Description = "Triggers burn-down effects for a set charge";
		};
		class effects_smokeFire {
			Description = "Generates random smoke or fire on pos, limited life";
		};
		class effects_smokeProx2 {
			Description = "This function will create a smoke when a player is near - improved";
		};
	};
};

