/*
	File: fn_jackpot.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Won he lottery!
*/

_amount = [_this,0,0,[0]] call BIS_fnc_param;
_toBank = _amount;
_toHand = 0;
_cap = [] call life_fnc_getMoneyCap;
_mssg = "";

if (life_atmmoney + _amount > _cap) then
{
	_toBank = _cap - life_atmmoney;
	_toHand = _amount - _toBank;
	["cash","add",_toHand] call life_fnc_updateMoney;
	_mssg = format["; $%1 is still in your hands as your bank account could not hold it all", [_toHand] call life_fnc_numberText];
};
["atm","add",_toBank] call life_fnc_updateMoney;
[[0,1,2],format["Congratulations, %1! You have won the jackpot of $%2! $%3 has already been added to your bank account%4.", [name player] call life_fnc_cleanName, [_amount] call life_fnc_numberText, [_toBank] call life_fnc_numberText, _mssg]] call life_fnc_broadcast;

_headline = format["%1 has won the Lottery!", [name player] call life_fnc_cleanName];
_message = format["Lottery winnings amount to $%1", [_amount] call life_fnc_numberText];
_sender = format["The Government of %1", worldName];
[_headline,_message,_sender] remoteExec ["life_fnc_showBroadcast",-2];
