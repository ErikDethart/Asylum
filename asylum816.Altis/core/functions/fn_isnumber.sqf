/*
	File: fn_isNumber.sqf
*/
private _value = _this select 0;
private _valid = ["0","1","2","3","4","5","6","7","8","9"];
private _array = _value splitString "";

private _ret = (({!(_x in _valid)} count _array) == 0);

_ret;