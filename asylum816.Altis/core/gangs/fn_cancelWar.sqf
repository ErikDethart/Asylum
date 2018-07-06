/*
	File: fn_cancelWar.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Cancel an existing gang war
*/

_dialog = findDisplay 9580;
_gang = (lbData[9581,(lbCurSel 9581)]);

if (life_gang == "0") exitWith {};
if (!(_gang in life_gang_wars)) exitWith {};

hint "Ending the gang war...";
closeDialog 0;

[life_gang,_gang,false] remoteExecCall ["ASY_fnc_updateWar",2];
