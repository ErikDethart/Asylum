/*
	File: fn_jailCL.sqf
	Author: Gnashes
	
	Description:
	Starts the process of jailing a combat logger!
*/

params [["_unit",objNull,[objNull]]];

if (isNull _unit) exitWith {};
if !((typeOf _unit) isEqualTo "Land_Bodybag_01_black_F") exitWith {};

_data = _unit getVariable ["clData",[]];
if (_data isEqualTo []) exitWith {};
_data params [
	["_name","",[""]],
	["_uid","",[""]]
];

if !((_uid in life_bounty_uid) || (playerSide isEqualTo west)) exitWith {hint "You cannot arrest this body as it is not your bounty!"};

//It's the right thing, BURN IT!
[[0,1,2], format["You've arrested the Combat Logger, %1!", [_name] call life_fnc_cleanName]] call life_fnc_broadcast;
[_uid,_name,player] remoteExecCall ["ASY_fnc_jailCLSys",2];

deleteVehicle _unit;