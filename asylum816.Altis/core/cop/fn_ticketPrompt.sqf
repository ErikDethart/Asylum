/*
	File: fn_ticketPrompt
	Author: Bryan "Tonic" Boardwine

	Description:
	Prompts the player that he is being ticketed.
*/
private["_cop","_val","_display","_control"];
if(!isNull (findDisplay 2600)) exitwith {}; //Already at the ticket menu, block for abuse?
_cop = _this select 0;
if(isNull _cop) exitWith {};
_val = _this select 1;

createDialog "life_ticket_pay";
disableSerialization;
waitUntil {!isnull (findDisplay 2600)};
_display = findDisplay 2600;
_control = _display displayCtrl 2601;
life_ticket_paid = false;
life_ticket_attempted = false;
life_ticket_val = _val;
life_ticket_cop = _cop;
_control ctrlSetStructuredText parseText format["<t align='center'><t size='.8px'>%1 has given you a ticket for $%2",[name _cop] call life_fnc_cleanName,[life_ticket_val] call life_fnc_numberText];

[] spawn
{
	disableSerialization;
	waitUntil {life_ticket_paid || life_ticket_attempted || (isNull (findDisplay 2600)) || life_is_arrested};
	if(life_is_arrested) exitWith {};
	if(isNull (findDisplay 2600) && !life_ticket_attempted) then
	{
[0,format["%1 refused to pay the ticket.",name player]] remoteExecCall ["life_fnc_broadcast",west];
[1,format["%1 refused to pay the ticket.",[name player] call life_fnc_cleanName]] remoteExecCall ["life_fnc_broadcast",life_ticket_cop];
	};
};
