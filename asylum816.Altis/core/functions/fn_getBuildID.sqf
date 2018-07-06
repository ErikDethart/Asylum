/*
	File: fn_getBuildID.sqf
	Author: Gnashes
	
	Description:
	Returns the Object ID
*/
private _build = param[0,objNull];
private _id = "0"; 

private _manid = _build getVariable ["life_houseId", -1]; 
if (_manid > 0) exitWith { str _manid }; 

_build = str(_build); 
private _beg = ((_build find "#") + 2);
if (_beg > 1) then {
    private _len = ((_build find ":") - _beg); 
    _id = _build select [_beg,_len];
};
_id;