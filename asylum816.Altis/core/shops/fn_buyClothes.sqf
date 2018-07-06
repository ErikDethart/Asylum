/*
	File: fn_buyClothes.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Buys the current set of clothes and closes out of the shop interface.
*/
private["_price"];
if((lbCurSel 3101) == -1) exitWith {titleText["You didn't choose the clothes you wanted to buy.","PLAIN"];};

_exit = false;
_price = 0;
{
	if(_x != -1) then
	{
		_price = _price + _x;
	};
} foreach life_clothing_purchase;

//[26, player, format["Purchased clothing for %1", _price]] remoteExecCall ["ASY_fnc_logIt",2];
if((vest player == "V_HarnessOGL_brn") && !(life_oldVest == "V_HarnessOGL_brn")) then {
	if (life_money < _price) exitWith {_exit=true; hint format["You do not have enough cash on you to pay for this.  You need $%1.", _price]};
};
if (_exit) exitWith {closeDialog 0};
if(!([_price] call life_fnc_debitCard)) exitWith {};

life_clothesPurchased = true;
closeDialog 0;

[] call life_fnc_equipGear;

if (life_clothing_store == "faces") then
{
[player, face player] remoteExecCall ["life_fnc_setFace",-2];
};
