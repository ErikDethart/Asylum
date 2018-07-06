/*
	File: fn_showRenown.sqf
	Author: John "Paratus" VanderZwet && Gnashes
	
	Description:
	Updates data shown on Renown UI
*/

disableSerialization;
waitUntil {!isnull (findDisplay 6710)};
if (life_wealthPrestige < 10000000) exitWith{closeDialog 0};

_display = findDisplay 6710;
_money = _display displayCtrl 6713;
_prestige = _display displayCtrl 6714;

_money ctrlSetStructuredText parseText format["Your current ATM balance: %1", [life_atmmoney] call life_fnc_numberText];
_prestige ctrlSetStructuredText parseText format["Your current prestige: %1", [life_wealthPrestige] call life_fnc_numberText];