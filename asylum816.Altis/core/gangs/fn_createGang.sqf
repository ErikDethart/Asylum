/*
	File: fn_createGang.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Create Gang button pressed; do checks and fire up UI
*/

private ["_house","_uid","_owners"];

_house = cursorTarget;
if (!(_house isKindOf "House")) exitWith {};
if (life_gang != "0") exitWith {hint "You are already a member of a gang and cannot create a new one.";};
//if (player distance _house > 20) exitWith {hint "You're too far from the center of the house.";};
if (!(40 in life_talents)) exitWith {hint "You do not have the required talent to create a gang.";};
_salePrice = _house getVariable ["salePrice", 0];

_buildingID = [_house] call life_fnc_getBuildID;
if (!(_house in life_ownHouses)) exitWith {hint "You do not own this property!";};
if (_salePrice > 0) exitWith {hint "You cannot create a gang when your house is listed for sale on the market!"};

closeDialog 0;
createDialog "Life_Create_Gang_Diag";