class RGGd {
	tag = "RGGd";
	class functions_Delete {
		file = "functions_Delete";

		class delete_allDeadSafely {
			Description = "Deletes all dead based on specific zones";
		};
		class delete_AllWithinArea {
			Description = "This function will delete all within an area";
		};
		class delete_ambi {
			Description = "This function will delete ambient indifor units in main base";
		};
		class delete_campItems {
			Description = "This function will delete camp items when no players are nearby";
		};
		class delete_marker {
			Description = "This function will delete given marker after given time - used when marker created was Called via unscheduled env";
		};
		class delete_nearestMarker {
			Description = "Deletes marker nearest to given position ";
		};
		class delete_markersJIP {
			Description = "This function will delete relevant markers for JIP players";
		};
		class delete_processInjured {
			Description = "This function will delete rescued civilian objects and convert to points";
		};
		class delete_quickVics {
			Description = "This function will delete vics when no players are nearby";
		};
		class delete_whenNoPlayers {
			Description = "This function will delete passed objects when players are not near - based on given pos";
		};
		class delete_whenNoPlayersMulti {
			Description = "This function will delete passed objects when players are not near - based on no fixed point";
		};
	};
};

