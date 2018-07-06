/*
    File: fn_calcVehWeight.sqf
    Author: Gnashes
    
    Description:
    Calculates weight of vehicle trunk space and updates trunk variable if incorrect
*/

params [
	["_container",objNull,[objNull]]
];

(_container getVariable ["Trunk",[[],0]]) params [["_items",[],[[]]],["_weight",-1,[0]]];
private _calcWeight = 0;

if !(_items isEqualTo []) then {
	{
	    _x params [["_item","",[""]],["_quantity",1,[0]]];
	    private _itemWeight = ([_item] call life_fnc_itemWeight) * _quantity;
	    _calcWeight = _calcWeight + _itemWeight;
	} forEach _items;

	if !(_calcWeight isEqualTo _weight) then {
	    _container setVariable["trunk",[_items,_calcWeight],true];
	};
};