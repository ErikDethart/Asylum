/*
	File: fn_pulloutAction.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Pulls civilians out of a car if it's stopped.
*/
private["_crew"];
_crew = crew cursorTarget;

_toPull = 0;
{
	if(!(alive _x)) then {
		_x setPos((vehicle _x) modelToWorld [-2,0,0]);
	}
	else{
		if ((_x getVariable ["restrained",false]) || (_x getVariable ["downed",false]) || playerSide == west || ((playerSide == civilian) && {cursorTarget in life_vehicles})) then
		{
			_x setVariable ["transporting",nil,true]; _x setVariable ["Escorting",nil,true];
			[player] remoteExec ["life_fnc_pulloutVeh",_x];
			_toPull = _toPull + 1;
//[37, player, format["Pulled %1 out of vehicle", name _x]] remoteExecCall ["ASY_fnc_logIt",2];
		};
	}
} foreach _crew;

if (_toPull == 0) then { hint "There is nobody in this vehicle who you're able to remove!" };
