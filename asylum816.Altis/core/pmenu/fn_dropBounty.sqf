/*
	File: fn_dropBounty.sqf
	Author: Gnashes

	Description:
	removes the selected bounty from the player's list of bounty targets
*/
private["_data","_droppedUID"];
disableSerialization;

_data = lbData[2401,(lbCurSel 2401)];
_data = call compile format["%1", _data];
if(isNil "_data") exitWith {
		{
			_name = "UNAVAILABLE";
			_uid = _x;
			{ if (_uid == getPlayerUID _x) exitWith { _name = name _x } } forEach allPlayers;
			if (_name == "UNAVAILABLE") then {[_uid,true] spawn life_fnc_removeBounty;};
		} forEach life_bounty_uid;
};
if(typeName _data != "ARRAY") exitWith {};
if(count _data == 0) exitWith {};

_droppedUID = _data select 1;
if (_droppedUID == "") exitWith {};

if (time - (life_last_bounty select 1) < 300) exitWith { hint "You may only drop one bounty every 5 minutes!"; };
life_last_bounty set[1,time];


[_droppedUID,true] spawn life_fnc_removeBounty;
