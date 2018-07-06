/*
	File: fn_vehicleWeight.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Base configuration for vehicle weight
*/
private["_vehicle","_weight","_used"];
_vehicle = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _vehicle) exitWith {};

_weight = -1;
_used = (_vehicle getVariable "Trunk") select 1;

switch ((typeOf _vehicle)) do
{
	case "Land_WaterBarrel_F": {_weight = 201;};
	case "Box_East_Support_F": {_weight = 700;};
	case "Box_East_WpsSpecial_F": {_weight = 1000;};
	case "Land_TentA_F": {_weight = 400;};
	case "Land_TentDome_F": {_weight = 600;};
	case "C_Van_01_box_F":{if (toLower("mpmissions\__cur_mp.altis\images\Van_01_adds_crank.jpg") in (getObjectTextures _vehicle)) then {_weight = 402};}; //Set Crank Lab Weight
};

if (_weight == -1) then {
	{
		if (typeOf _vehicle == _x select 1 || configName (inheritsFrom (configFile >> "CfgVehicles" >> typeOf _vehicle)) == _x select 1) then
		{
			_weight = _x select 3;
		};
	} foreach life_vehicleInfo;
};

if(isNil "_used") then {_used = 0};

_weight = switch (life_configuration select 12) do {
	case 1:{ceil(_weight * 1.05)};
	case 2:{ceil(_weight * 1.1)};
	case 3:{ceil(_weight * 1.15)};
	case 4:{ceil(_weight * 1.2)};
	default{_weight};
};

[_weight,_used];