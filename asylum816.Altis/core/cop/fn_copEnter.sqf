/*
	File: fn_copEnter.sqf
	Author: Skalicon
	
	Description:
	Allows Cops to enter locked Vehicles
*/
if((playerSide != west) && {!license_civ_bounty}) exitWith {};
_position = param[3];

switch (_position) do {
	case "driver": {
		cursorTarget lock false;
		player action ["getInDriver", cursorTarget];
		cursorTarget lock true;
	};
	case "passenger": {
		cursorTarget lock false;
		player action ["getInCargo", cursorTarget];
		cursorTarget lock true;
	};
	case "commander": {
		cursorTarget lock false;
		player action ["getInCommander", cursorTarget];
		cursorTarget lock true;
	};
	case "gunner": {
		[] spawn { //because getInGunner/Turret doesn't work well for Prowlers...
			cursorTarget lock false;
			player action ["getInCargo", cursorTarget];
			sleep 0.5;
			player moveInCargo cursorTarget;
			cursorTarget lock true;
			if (isNull objectParent player) then {cursorTarget lock true;} else {vehicle player lock true;};
		};
	};
	case "exit": {
		private _veh = vehicle player;
		_veh lock false;
		player action ["getOut", _veh];
		_veh lock true;
	};
};
