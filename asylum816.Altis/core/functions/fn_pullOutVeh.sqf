/*
	File: fn_pullOutVeh.sqf
	Author: Bryan "Tonic" Boardwine
*/
_unit = [_this,0,ObjNull,[Objnull]] call BIS_fnc_param;

if((playerSide == west && !((player getVariable["restrained",false]) || (player getVariable["downed",false]))) || (isNull objectParent player)) exitWith {};
if(player getVariable ["downed",false]) then
{
	player setUnconscious false;
};
if(player getVariable ["restrained",false]) then
{
	detach player;
	player setVariable["Escorting",nil,true];
	player setVariable["transporting",nil,true];
};

player action ["Eject", vehicle player];
player action ["GetOut", vehicle player];
life_in_vehicle = false;

waitUntil {isNull objectParent player};

if(player getVariable ["downed",false]) then
{
	player setUnconscious true;
	player setVelocity [0,0,0];
};

titleText["You have been pulled out of the vehicle","PLAIN"];
titleFadeOut 4;