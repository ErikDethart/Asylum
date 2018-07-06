/*
	File: fn_p_openLightSwitchBox.sqf
	Author: John "Paratus" VanderZwet Modified by: Destrah

	Description:
	Opens the police light switchbox
*/

if(!alive player || dialog) exitWith {}; //Prevent them from opening this for exploits while dead.
createDialog "lightSwitchBox";
disableSerialization;