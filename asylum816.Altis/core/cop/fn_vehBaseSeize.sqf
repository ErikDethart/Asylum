/*
	File: fn_vehBaseSeize.sqf
	Author: Gnashes
	
	Description:
	Searches the vehicle for illegal items, deletes them, and pays the police.
*/
private["_vehicle","_vehicleInfo","_value"];
_vehicle = cursorTarget;
if(isNull _vehicle) exitWith {};
if(!((_vehicle isKindOf "Air") OR (_vehicle isKindOf "Ship") OR (_vehicle isKindOf "LandVehicle") OR (cursorTarget getVariable["containerId", -1] > -1))) exitWith {};
if (!alive _vehicle) exitWith {hint "Couldn't search the vehicle."};

_sideVehicle = _vehicle getVariable["dbInfo",[""]] select 4;
_vehicleInfo = _vehicle getVariable ["Trunk",[[],0]];
_weapons = WeaponCargo _vehicle;
_magazines = MagazineCargo _vehicle;
_newTrunk = _vehicleInfo select 0;
_newWeight = _vehicleInfo select 1;

_value = 0;
{
	_var = _x select 0;
	_val = _x select 1;
	
	_index = [_var,life_illegal_items] call life_fnc_index;
	if(_index != -1) then
	{
		_value = _value + (_val * ((life_illegal_items select _index) select 1));
		_newTrunk = _newTrunk - [_x];
 		_newWeight = _newWeight - (([_x select 0] call life_fnc_itemWeight) *(_x select 1));

	};
} foreach (_vehicleInfo select 0);

switch (true) do
{
	case (103 in life_talents): { _value = _value * 1.3; };
	case (102 in life_talents): { _value = _value * 1.2; };
	case (101 in life_talents): { _value = _value * 1.1; };
	default { _value };
};

if((_value > 0) || (count(_weapons + _magazines) > 0)) then
{
	clearWeaponCargoGlobal _vehicle; 
	clearMagazineCargoGlobal _vehicle; 
	clearItemCargoGlobal _vehicle;

	if(_value > 0) then 
	{
[0,format["A vehicle was searched and $%1 worth of drugs / contraband were seized into evidence.",[_value] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",-2];
	[player, _value] spawn life_fnc_copSplit;
	[floor (_value / 10)] spawn life_fnc_earnPrestige;
	_vehicle setVariable["Trunk",[_newTrunk,_newWeight],true];
		if ((_value >= 5000) && (_sideVehicle != "cop")) then
		{
			_vehicle setVariable["illegalVehicle",true,true];
		};
	};
	titleText ["You have seized the weapons and items from this vehicle.","PLAIN"];
}
else
{
	hint "Nothing illegal in this vehicle.";
};
