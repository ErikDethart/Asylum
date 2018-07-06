/*
	File: fn_ticketAction.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the ticketing process.
*/
private["_unit"];
_unit = cursorTarget;
disableSerialization;
life_confirm_response = true;
if(_unit getVariable["parole",time] > time) then {
	_handle = [format["%1 is on Parole! Continue giving them a ticket anyway?", [name _unit] call life_fnc_cleanName]] spawn life_fnc_confirmMenu;
	waitUntil {scriptDone _handle};
	};
if(!life_confirm_response) exitWith {};
if(!(createDialog "life_ticket_give")) exitWith {hint "Couldn't open the ticketing interface"};
if(isNull _unit OR !isPlayer _unit) exitwith {};
ctrlSetText[2651,format["Ticketing %1",[name _unit] call life_fnc_cleanName]];
life_ticket_unit = _unit;