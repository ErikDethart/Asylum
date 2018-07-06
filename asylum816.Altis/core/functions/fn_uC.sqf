/*
	File: fn_uC.sqf
	Author: Skalicon / Paratus
	
	Description:
	Updates the players Inventory and ATM cash.
*/
[911, player, format["PLAYER ATTEMPTED MONEY HACK! Ban! - %1", life_battleye_guid]] remoteExecCall ["ASY_fnc_logIt",2];
