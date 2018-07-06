/*
	File: fn_cleanName.sqf
	Author: Gnashes
	
	0: Formatted Hints
	1: DB Formatting
	2: English Characters Check
	
	Description: Cleans player names of special characters for purposes of hints and other formatted texts.
*/

private ["_rawName","_type"];
_rawName = param [0,"",[""]];
_type = param [1,0,[0]];

_ret = switch (_type) do {
	case 0:{ 
		_replace = false;
		_repChars = ["<",">",'"',"&"];
		_arrayName = _rawName splitString "";
		
		{ if (_x in _repChars) exitWith {_replace = true}; } forEach _arrayName;
		
		if (_replace) then {
			_name = [];
			{ if (_x in _repChars) then {_x = "-"}; _name pushBack _x; } forEach _arrayName;
			_name joinString "";
		} else { _rawName;
		};
	};
	case 1:{ 
		_arrayName = _rawName splitString "";
		_replace = false;
		_allowedChars = "aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ0123456789[]()-= " splitString "";
		
		{ if !(_x in _allowedChars) exitWith {_replace = true}; } forEach _arrayName;
		
		if (_replace) then {
			_newname = [];
			{ if !(_x in _allowedChars) then {_x = ""}; _newname pushBack _x; } forEach _arrayName;
			_newname joinString "";
		} else {
			_rawName;
		};
	};
	case 2:{ 
		_arrayName = _rawName splitString "";
		_replace = false;
		_allowedChars = "aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ" splitString "";
		
		{ if !(_x in _allowedChars) exitWith {_replace = true}; } forEach _arrayName;
		
		if (_replace) then {
			_newname = [];
			{ if !(_x in _allowedChars) then {_x = ""}; _newname pushBack _x; } forEach _arrayName;
			_newname joinString "";
		} else {
			_rawName;
		};
	};
	default {_rawName};
};
	
_ret;