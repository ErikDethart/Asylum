/*
	File: fn_suicideBomb.sqf
	Author: Gnashes
	
	Description:
	Voluntarily (or involuntarily) detonates a player's suicide vest.
*/
params [
	["_type","self",[""]],
	["_source",nil,[objNull,nil]],
	["_unit",player,[objNull]]
];

if (vest player != "V_HarnessOGL_brn") exitWith {};
if (vehicle player isKindOf "Steerable_Parachute_F") exitWith {};
if !(33 in life_talents) exitWith {hint "As you are not talented enough, pressing the button did nothing!"};
if ((player getVariable ["playerSurrender",false]) && (_type == "self")) exitWith {hint "The detonator isn't up in the air bro."};
if ((player getVariable ["restrained",false]) && (_type == "self")) exitWith {hint "You can't reach the detonator to join Allah!"};
if ((vehicle player != player) && (_type == "self")) exitWith {hint "You cannot detonate your vest from within a vehicle."};
if (((getPosATL player) select 2 > 20) && (_type == "self")) exitWith {hint "You cannot detonate your vest when not on the ground."};

if(((getPosATL player) select 2 > 20) && (_type == "shot")) exitWith {
	vehicle player setDamage 1;
	[0,format["%1 was shot by %2 causing their suicide vest to explode!",name player, name _source]] remoteExecCall ["life_fnc_broadcast",-2];
	life_dead_gear set [5, ""];
};
	
removeVest player;

if((_type == "shot") && (vehicle player != player)) then {_unit = vehicle player};
_test = "Bo_Mk82" createVehicle [0,0,9999];
_test setPosATL (getPosATL _unit);
if(vehicle player == player) then {_test setVelocity [10,0,0];} else {_test setVelocity [100,0,0];}; // 100 is too much for a player; bomb flies 20M away ~Gnash
_nearVehicles = nearestObjects [_unit,["Car","Truck","Air","Ship"],10];
{ _x setDamage 1;} forEach _nearVehicles;

if(alive player) then {player setDamage 1;};
life_dead_gear set [5, ""]; // Removes the vest if the source kills unit before this is called. ~Gnash

if(_type == "self") then {
	[player,"1080"] remoteExec ["life_fnc_addWanted", 2];
	[0,format["%1 has detonated their suicide vest.",name player]] remoteExecCall ["life_fnc_broadcast",-2];
	//[46, player, format["Detonated suicide vest"]] remoteExecCall ["ASY_fnc_logIt",2];
};
if(_type == "shot") then {
	[0,format["%1 was shot by %2 causing their suicide vest to explode!",name player, name _source]] remoteExecCall ["life_fnc_broadcast",-2];
	if(group player == group _source) then {
		[_source,"1090"] remoteExec ["life_fnc_addWanted", 2];
	};
};
