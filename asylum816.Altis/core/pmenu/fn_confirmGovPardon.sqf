/*
	File: fn_confirmGovPardon.sqf
	Description: Call to confirm a pardon by the governor.
*/

params [["_governor",objNull,[objNull]]];
if (isNull _governor) exitWith {};

_handle = [format["%1 wants to pardon you, do you accept?",[name _governor] call life_fnc_cleanName]] spawn life_fnc_confirmMenu;
waitUntil {scriptDone _handle};
if(!life_confirm_response) exitWith {};

[player,life_confirm_response] remoteExec ["life_fnc_confirmGovPardonEnd",_governor];