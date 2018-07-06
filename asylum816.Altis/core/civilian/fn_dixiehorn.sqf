/*
	File: fn_dixiehorn.sqf
	Author: Bamf 
	Credit to Chronic [MIT]

	Description:
	Plays the dixiehorn sound from the given object
*/

private ["_hornLogic", "_vehicle"];

_vehicle = _this select 0;
_hornLogic = _this select 1;

// hide the object so no one can see it
hideObject _hornLogic;

// turn off damage and simulation on the object playing the siren
_hornLogic allowDamage false;
_hornLogic enableSimulation false;

// play the dixiehorn!
_hornLogic say3D ["dixiehorn",650];