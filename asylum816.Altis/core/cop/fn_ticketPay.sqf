/*
	File: fn_ticketPay.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Pays the ticket.
*/
if(isnil {life_ticket_val} OR isNil {life_ticket_cop}) exitWith {};
if(life_is_arrested) exitWith {};

life_ticket_attempted = true; // mark that the player tried to pay the ticket

_copPaidAmount = life_ticket_val; // was 0.5
if (life_adminlevel > 1) then {
	if (_copPaidAmount > life_arrest_cap) then {
		_copPaidAmount = life_arrest_cap;
	};
};

// where is the money coming from?
if(life_atmmoney < life_ticket_val) exitWith {
	hint "You don't have enough money in your bank account or on you to pay the ticket.";
[1,format["%1 couldn't pay the ticket due to not having enough money.",[name player] call life_fnc_cleanName]] remoteExecCall ["life_fnc_broadcast",life_ticket_cop];
	closeDialog 0;
};

life_ticket_paid = true;

hint format["You have paid the ticket of $%1",[life_ticket_val] call life_fnc_numberText];
["atm","take",life_ticket_val] call life_fnc_updateMoney;
[0,format["%1 paid the ticket of $%2",name player,[life_ticket_val] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",west];

[life_ticket_cop, _copPaidAmount] spawn life_fnc_copSplit;
[2,format["$%1 has been spread amongst the active police force for a ticket paid by %2",[_copPaidAmount] call life_fnc_numberText,[name player] call life_fnc_cleanName]] remoteExecCall ["life_fnc_broadcast",life_ticket_cop];

[(getPlayerUID player),life_ticket_val] remoteExecCall ["life_fnc_wantedTicket",2];

//[55, player, format["Paid the ticket of %1", life_ticket_val]] remoteExecCall ["ASY_fnc_logIt",2];
closeDialog 0;

if (life_ticket_val > 250) then
{
[(life_ticket_val * 0.0012)] remoteExecCall ["life_fnc_addExperience",life_ticket_cop];
[floor (life_ticket_val / 25)] remoteExecCall ["life_fnc_earnPrestige",life_ticket_cop];
};

player setVariable ["parole",nil,true];
player setVariable ["paroleViolated", nil, true];
