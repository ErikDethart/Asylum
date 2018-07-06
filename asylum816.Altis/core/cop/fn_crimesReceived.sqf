/*
	File: fn_crimesReceived.sqf
	Author: John "Paratus" VanderZwet

	Description:
	Got criminal history from the server.
*/

_crimes = [_this,0,[[],[]],[[]]] call BIS_fnc_param;

if (isNull (findDisplay 3900)) exitWith {};

disableSerialization;

ctrlEnable [3901, true];

_day = _crimes select 0;
_week = _crimes select 1;

diag_log format["crimes :: %1 = %2", typeName _Crimes, _crimes];

_display = findDisplay 3900;
_crimeList = _display displayCtrl 3902;

lbClear _crimeList;

_crimeList lbAdd "24 HOURS";
_crimeList lbSetColor [(lbSize _crimeList)-1, [0.7,0,0,1]];
if (count _day == 0) then { _crimeList lbAdd "No criminal history" }
else
{
	{
		_crimeList lbAdd format ["%1x %2", _x select 1, _x select 0];
	} forEach _day;
};

_crimeList lbAdd "THIS WEEK";
_crimeList lbSetColor [(lbSize _crimeList)-1, [0.7,0,0,1]];
if (count _week == 0) then { _crimeList lbAdd "No criminal history" }
else
{
	{
		_crimeList lbAdd format ["%1x %2", _x select 1, _x select 0];
	} forEach _week;
};