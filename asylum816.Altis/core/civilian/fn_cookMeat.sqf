/*
	File: fn_cookMeat.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Cooks all meat in player's virtual inventory.
*/
private["_corpse","_animals","_success"];

_meats = 0;
_meats = _meats + life_inv_dog + life_inv_sheep + life_inv_goat + life_inv_chicken + life_inv_snake + life_inv_rabbit + life_inv_manflesh;
if (_meats == 0) exitWith { hint "You don't have any raw meat to be cooked!"; };

[2, format["You begin cooking %1 raw meat.", _meats]] call life_fnc_broadcast;

for "_i" from 1 to _meats do
{
[player,"AinvPknlMstpSnonWnonDnon_medic_2"] remoteExecCall ["life_fnc_animSync",-2];
	sleep 2.3;
};

if (!alive player) exitWith {};

_meatTypes = ["chicken", "dog", "sheep", "goat", "snake", "rabbit", "manflesh"];
_cookedMan = false;
{
	_num = missionNamespace getVariable ([_x,0] call life_fnc_varHandle);
	if (_num > 0) then
	{
		if (_x == "manflesh") then { _cookedMan = true; };
		[false,_x,_num] call life_fnc_handleInv;
		[true,format["%1p",_x],_num] call life_fnc_handleInv;
	};
} forEach _meatTypes;

[2, format["You've successfully cooked %1 raw meat.", _meats]] call life_fnc_broadcast;

if (_cookedMan) then
{
	hint "The scent of burning man flesh is in the air!";
	{
		if (side _x == west && player distance _x < 4000) then
		{
			_vd = (getPosASL player) vectorDiff (getPosASL _x);
			_dir = (_vd select 0) atan2 (_vd select 1);
			if (_dir < 0) then {_dir = 360 + _dir}; 
			_comp = ["north", "north east", "east", "south east", "south", "south west", "west", "north west", "north"];
			_bearing = _comp select (round (_dir / 45));
			
[[0,1,2],format["You smell burning flesh %1 meters to the %2!", round (player distance _x), _bearing]] remoteExecCall ["life_fnc_broadcast",_x];
		};
	} forEach allPlayers;
};
