/*
	File: fn_speedBomb.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Attaches a speed bomb to a vehicle.
*/
private["_unit"];
_unit = cursorTarget;

if((!(_unit isKindOf "LandVehicle")) || (_unit isKindOf "Man")) exitWith {hint "You cannot add a speed bomb to this."};
if(player distance _unit > 7) exitWith {hint "You need to be within 7 meters!"};
if !(side player == civilian) exitWith {};
if(player getVariable ["playerSurrender",false]) exitWith {hint "How do you expect to arm a bomb with your hands up there!?"};
if (_unit getVariable ["Speedbombed",false]) exitWith {hint "This vehicle already has a speedbomb on it. More would be overkill!"};
if(!([false,"speedbomb",1] call life_fnc_handleInv)) exitWith {};
closeDialog 0;

life_action_in_use = true;

player playMove "AinvPknlMstpSnonWnonDnon_medic_1";
sleep 1.5;
waitUntil {animationState player != "ainvpknlmstpsnonwnondnon_medic_1"};

life_action_in_use = false;
if(player distance _unit > 7) exitWith {titleText["The vehicle moved too far away to arm the speedbomb!","PLAIN"];[true,"speedbomb",1] call life_fnc_handleInv};

titleText["You have attached an armed speed bomb to this vehicle.","PLAIN"];
life_experience = life_experience + 25; 

[_unit] spawn
{
	_veh = _this select 0;
	_veh setVariable ["Speedbombed",true,true];
	waitUntil {(speed _veh) > 70};
	[_veh, "caralarm",10] remoteExecCall ["life_fnc_playSound",-2];
	hint "A speed bomb you planted on a vehicle has just become active!";
	{[2,"A speed bomb has been activated on this vehicle and will detonate when your speed drops below 50km/h!"] remoteExecCall ["life_fnc_broadcast",_x]; } foreach (crew _veh);
	waitUntil {(speed _veh) < 50};
	[player,"1090"] remoteExec ["life_fnc_addWanted", 2];
	_test = "Bo_Mk82" createVehicle [0,0,9999];
	_test setPosATL (getPosATL _veh);
	_test setVelocity [100,0,0];
	_nearVehicles = nearestObjects [_veh,["Car","Truck","Air","Ship"],10];
	{ _x setDamage 1;} forEach _nearVehicles;
	hint "A speed bomb you planted on a vehicle has DETONATED!";
[0,format["A speed bomb planted by %1 has detonated!", profileName]] remoteExecCall ["life_fnc_broadcast",-2];
};
