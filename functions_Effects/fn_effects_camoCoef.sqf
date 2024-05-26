/*
Camo Coef FNC 
Updated: 06 Dec 23
Purpose: To add or reduce a player's camo levels making them harder to spot in some situations 
Author: Reggs 
*/

params ["_player"];

_player addEventHandler ["AnimDone", {
	params ["_unit", "_anim"];

	switch (_anim) do {
		case "amovpercmrunsraswrfldf": { _unit setUnitTrait ["camouflageCoef", 0.8] };
		case "amovpercmevasraswrfldf": { _unit setUnitTrait ["camouflageCoef", 1] };
		case "amovpercmwlksraswrfldf": { _unit setUnitTrait ["camouflageCoef", 0.2] };
		case "amovpercmwlksraswrfldb": { _unit setUnitTrait ["camouflageCoef", 0.2] };
		case "amovpercmwlksraswrfldl": { _unit setUnitTrait ["camouflageCoef", 0.2] };
		case "amovpercmwlksraswrfldr": { _unit setUnitTrait ["camouflageCoef", 0.2] };
		case "amovpercmwlksraswrfldfl": { _unit setUnitTrait ["camouflageCoef", 0.2] };
		case "amovpercmwlksraswrfldfr": { _unit setUnitTrait ["camouflageCoef", 0.2] };
		case "amovpercmwlksraswrfldbl": { _unit setUnitTrait ["camouflageCoef", 0.2] };
		case "amovpercmwlksraswrfldbr": { _unit setUnitTrait ["camouflageCoef", 0.2] };
		default { };
	};
}];

