/*
	File: fn_parole.sqf
	Author: John "Paratus" VanderZwet

	Description:
	Queries and begins parole
*/

_unit = [_this,0,Objnull,[Objnull]] call BIS_fnc_param;

if (player getVariable ["parole",0] > 0) exitWith {};

_start = time;
_handle = [format["<t align='center'>Go on parole? Criminal action will allow your tracking.</t>"]] spawn life_fnc_confirmMenu;
waitUntil {scriptDone _handle || time - _start > 90};
if(!life_confirm_response) exitWith {[[0,1,2], format["%1 refused parole", [profileName] call life_fnc_cleanName]] remoteExecCall ["life_fnc_broadcast",_unit]; };

[0, format["%1 accepted parole from %2!", [profileName] call life_fnc_cleanName, [name _unit] call life_fnc_cleanName]] remoteExecCall ["life_fnc_broadcast",-2];
[life_wanted,life_wanted] remoteExecCall ["life_fnc_bountyReceive",_unit];
[198, player, format["Accepted parole from %1(%2) with a bounty of $%3!", name _unit, getPlayerUID _unit, [life_wanted] call life_fnc_numberText]] remoteExecCall ["ASY_fnc_logIt",2];
[player] remoteExec ["life_fnc_removeWanted", 2];
[getPlayerUID player] remoteExecCall ["life_fnc_removeBounty",-2];
[[0,1], "You are now on parole! Parole lasts one hour and any criminal action will alert police and activate your tracking bracelet. A parole violation is an automatic maximum prison sentence. You behave!"] call life_fnc_broadcast;

sleep 4;
player setVariable ["parole", time + (60 * 60), true];
player setVariable ["paroleViolated", false, true];
[] call life_fnc_hudUpdate;
