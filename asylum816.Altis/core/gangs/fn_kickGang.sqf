/*
	File: fn_kickGang.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Removes the selected member from the gang
*/

if (life_gang_rank > 1) exitWith {hint "You are not high enough in rank to kick someone from your gang";};
disableSerialization;

private _display = findDisplay 9620;
private _info = lbData[9621,lbCurSel (9621)];
private _info = call compile _info;
private _uid = _info select 0;

private _active = objNull;
{
	if(getPlayerUID _x == _uid) exitWith {_active = _x;};
} foreach allPlayers;

ctrlEnable [9622, false];
ctrlEnable [9624, false];
ctrlEnable [9625, false];
ctrlEnable [9630, false];

if (_uid == getPlayerUID player) exitWith {hint "But... it's YOUR gang. Why would you want to kick yourself?"};
hint format["Removing player from the gang..."];
if (!isNull _active) then {
	[true] remoteExecCall ["life_fnc_leaveGang",_active];
} else {
	[_uid,"0",3] remoteExecCall ["ASY_fnc_gangMember",2];
	[life_gang,-1] remoteExecCall ["asy_fnc_umc",2];
};

sleep 2;

[false] spawn life_fnc_gangManagement;