/*
	File: fn_vehicleShopBuy.sqf
	Author: Skalicon & Paratus
	
	Description:
	Creates a new vehicle
*/
private["_index","_veh","_color","_price","_sp","_dir","_name","_fuel","_damage","_insured"];

_insured = [_this,0,false,[false]] call BIS_fnc_param;

if !(isNil "life_restartLock") exitWith {hint "You cannot buy this item right now. Try again later!"};

switch (typeName life_veh_sp) do
{
	case "OBJECT":
	{
		_sp = getPosATL life_veh_sp;
		_dir = getDir life_veh_sp;
	};
	default
	{
		_sp = getMarkerPos life_veh_sp;
		_dir = markerDir life_veh_sp;
	};
};

_index = lbCurSel 2302;
_veh = call compile (lbData[2302,_index]);
_veh = _veh select 0;
_color = lbValue[2304,(lbCurSel 2304)];
_baseVeh = _veh;
_modVeh = (life_vehicleInfo select ([_veh, life_vehicleInfo] call life_fnc_index)) select 11;
if (isNil "_modVeh") then { _modVeh = false };
if (_modVeh) then
{
	_colorClass = (([_veh] call life_fnc_vehicleColorCfg) select _color) select 0;
	if (!isNil "_colorClass") then { _veh = _colorClass };
};

_name = getText(configFile >> "CfgVehicles" >> _baseVeh >> "displayName");
_price = lbValue[2302,(lbCurSel 2302)];
_plate = round(random(1000000));
_uid = getPlayerUID player;

disableSerialization;

_cbAlarm = (findDisplay 2300) displayCtrl 2355;
_alarm = ctrlChecked _cbAlarm;
_alarm = (_alarm || 87 in life_talents);

_vehicleList = [life_veh_shop] call life_fnc_vehicleListCfg;
_price = (_vehicleList select _price) select 1;
_qty = _baseVeh call life_fnc_getQuantity;
if (playerSide in [west,independent]) then { _qty = -1; };
_price = [_baseVeh,_price,_qty] call life_fnc_calcPrice;
if (_alarm) then { _price = _price + 500; };

if(!([_baseVeh] call life_fnc_vehShopLicenses)) exitWith {hint "You do not have the required license!"};
if(_price < 0) exitWith {};

_apexVeh = ["O_T_LSV_02_unarmed_F","B_T_LSV_01_unarmed_F","C_Plane_Civil_01_F","C_Scooter_Transport_01_F","C_Boat_Transport_02_F","C_Offroad_02_unarmed_F"];
life_confirm_response = true;
if((_veh in _apexVeh) && (395180 in getDLCs 2)) then
{
	_handle = [format["<t align='center'>You need the Apex DLC in order to drive this vehicle. Purchase anyway?</t>"]] spawn life_fnc_confirmMenu;
	waitUntil {scriptDone _handle};
};
if(!life_confirm_response) exitWith {};
life_confirm_response = nil;

if ((life_configuration select 3) > 0) then
{
	_price = round (_price + (_price * ((life_configuration select 3) / 100)));
};
//_price = round (_price - (((life_donator * 4) / 100) * _price));
if (16 in life_talents) then { _price = _price * 0.98; };
if (_insured) then
{
	if (life_veh_sp in ["civ_air","reb_air","cop_air","med_air"]) then { _price = round (_price * 1.08); } // 5% cost for air
	else { _price = round (_price * 1.3); }; // 30% cost for others
}; 

if(count(nearestObjects[_sp,["Car","Ship","Air"],4]) > 0) exitWith {hint "There is a vehicle on the spawn point. The transaction has been cancelled and you have not been charged"};
if(_qty == 0) then { _price = _price * 1.25; };
if(!([_price] call life_fnc_debitCard)) exitWith {};
life_stock_update = [_baseVeh, -1, player];
publicVariableServer "life_stock_update";

//if (!life_approved) then { _price = _price * 1.25; };
//if(!([_price] call life_fnc_debitCard)) exitWith {};
hint "This may take a second or two.";
//sleep floor(random 3);

//Spawn vehicle
_vehicle = [_veh,_color,_sp,_dir,_plate,player,_alarm] call life_fnc_createVehicle;
if(_uid == "" OR playerSide == sideUnknown OR isNull _vehicle) exitWith {};
if(!alive _vehicle) exitWith {};

_vehicle setFuel 0.5;
_fuel = fuel _vehicle;
_damage = damage _vehicle;

[(getPlayerUID player),playerSide,_vehicle,_color,player,_plate,_fuel,_damage,_alarm,_insured] remoteExecCall ["ASY_fnc_vehicleCreate",2];

//if ((typeOf _vehicle) == "B_G_Offroad_01_armed_F" && life_veh_shop == "cop_car") then { _vehicle setVariable ["BIS_randomSeed1", 0, TRUE]; _vehicle setVariable ["digiLock", true, true]; };

life_vehicles set[count life_vehicles,_vehicle];
_hint = format["You bought a %1 for $%2",_name,[_price] call life_fnc_numberText];
//if (_insured) then { _hint = format["You bought an insured %1 for $%2",_name,[_price] call life_fnc_numberText]; };
//if (_insured) then { _hint = _hint + ". Being insured, if destroyed a replacement will be added to your garage after a few hours time. Insurance lasts only during this vehicle session." };

hint _hint;

PlaySound "purchase";

if ((_veh == "I_Plane_Fighter_03_CAS_F") && !(9 in life_achievements)) then { [9] call life_fnc_achievementGrant };
