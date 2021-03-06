/*
	File: fn_chopShopSell.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Sells the selected vehicle off.
*/
disableSerialization;
//_myGarage = param[0,false];
private["_control","_price","_vehicle","_nearVehicles"];
_control = ((findDisplay 39400) displayCtrl 39402);
_price = _control lbValue (lbCurSel _control);
_vehicle = _control lbData (lbCurSel _control);
_vehicle = call compile format["%1", _vehicle];
_nearVehicles = nearestObjects [getMarkerPos life_chopShop,["Car","Truck","Air","Land_CargoBox_V1_F","Land_Cargo20_red_F","Ship"],25];
_vehicle = _nearVehicles select _vehicle;
if(isNull _vehicle) exitWith {};
if(time - life_last_sold < 5) exitWith {};
if ({alive _x} count (crew _vehicle) > 0) exitWith { hint "The vehicle you have attempted to chop has people inside of it."; };
if !(_vehicle getVariable ["canChop",true]) exitWith {hint "You cannot chop this vehicle as it's not registered with the DMV!"};

if (life_action_in_use) exitWith {};
hint "Selling vehicle please wait....";
life_action_in_use = true;
/*if(_myGarage) then {
[getPlayerUID player, _vehicle] remoteExecCall ["KBW_fnc_chopMyGarage",2];
	hint "The vehicle is now being delivered to your personal garage.";
} else {
[player,_vehicle,_price] remoteExecCall ["ASY_fnc_chopShopSell",2];
};*/
[player,_vehicle,_price] remoteExecCall ["ASY_fnc_chopShopSell",2];
closeDialog 0;
life_action_in_use = false;
life_last_sold = time;
