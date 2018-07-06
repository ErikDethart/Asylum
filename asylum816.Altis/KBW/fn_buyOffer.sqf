/*
fn_buyOffer.sqf
Kevin Webb
Last but not least, sets up your buy offer...
*/
if(lbCurSel 44004 == -1) exitWith {hint "You did not select anything"};
_data = lbData[44004,(lbCurSel 44004)];
_data = call compile format["%1",_data];
_className = _data select 0;
_type = _data select 1;
_exit = false;
_amount = 0;
if (_type == "Vehicle") exitWith {closeDialog 0; hint "The Exchange does not allow vehicle purchases and sales at this time!"};
if(_type == "Virtual") then {
	hint "Please enter the AMOUNT of this resource you wish to purchase.";
	createDialog "STS_KBW_price_diag";
	waitUntil{!isNull (findDisplay 13371)};
	ctrlSetText[2651,"Type Amount to Buy"];
	waitUntil{isNull (findDisplay 13371) || life_priced};
	if(!(life_priced)) exitWith {_exit = true};
	life_priced = false;
	_amount = ctrlText 7331;
	if(!([_amount] call life_fnc_isNumber)) exitWith {hint "You didn't enter an actual number."; closeDialog 0; _exit = true};
	_amount = parseNumber _amount;
	if(_amount <= 0) exitWith {hint "Invalid Number"; closeDialog 0; _exit = true};
	closeDialog 0;
};
if(_exit) exitWith {};
hint "Please enter the OFFER PRICE of the item you are purchasing. If this is a resource, enter the PRICE PER UNIT.";
createDialog "STS_KBW_price_diag";
waitUntil{!isNull (findDisplay 13371)};
waitUntil{isNull (findDisplay 13371) || life_priced};
if(!(life_priced)) exitWith {};
life_priced = false;
_price = ctrlText 7331;
if(!([_price] call life_fnc_isNumber)) exitWith {hint "You didn't enter an actual number."; closeDialog 0;};
_price = parseNumber _price;
if(_price > life_atmmoney) exitWith {hint "You don't seem to have that much money in your bank account."; closeDialog 0};
if(_price < 15) exitWith {hint "This price is not appropriate for the exchange"; closeDialog 0};
if(_type == "Virtual" && (_price * _amount) > life_atmmoney) exitWith {"You don't have enough money for that amount and price of your offer."; closeDialog 0};
switch(_type) do {
	case "Virtual": {["atm","take",(_price * _amount)] call life_fnc_updateMoney};
	default {["atm","take",_price] call life_fnc_updateMoney};
};
_item = _classname;
if ((typeName _item) == "ARRAY") then {_item = (_item select 0)};
[802, player, format["Created a Buy Offer(%1) for %2 units of %3 for a price of %4 per unit", _type, _amount, _item, _price]] remoteExecCall ["ASY_fnc_logIt",2];
[4,_className,_type,_amount,_price,player] remoteExecCall ["KBW_fnc_listing",2];
closeDialog 0;
systemChat "Offer successfully listed";
[] spawn { waitUntil{dialog}; closeDialog 0};
