/*
	File: fn_confirmGovPardonEnd.sqf
	Author: Alan
	
	Description:
	Call to confirm a pardon by the governor.
	
	Parameter(s):
	0 - OBJECT PLAYER
*/
private["_unit","_res","_uid"];
_unit = _this select 0;
_res = _this select 1;
_uid = getPlayerUID _unit;

if(!(_res)) exitWith {hint format["%1 has chosen not to be pardoned at this time.", [name _unit] call life_fnc_cleanName]};
[_uid] remoteExecCall ["life_fnc_wantedPardon",2];
[format["%1 has been pardoned by %2",[name _unit] call life_fnc_cleanName, [name player] call life_fnc_cleanName]] remoteExecCall ["systemChat",-2];
