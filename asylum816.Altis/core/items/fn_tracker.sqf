/*
	File: fn_tracker.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Attaches a tracking device to a vehicle.
*/
private["_unit"];
_unit = cursorTarget;

if((!(_unit isKindOf "LandVehicle")) || (_unit isKindOf "man")) exitWith {hint "You cannot add a tracking unit to this."};
if(player distance _unit > 7) exitWith {hint "You need to be within 7 meters!"};
if(_unit in life_tracked) exitWith {hint "You are already tracking this vehicle."};
if(!([false,"tracker",1] call life_fnc_handleInv)) exitWith {};
if(!(vehicle player == player)) exitWith {hint "You cannot perform this action from within a vehicle!"};
if (isWeaponDeployed player) exitWith {hint "You probably need your hands free to attach a tracker to this!"};
if (player getVariable ["playerSurrender",false]) exitWith {hint "You probably need your hands free to attach a tracker to this!"};

closeDialog 0;

life_action_in_use = true;

player playMove "AinvPknlMstpSnonWnonDnon_medic_1";
sleep 1.5;
waitUntil {animationState player != "ainvpknlmstpsnonwnondnon_medic_1"};

life_action_in_use = false;
if(player distance _unit > 7) exitWith {titleText["You are not in range!","PLAIN"];};

life_tracked set [count life_tracked, _unit];
_trackedPlayers = _unit getVariable["tracked",[]];
_trackedPlayers pushBackUnique [playerSide,getPlayerUID player];
_unit setVariable["tracked",_trackedPlayers,true];
titleText["You have attached a tracking device to this vehicle.","PLAIN"];
life_experience = life_experience + 15;