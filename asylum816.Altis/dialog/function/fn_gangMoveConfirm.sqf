/*
	File: fn_gangMoveConfirm.sqf
	Author: Gnashes
	
	Description:
	Changes the gang house!
*/
closeDialog 0;

private _gangHouse = (life_gang_newHouse select 0);
private _id = (_gangHouse splitString "_") select 1;
private _oldHouse = (getPos player nearestObject (parseNumber life_gang));

if (_oldHouse getVariable ["gangMoved",false]) exitWith {hint "You can only move your gang house once per server restart!"};
if (_id == life_gang) exitWith {hint "You cannot move your gang to the house it's already in!"};

_handle = [format["<t align='center'>This transaction will cost you <t color='#00FF00'>$150,000</t>! Would you like to continue?</t>"]] spawn life_fnc_confirmMenu;
waitUntil {scriptDone _handle};
if(!life_confirm_response) exitWith {};
if(!([150000] call life_fnc_debitCard)) exitWith {systemChat "You do not have enough money to move your gang house!"};

[life_gang,_id,player] remoteExec ["ASY_fnc_updateGangID",2];

private _newHouse = (getPos player nearestObject (parseNumber _id));
_newHouse setVariable ["gangMoved",true,true];
[[0,1,2], "You have successfully moved your ganghouse!"] spawn life_fnc_broadcast;