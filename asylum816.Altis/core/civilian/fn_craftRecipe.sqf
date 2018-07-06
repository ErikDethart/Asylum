/*
	File: fn_craftRecipe.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Converts recipe items into another product
*/

private ["_className","_sell","_recipe"];

disableSerialization;
if (isNull (findDisplay 1800)) exitWith {};

// Establish things and verify shit
_sell = [_this,0,true,[true]] call BIS_fnc_param;
_className = (lbData[1850,(lbCurSel 1850)]);
_recipe = _className call life_fnc_recipeDetail;

/*if ((_className == "C_Hatchback_01_sport_F" && life_donator < 3) || (_className == "I_Heli_Transport_02_F" && life_donator < 4)) exitWith
{
	closeDialog 0;
	hint "Crafting the selected recipe requires a higher donor level.";
};*/
if((_classname in ["srifle_DMR_01_F","srifle_EBR_F","srifle_DMR_03_khaki_F","srifle_DMR_03_multicam_F","srifle_DMR_03_tan_F","srifle_DMR_03_woodland_F","srifle_DMR_06_olive_F","srifle_DMR_06_camo_F","arifle_SPAR_03_snd_F","arifle_SPAR_03_khk_F","arifle_AK12_F","arifle_AKM_F"]) && !(31 in life_talents)) exitWith {hint "Crafting a 7.62mm rifle requires the marksman talent."};
_canCraft = true;

_discount = switch (life_configuration select 12) do {
	case 2:{.95};
	case 3:{.90};
	case 4:{.75};
	default {1};
};

{
	_req = _x select 1;
	if !(_x select 0 == "life_money") then {
		_req = ceil (_req * _discount);
		_row = +_x;
		_row set[1, _req];
		_recipe set[_forEachIndex, _row];
	};
} forEach _recipe;

{
	_req = _x select 1;
	if ((life_turf_list select 2) select 1 == life_gang) then
	{
		_req = ceil (_req * 0.75);
		_row = +_x;
		_row set[1, _req];
		_recipe set[_forEachIndex, _row];
	};
	if ((missionNamespace getVariable (_x select 0)) < _req) then { _canCraft = false };
} forEach _recipe;
if (!_canCraft) exitWith { hint "You do not have the materials required to craft this item." };

//Check Garage for space if they want to keep a vehicle.
_garageFail = false;
if (!(_sell) && (isClass (configFile >> "CfgVehicles" >> _className))) then
{
	_type = switch (true) do {
		case (_className isKindOf "Car"):{"Car"};
		case (_className isKindOf "Ship"):{"Ship"};
		case (_className isKindOf "Air"):{"Air"};
		case (_className isKindOf "Kart"):{"Kart"};
		default {"Car"};
	};
	life_veh_count = nil;
[getPlayerUID player,playerSide,_type,player,true] remoteExecCall ["ASY_fnc_getVehicles",2];
	waitUntil { !isNil "life_veh_count" };
	_garageCap = 30;
	if (life_veh_count >= _garageCap) then {_garageFail = true};
};

if (_garageFail) exitWith { closeDialog 0; hint format["You cannot craft more vehicles of this type into your garage until you sell (or crash) existing vehicles! The current maximum is %1 vehicles per garage.", _garageCap] };

_moneyFail = false;
// Get rid of all the required items
{
	if (_x select 0 == "life_money") then { if (life_money < (_x select 1)) then { _moneyFail = true; } else { ["cash","take",(_x select 1)] call life_fnc_updateMoney; } }
	else { [false, [_x select 0, 1] call life_fnc_varHandle, _x select 1] call life_fnc_handleInv; };
	if (_moneyFail) exitWith {};
} forEach _recipe;

if (_moneyFail) exitWith { closeDialog 0; hint "You do not have enough money in your bank to produce this item." };

// Place new item for sale on market and reward current value
if (_sell) then
{
	_price = 0;
	if (isClass (configFile >> "CfgVehicles" >> _className)) then
	{
		{
			if ((_x select 8) == civilian && (_x select 1) == _className) exitWith { _price = _x select 2; };
		} forEach life_vehicleInfo;
	}
	else
	{
		{ if (_x select 0 == _className) exitWith { _price = _x select 1; } } forEach life_weapon_shop_array;
	};
	_qty = _className call life_fnc_getQuantity;
	_price = [_className,_price,_qty,false] call life_fnc_calcPrice;
	life_stock_update = [_className, 4, player];
	publicVariableServer "life_stock_update";
	["atm","add",_price] call life_fnc_updateMoney;
	hint format["You have produced the selected item for the current market value of $%1. It is now listed for sale on local markets and the funds have been deposited into your bank account.", [_price] call life_fnc_numberText];
}
// Create item for ownership
else
{
	// It's a vehicle!
	if (isClass (configFile >> "CfgMagazines" >> _className)) exitWith {player addMagazine _className; hint format ["The factory has produced a %1 with your materials. You have received the item.", getText(configFile >> "CfgMagazines" >> _className >> "displayName")];};
	if (isClass (configFile >> "CfgVehicles" >> _className)) then
	{
		_color = 0;
		if((lbSize 1804)-1 != -1) then { _color = lbValue [1804, lbCurSel 1804]; };
		["veh_sp_84","veh_sp_85","veh_sp_86","veh_sp_91","veh_sp_92","veh_sp_93"] call life_fnc_getSpawnMarker;
		_sp = getMarkerPos life_veh_sp;
		_dir = markerDir life_veh_sp;
		if(count(nearestObjects[_sp,["Car","Ship","Air"],4]) > 0) exitWith {hint "There is a vehicle on the spawn point."};
		_plate = round(random 1000000);
		_vehicle = [_className,_color,_sp,_dir,_plate,player,(87 in life_talents)] call life_fnc_createVehicle;
		if(!alive _vehicle) exitWith {};
		_vehicle setFuel 0.5;
[(getPlayerUID player),playerSide,_vehicle,_color,player,_plate,0.5,damage _vehicle,(87 in life_talents),false] remoteExecCall ["ASY_fnc_vehicleCreate",2];
		life_vehicles set [count life_vehicles, _vehicle];
		if (_vehicle isKindOf "Ship") then { [] spawn life_fnc_storeVehicleGarage };
		hint format ["The factory has produced a %1 with your materials. You have received the keys and it is now parked outside.", getText(configFile >> "CfgVehicles" >> _className >> "displayName")];
	}
	// Other item type, likely a weapon
	else
	{
		[_className,true,false,true,false] call life_fnc_handleItem;
		hint format ["The factory has produced a %1 with your materials. You have received the item.", getText(configFile >> "CfgWeapons" >> _className >> "displayName")];
	};
	life_stock_update = [_className, 3, player];
	publicVariableServer "life_stock_update";
};

closeDialog 0;