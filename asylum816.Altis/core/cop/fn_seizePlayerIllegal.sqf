/*
	File: fn_seizePlayerillegal.sqf
	Author: Gnashes

	Description:
	Determines if a cop can seize a player/vehicle's gear, and makes it happen.
*/
params [
	["_unit",objNull,[objNull]],
	["_type","",[""]]
];

_message = switch (true) do {
	case (_unit isKindOf "Man") : { name _unit };
	case (_unit isKindOf "Car");
	case (_unit isKindOf "Ship");
	case (_unit isKindOf "Air") : { "this vehicle" };
		default { "this unit" };
};

_handle = [format ["Do you wish to seize all weapons and illegal items from %1?",_message]] spawn life_fnc_confirmMenu;
waitUntil {scriptDone _handle};

if(!life_confirm_response) exitWith {};

if(_type == "HQ") then {
	if({player distance getMarkerPos format["police_hq_%1",_x] < 50} count [1,2,3,4,5] == 0) exitWith {hint "You cannot seize items into evidence while not near a police HQ!"};

	if(_unit isKindOf "Man") then {
		[] remoteExecCall ["life_fnc_seizePlayerIllegalAction",_unit];
		titleText [format["You have seized %1's illegal items", name _unit],"PLAIN"];
	};

	if(_unit isKindOf "Car" || _unit isKindOf "Air") then {
		[player] call life_fnc_vehBaseSeize;
	};
};

if(_type == "Field") then {
	_nearVehicle = objNull;
	_near = nearestObjects[(getPos (_unit)),["Car","Air","Ship"],30];
	{
		_sideVehicle = _x getVariable["dbInfo",[""]] select 4;
		if (_sideVehicle == "cop") exitWith {_nearVehicle = _x};
	} foreach _near;

	if(isNull _nearVehicle) exitWith {hint "There aren't any nearby Police vehicles to seize this player's gear into!"};
	if(!alive _nearVehicle) exitWith {hint "You cannot store items in a vehicle which has been destroyed!"};

	if(isPlayer _unit) then {
		[_nearVehicle] remoteExecCall ["life_fnc_seizeToVehicle",_unit];
		titleText [format["You have seized %1's illegal items into the nearest vehicle. The items can be placed into evidence from any Police HQ.", name _unit],"PLAIN"];
	} else {
		titleText ["Unable to seize illegal items. Please try again.","PLAIN"];
	};
};
