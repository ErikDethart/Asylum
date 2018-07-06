/*
		File: fn_flip.sqf
		Author: Mike "Revir" Berlin
		
		Description: Flips a vehicle
*/
private["_car","_dir"];
if(!isNil "flip_active") exitWith {};

_car = cursorTarget;
_dir = vectorUp _car;
if (!(_car isKindOf "Car" || _car isKindOf "Air")) exitWith {hint "Uhh, bro... That's not something you want to flip, trust me."};

flip_active = true;
if ((_dir select 2 < 0.8) || (_dir select 1 < 0.8)) then 
{
	hint format ["Stand clear the vehicle will unflip in 5 seconds.."];
	sleep 5;
	_car allowDamage false;
	if (count ((getPosATL _car) nearEntities [["Car","Air","Ship"],3]) > 1) exitWith {hint "Move away other vehicles before unflipping this vehicle!"};
_car remoteExecCall ["ASY_fnc_flipVehicle",2];
	sleep 3;
	_car allowDamage true;
}
else
{
	hint format ["Car is not upside down"];
};
flip_active = nil;
