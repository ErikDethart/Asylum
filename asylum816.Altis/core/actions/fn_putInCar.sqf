/*
	File: fn_putInCar.sqf

	Description:
*/
private["_unit","_ nearest"];
_unit = cursorTarget;
_nearest = life_escort;
if(isNull _nearest) exitWith {}; //Not valid
if(!isPlayer _nearest || !alive _nearest) exitWith {systemChat "You can't put a dead body in your vehicle.  The upholstery will stink."};
if(((getPos _nearest) distance player) > 20) exitWith {};
if(!(_nearest getVariable ["restrained",false])) exitWith {systemChat "Can't put someone in a vehicle when they're not restrained."};
[false] remoteExecCall ["life_fnc_setUnconscious",_nearest];
detach _nearest;
life_escort = objNull;
_nearest setVariable["Escorting",nil,true];
_nearest setVariable["transporting",true,true];
_nearest action ["getInCargo", _unit];
sleep 1;
_countCargo = (count fullCrew [cursorTarget, "cargo", true]);
_countTurret = (count fullCrew [cursorTarget, "turret", true]);
_totalCount = _countCargo + _countTurret;
_seats = [];
for "_x" from 0 to _totalCount do {_seats pushBack _x};
{
	scopeName "positionLoop";
	if(vehicle _nearest == _nearest) then {
		_nearest action ["getInCargo", _unit, _x];
		_nearest action ["getInCommander", _unit];
		_nearest action ["getInTurret", _unit, [_x]];
	} else {
		breakOut "positionLoop";
	};
} foreach _seats;
_unit setVariable["isTransporting",true,true];
player setVariable["currentlyEscorting",nil];