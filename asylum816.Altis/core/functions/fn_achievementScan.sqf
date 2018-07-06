/*
	File: fn_achievementScan.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Scans achievement conditions for new matches.
*/

{
	_x params [
		["_sides",[civilian,west,independent],[[]]],
		"",
		["_condition",{false},[{}]]
	];
	
	if (!(_forEachIndex in life_achievements)) then {
		if (playerSide in _sides && (call _condition)) then
		{
			[_forEachIndex] call life_fnc_achievementGrant;
		};
	} else {
		if ((playerSide in _sides) && !(_condition isEqualTo {false})) then {
			if !(call _condition) then {
				life_achievements deleteAt (life_achievements findIf {_x == _forEachIndex});
			};
		};
	};
} forEach life_achievementInfo;