/*
    File: fn_calcPrice.sqf
    Author: John "Paratus" VanderZwet
    
    Description:
    Returns price of an object.
*/
params [
    ["_item","",[""]],
    ["_base",0,[0]],
    ["_quantity",0,[0]],
    ["_purchase",true,[true]]
];

private _max = if (_purchase) then { 15 } else { 50 };
private _minSale = 35;

private _discount = switch (life_configuration select 12) do {
    case 1:{.95};
    case 2:{.93};
    case 3:{.85};
    case 4:{.75};
    default {1};
};

if (3 in life_achievements) then {_discount = _discount * .95};

// Ignore unlimited stuff
if (_purchase && _quantity < 0) exitWith {
    if !(_discount isEqualTo 1) then {
        _sellPrice = [_item,_base,_quantity,false] call life_fnc_calcPrice;
        _price = _base * _discount;
        _price = selectMax[_sellPrice,_price];
        (floor _price);
    } else {
        floor( _base * _discount);
    };
};
if (!_purchase && _quantity < 0) exitWith { _base * 0.7 };

private _demand = _item call life_fnc_itemDemand;

private _percent = (_quantity * _max) / _demand;

if (_percent > _max) then { _percent = _max; };
if (!_purchase && _percent < _minSale) then { _percent = _minSale; };

private _price = _base - (_base * (_percent / 100));

if (_purchase) then {
    if !(_discount isEqualTo 1) then {
    _sellPrice = [_item,_base,_quantity,false] call life_fnc_calcPrice;
    _price = _price * _discount;
    _price = selectMax[_sellPrice,_price];
    };
};

(floor _price);