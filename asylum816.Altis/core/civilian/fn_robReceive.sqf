/*
	File: fn_robReceive.sqf
	Author: Bryan "Tonic" Boardwine
*/
private["_cash","_victim","_rnd"];
_cash = [_this,0,0,[0]] call BIS_fnc_param;
_victim = [_this,1,objNull,[objNull]] call BIS_fnc_param;
_wasPred = param[2,false,[false]];
if(_cash == 0) then {
	titleText["They didn't have any cash..","PLAIN"]
} else {
[1,format["%1 has robbed %2 for $%3",[name player] call life_fnc_cleanName,[name _victim] call life_fnc_cleanName,[_cash] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",-2];
	["cash","add",_cash] call life_fnc_updateMoney;
	titleText[format["You stole $%1",[_cash] call life_fnc_numberText],"PLAIN"];
};
if(_cash == 0 && !_wasPred) exitWith {};
_chance = 0;
if (126 in life_talents) then {
	if(getplayerUID _victim in life_bounty_uid) then {
		_chance = switch(true) do {
			case(21 in life_honortalents): {30};
			case(20 in life_honortalents): {20};
			case(19 in life_honortalents): {10};
			default { 0 };
		};
	};
};
if(45 in life_talents) then {_chance = _chance + 20};
if((random 100) > _chance) then {
	[player,"211"] remoteExec ["life_fnc_addWanted", 2];
};
