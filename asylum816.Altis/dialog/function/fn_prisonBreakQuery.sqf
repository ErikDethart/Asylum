/*
	File: fn_prisonBreakQuery.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Displays UI for breaking out of prison if a prisoner after a successful break.
*/
if (!life_is_arrested || (player distance (getMarkerPos "corrections")) > 100) exitWith {};

if (life_trial_inprogress && life_requested_trial) exitWith {hint "A prison break has occurred but you cannot escape when you're waiting on a trial."};

//if(!createDialog "life_prisonbreak_dialog") exitWith {"Failed Creating Dialog";}; //Couldn't create the menu?
//disableSerialization;

[[0,1,2], "The prison has been breached. You have one minute to escape via the front lobby!"] call life_fnc_broadcast;

private _start = time;
while {time - _start < 60} do {
	if (player in list prison_combat_trigger) exitWith { life_breakout = true };
	sleep 0.5;
};