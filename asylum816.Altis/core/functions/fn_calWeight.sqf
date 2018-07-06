/*
    File: fn_calWeight.sqf
    Author: Gnashes
    
    Description:
    Calculates weight of player virtual inventory and updates life_carryWeight variable.
*/


_calcWeight = 0; 
_inv = [];
{
	_val = missionNameSpace getVariable _x;
	_var = [_x,1] call life_fnc_varHandle;
	_itemWeight = ([_var] call life_fnc_itemWeight) * _val;
	_calcWeight = _calcWeight + _itemWeight;
} foreach life_inv_items;

/*if (_calcWeight > 100) then {
[911, player, format["ITEM SCRIPT HACK - BAN! (%1)",_calcWeight]] remoteExecCall ["ASY_fnc_logIt",2];
};*/

life_carryWeight = _calcWeight;
