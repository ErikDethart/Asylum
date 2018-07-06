/*
	File: fn_wantedMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Opens the Wanted menu and connects to the APD.
*/
private["_display","_list","_name","_crimes","_bounty","_units"];
disableSerialization;

createDialog "life_wanted_menu";

_display = findDisplay 2400;
_list = _display displayctrl 2401;
lbClear _list;
_units = [];

ctrlSetText[2404,"Establishing connection..."];

if(life_coplevel < 2 && life_adminlevel < 2 && (getPlayerUID player != (life_configuration select 0))) then
{
	ctrlShow[2405,false];
};

if(((count life_bounty_contract) < 1)) then 
{
	ctrlShow[2406,false];
};

[player] remoteExecCall ["life_fnc_wantedFetch",2];
