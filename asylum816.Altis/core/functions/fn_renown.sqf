/*
	File: fn_renown.sqf
	Author: John "Paratus" VanderZwet && Gnashes
	
	Description:
	Convert cash into prestige!
*/

private ["_display","_val"];

if (!(4 in life_achievements)) exitWith {hint "You must have the Eminent achievement in order to purchase Renown!"};
if (life_atmmoney < 1) exitWith {};

disableSerialization;
waitUntil {!isnull (findDisplay 6710)};
_display = findDisplay 6710;

_val = parseNumber(ctrlText 6712);
_val = round(_val);
if(_val > 999999) exitWith {hint "You can't convert more than $999,999 at once!";};
if(!([str(_val)] call life_fnc_isnumber)) exitWith {hint "That isn't in an actual number format."};
if(_val < 1000) exitWith {hint "You must convert over $1,000"};
if(_val < 0) exitwith {hint "You can't convert a negative amount!"};
if (_val > life_atmmoney) exitWith {hint "You don't have that much money to convert!"};

systemChat format["You've converted %1 cash into prestige!", [_val] call life_fnc_numberText];
[260, player, format["Purchased %1 renown!", _val]] remoteExecCall ["ASY_fnc_logIt",2];
life_wealthPrestige = life_wealthPrestige + _val;
["atm","take",_val] call life_fnc_updateMoney;

closeDialog 0;
[] call life_fnc_achievementScan;
[] call life_fnc_sessionUpdate;
