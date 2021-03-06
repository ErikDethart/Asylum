/*
	File: fn_debitCard.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Routines for spending money in a place which allows debit
*/

private _amount = param [0,0,[0]];
private _success = false;

if (life_corruptData) exitWith { hint "YOUR PLAYER DATA IS DAMAGED. You must log out to the lobby and rejoin. Your progress will not save until you do this. Most likely caused by a script-kiddie."; false; };

if (life_money >= _amount) then
{
	["cash","take",_amount] call life_fnc_updateMoney;
	systemChat format["You paid $%1 from cash on hand.", [_amount] call life_fnc_numberText];
	_success = true;
}
else
{
	if (life_inv_debitcard > 0) then
	{
		if (life_atmmoney < _amount) then {hint format["You do not have $%1 in your bank account for this debit transaction.", [_amount] call life_fnc_numberText]}
		else
		{
			["atm","take",_amount] call life_fnc_updateMoney;
			systemChat format["You paid $%1 from your bank account using a debit card.", [_amount] call life_fnc_numberText];
			_success = true;
		};
		if (life_wanted > 500 && (time - life_last_wanted) > 300) then
		{
			life_last_wanted = time;
			[Str(life_wanted),name player,5] remoteExecCall ["life_fnc_clientMessage",-2];
		};
	}
	else
	{
		hint format["You do not have $%1 in cash, nor do you have a debit card.", [_amount] call life_fnc_numberText]
	};
};

_success;
