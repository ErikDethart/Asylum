/*
	File: fn_achievementMenu.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Displays player achievements
*/

disableSerialization;
waitUntil {!isNull (findDisplay 3100)};

[] call life_fnc_p_updateMenu;

private _display = findDisplay 3100;
private _list = _display displayCtrl 3110;
private _titleMenu = _display displayCtrl 3122;

lbClear _list;
lbClear _titleMenu;
_titleMenu lbAdd "No Title";
_titleMenu lbSetData [0,"-1"];
private _titleSel = 0;
{
	_x params [
		["_sides",[civilian,west,independent],[[]]],
		["_name","",[""]],
		["_condition",{false},[{}]],
		["_description","",[""]],
		["_reward","",[""]],
		["_title","",[""]],
		["_hidden",false,[false]]
	];

	if (playerSide in _sides) then {
		if (!_hidden || {_forEachIndex in life_achievements}) then {
			_list lbAdd _name;
			_list lbSetData [(lbSize _list)-1,str (_forEachIndex)];
			if (!(_forEachIndex in life_achievements)) then
			{
				_list lbSetColor [(lbSize _list)-1, [1,0,0,0.8]];
			}
			else
			{
				if (_title != "") then
				{
					_titleMenu lbAdd _title;
					_titleMenu lbSetData [(lbSize _titleMenu)-1,str (_forEachIndex)];
					if (_title == (player getVariable ["life_title","Nope!"])) then { _titleSel = (lbSize _titleMenu)-1 };
				};
			};
		};
	};
} forEach life_achievementInfo;

_list lbSetCurSel 0;
_titleMenu lbSetCurSel _titleSel;