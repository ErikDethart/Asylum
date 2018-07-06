/*
	File: fn_wantedInfo.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Pulls back information about the wanted criminal.
*/
private["_display","_list","_crimes","_bounty","_mylist"];
disableSerialization;

_display = findDisplay 2400;
_list = _display displayCtrl 2402;
_data = lbData[2401,(lbCurSel 2401)];
_data = call compile format["%1", _data];
if(isNil "_data") exitWith {_list lbAdd "Failed to fetch crimes (isNil)";};
if(typeName _data != "ARRAY") exitWith {_list lbAdd "Failed to fetch crimes (not ARRAY)";};
if(count _data == 0) exitWith {_list lbAdd "Failed to fetch crimes (count 0)";};
lbClear _list;

_crimes = _data select 2;
_bounty = _data select 3;
	
{
	_x params ["_crime","_count"];
	_list lbAdd format["%1 count(s) of %2",_count,_crime];
} foreach _crimes;

ctrlSetText[2403,format["Current Bounty Price: $%1",[_bounty] call life_fnc_numberText]];