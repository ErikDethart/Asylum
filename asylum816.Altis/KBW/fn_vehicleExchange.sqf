/*
	File: fn_vehicleExchange.sqf
	Author: Kevin Webb
	
	Description:
	Sends our vehicle to the exchange table for listing
	Copyright © 2015 Kevin Webb, All rights reserved
	Written for Asylum Entertainment ™
*/
if(life_offers > 9) exitWith {hint "You may only have up to 10 sell offers at a time."};
private["_vid","_price"];
disableSerialization;
if(lbCurSel 2801 == -1) exitWith {hint "You did not select anything"};
_vid = lbValue[2801,(lbCurSel 2801)];
_vehicle = lbData[2801,(lbCurSel 2801)];
_vehicle = (call compile format["%1",_vehicle]);
//_stolen = _vehicle select 5;
//if(_stolen) exitWith {hint "What do you think you're doing trying to list a stolen vehicle? Pawn that shit elsewhere!"};
_vehicle = _vehicle select 0;
if(isNil "_vehicle") exitWith {"You did not select anything"};
closeDialog 0;
createDialog "STS_KBW_price_diag";
waitUntil{!isNull (findDisplay 13371)};
waitUntil{isNull (findDisplay 13371) || life_priced};
if(!(life_priced)) exitWith {};
life_priced = false;
_price = ctrlText 7331;
if(!([_price] call life_fnc_isNumber)) exitWith {hint "You didn't enter an actual number."; closeDialog 0;};
_price = parseNumber _price;
if(_price < 0) exitWith {hint "Invalid Number"; closeDialog 0;};
if(_price > 250000) exitWith {hint "That price isn't appropriate for the exchange"; closeDialog 0;};
[801, player, format["Listed %1 on the Exchange for %2.", _vehicle, _price]] remoteExecCall ["ASY_fnc_logIt",2];
[0,_vid,_price,_vehicle,player] remoteExecCall ["KBW_fnc_listing",2];
hint "Your vehicle has been taken from your garage and listed on the exchange.";
closeDialog 0;
