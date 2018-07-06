/*
	File: fn_speedCamera.sqf
	Author: Alan
	
	Description:
	Charges driver for speeding!
*/
params [
	["_speed",0,[0]],
	["_limit",0,[0]],
	"_loc"
];

if (_speed < (_limit + 1)) exitWith {};
if (isNull objectParent player) exitWith {};
if (driver (vehicle player) != player) exitWith {};
if !((vehicle player) isKindOf "Car") exitWith {};

private _ticket = "";

playSound "camera";
"colorCorrections" ppEffectEnable true;
//"colorCorrections" ppEffectForceInNVG true;
"colorCorrections" ppEffectAdjust [1, 15, 0, [0.5, 0.5, 0.5, 0], [0.0, 0.5, 0.0, 1],[0.3, 0.3, 0.3, 0.05]];    
"colorCorrections" ppEffectCommit 0;  
sleep 0.01;   
"colorCorrections" ppEffectAdjust [1, 1, 0, [1, 1, 1, 0.0], [1, 1, 1, 1],  [1, 1, 1, 1]];    
"colorCorrections" ppEffectCommit 0.05;   
sleep 0.05;   
"colorCorrections" ppEffectEnable false;
sleep 0.1;
"colorCorrections" ppEffectEnable true;
//"colorCorrections" ppEffectForceInNVG true;
"colorCorrections" ppEffectAdjust [1, 15, 0, [0.5, 0.5, 0.5, 0], [0.0, 0.5, 0.0, 1],[0.3, 0.3, 0.3, 0.05]];    
"colorCorrections" ppEffectCommit 0;  
sleep 0.01;   
"colorCorrections" ppEffectAdjust [1, 1, 0, [1, 1, 1, 0.0], [1, 1, 1, 1],  [1, 1, 1, 1]];    
"colorCorrections" ppEffectCommit 0.05;   
sleep 0.05;   
"colorCorrections" ppEffectEnable false;
/* - TO BE RE-ENABLED ONCE WE GET THE SERVER MEMORY ISSUES RESOLVED
if (!license_civ_driver) then 
{
	[player,"dwl"] remoteExec ["life_fnc_addWanted", 2];
	_ticket = format ["<t align='center'><t size='2'>Speeding Ticket<br/><br/><t size='1.5'>Current Speed: <br/>%1 km/h<br/>Speed Limit: <br/>%2 km/h<br/>Charge Added: Driving without a license<br/><br/><t size='1'>You have been photographed by a speed camera and are fined for speeding. You have received an additional fine for driving without a license.",round(_speed), _limit];
}
else
{
	_ticket = format ["<t align='center'><t size='2'>Speeding Ticket<br/><br/><t size='1.5'>Current Speed: <br/>%1 km/h<br/>Speed Limit: <br/>%2 km/h<br/>Charge Added: Speeding<br/><br/><t size='1'>You have been photographed by a speed camera and are fined for speeding.",round(_speed), _limit];
};

[player,"spd"] remoteExec ["life_fnc_addWanted", 2];
*/

_ticket = format ["<t align='center'><t size='2'>Speeding Ticket<br/><br/><t size='1.5'>Current Speed: <br/>%1 km/h<br/>Speed Limit: <br/>%2 km/h<br/><t size='1'>You have been photographed by a speed camera and may be fined for speeding. Police have been notified of this crime.",round(_speed), _limit];

hint parseText _ticket;

private _dir = call {
	if (getDir player >= 338) exitWith {"travelling North"};
	if (getDir player <= 23) exitWith {"travelling North"};
	if (getDir player <= 68) exitWith {"travelling North East"};
	if (getDir player <= 113) exitWith {"travelling East"};
	if (getDir player <= 158) exitWith {"travelling South East"};
	if (getDir player <= 203) exitWith {"travelling South"};
	if (getDir player <= 248) exitWith {"travelling South West"};
	if (getDir player <= 293) exitWith {"travelling West"};
	if (getDir player <= 338) exitWith {"travelling North West"};
	default {""};
};
private _displayName = getText(configFile >> "CfgVehicles" >> (typeOf vehicle player) >> "displayName");

_n = "";
_fir = _displayName select [0,1];
if (({_x == _fir} count ["a","e","i","o","u"]) > 0) then {_n = "n"};

[[0,1],format["%1 was seen speeding (%3 kph) in a%6 %5 near %2 %4",[name player] call life_fnc_cleanName,triggerText _loc, ceil(_speed), _dir, _displayName, _n]] remoteExecCall ["life_fnc_broadcast",west];
