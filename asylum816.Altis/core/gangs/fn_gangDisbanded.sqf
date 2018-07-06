/*
	File: fn_gangDisbanded.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Removes player from the gang if they belong to it
*/

params [
	["_gang","",[""]],
	["_player",ObjNull,[ObjNull]]
];

if (_gang == life_gang) then
{
	if !(player == _player) then {
		_index = -1;
		{
			if ((str(_x) find life_gang) != -1) exitWith {_index = _forEachIndex};
		} forEach life_houses;
		
		if (_index != -1) then {
			deleteMarkerLocal format["phouse_%1", life_gang];
			life_houses = life_houses - [life_houses select _index];
		};
	};
	
	life_gang = "0";
	life_gang_name = "";
	player setVariable ["gang", nil, true];
	player setVariable ["gangName", nil, true];
	player setVariable ["gangGroup", nil, true];
};