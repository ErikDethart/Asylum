/*
	File: fn_leaveGang.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Leave gang
*/
_kicked = [_this,0,false,[false]] call BIS_fnc_param;
if !(_kicked) then {
    _handle = [format["Are you sure you want to leave your gang, %1?",life_gang_name]] spawn life_fnc_confirmMenu;
	waitUntil {scriptDone _handle};
	};
if ((!life_confirm_response) && (!_kicked)) exitWith {};

_index = -1;
{
	if ((str(_x) find life_gang) != -1) exitWith {_index = _forEachIndex};
} forEach life_houses;

if (_index != -1) then {
	deleteMarkerLocal format["phouse_%1", life_gang];
	life_houses = life_houses - [life_houses select _index];
};

[life_gang,-1] remoteExecCall ["asy_fnc_umc",2];
life_gangexp = 0;
life_gangtalents = [];
life_gang = "0";
life_gang_name = "";
life_gang_rank = 3;
life_gang_group = objNull;
player setVariable ["gang", nil, true];
player setVariable ["gangName", nil, true];
player setVariable ["gangGroup", nil, true];

[] spawn life_fnc_sessionUpdate;

[player] joinSilent (createGroup civilian);

closeDialog 0;
hint "You are no longer a member of your former gang!";