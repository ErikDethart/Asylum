/*
fn_removeOffer.sqf
Kevin Webb
Gives us back our item we decided not to sell
Copyright © 2015 Kevin Webb, All rights reserved
Written for Asylum Entertainment ™
*/
if(lbCurSel 2802 == -1) exitWith {hint "You did not select anything"};
_id = lbValue[2802,(lbCurSel 2802)];
_dataArr = lbData[2802,(lbCurSel 2802)];
_dataArr = call compile format["%1",_dataArr];
_price = _dataArr select 1;
_buySell = _dataArr select 2; // Buy Offer - 1, Sell Offer - 0
_className = _dataArr select 3;
_type = _dataArr select 4;
_amount = _dataArr select 5;
_vehicleID = _dataArr select 6;
_isHGUN = _type == "Weapon" && {["hgun",_classname select 0] call BIS_fnc_inString} && {!(["PDW",_classname select 0] call BIS_fnc_inString)};
if(_buySell == 0 && _type == "Weapon" && ((_isHGUN && handgunWeapon player != "") || (!_isHGUN && primaryWeapon player != ""))) exitWith {hint "You will need to have the relevant weapon slot free before reclaiming your weapon"};
_item = _classname;
if ((typeName _item) == "ARRAY") then {_item = (_item select 0)};
_text = if (_buySell == 0) then {"Sell"} else {"Buy"};
[807, player, format["Revoked a %5 Offer(%1) for %2 units of %3 for a price of $%4 per unit", _type, _amount, _item, _price, _text]] remoteExecCall ["ASY_fnc_logIt",2];
[3,_id,_className,_type,player,_amount,_buySell,_vehicleID,_price] remoteExecCall ["KBW_fnc_listing",2];
if(_buySell == 0) then {
	hint "Your item/funds are being returned to you now.";
} else {
	hint "Your buy offer has been removed from the Exchange";
};

if(_buySell == 0) then {
	if (_type == "Virtual") then {
		_var = [_item,1] call life_fnc_varHandle;
		_canCarry = ["_var",_amount,life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
		if (_amount > _canCarry) then {
			_obj = createSimpleObject ["Land_Suitcase_F", (getPosASL player)];
			_obj setVariable["item",[_var,_amount],true];
			_obj remoteExecCall ["`ASY_fnc_setIdleTime",2];
			hint "You could not hold all of your returned items and they scatter to the ground around you!";
		} else {
			[true,_var,_amount] call life_fnc_handleInv;
		};
	};
};
closeDialog 0;