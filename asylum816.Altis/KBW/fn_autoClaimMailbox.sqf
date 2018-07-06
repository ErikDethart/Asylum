/*
	File: fn_autoClaimMailbox.sqf
	Author: Gnashes
	
	Description:
	Cycles through the player's Exchange Mailbox after initialization and automatically claims cash.
*/
//if (playerSide != civilian) exitWith {};
waitUntil {life_session_completed};
player remoteExecCall ["KBW_fnc_queryMail",2];
waitUntil {!isNil "life_mailbox"};
if(count life_mailbox == 0) exitWith {life_mailbox = nil};
_nonCashItems = [];
_cashItems = [];

{
	if ((_x select 0) == "cash") then {
		_cashItems pushBack _x;
	} else {
		_nonCashItems pushBack _x;
	};
} forEach life_mailbox;

if(count _cashItems == 0) exitWith {life_mailbox = nil};
[_nonCashItems,getPlayerUID player] remoteExecCall ["KBW_fnc_updateMailbox",2];
life_mailbox = nil;
{
	["atm","add",_x select 1] call life_fnc_updateMoney;
[803, player, format["Auto-claimed %1 cash from their Exchange mailbox (ID #%2)", [_x select 1] call life_fnc_numberText, _x select 2]] remoteExecCall ["ASY_fnc_logIt",2];
	systemChat format["$%1 from your Exchange Mailbox was just deposited into your bank account!",[_x select 1] call life_fnc_numberText];
	hint format["$%1 from your Exchange Mailbox was just deposited into your bank account!",[_x select 1] call life_fnc_numberText];
	sleep 0.2;
} forEach _cashItems;

if (playerSide != civilian) exitWith {};
if(count _nonCashItems > 0) then {
	systemChat "You have items waiting for you in your AE mail! Go to the Governor's Office in Pyrgos to claim them!";
	hint "You have items waiting for you in your AE mail! Go to the Governor's Office in Pyrgos to claim them!";
};
