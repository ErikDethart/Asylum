/*
	File: fn_placedObject.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Places an object in the world.
*/

private ["_index"];

if(isNull life_placing) exitWith {};

_index = [typeOf life_placing,life_placeable] call life_fnc_index;
if (_index < 0) exitWith {};

if(!([false,(life_placeable select _index) select 0,1] call life_fnc_handleInv)) exitWith {deleteVehicle life_placing;life_placing = objNull;};
if (playerSide != west && player distance capture_1 > 300 && player distance capture_2 > 300 && player distance capture_3 > 300 && player distance capture_4 > 300) exitWith {hint "You can only place this object within 300m of a capture area (cartel)."; deleteVehicle life_placing; life_placing = objNull;}; //Prevent people from starting at cartel and driving elsewhere.

detach life_placing;
life_placing setPos [(getPos life_placing select 0),(getPos life_placing select 1),0];
//life_placing enableSimulationGlobal false;
life_placing setVariable ["owner", player, true];
life_placing removeAllEventHandlers "handleDamage"; // Apparently; this keeps damage to the object from killing the person who placed it? ~Gnash

if !((life_placeable select _index) select 5) then { life_placing allowDamage false; };

life_placing = objNull;