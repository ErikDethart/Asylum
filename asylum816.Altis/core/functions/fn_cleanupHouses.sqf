/*
	File: fn_cleanupHouses.sqf
	Author: Gnashes
	
	Description:
	Cleans up player housing when player disconnects
*/
_houses = _this select 0;
_gang = _this select 1;

//if (playerSide != civilian) exitWith {};
if (count _houses < 1) exitWith {};
_members = 0; { if (_x getVariable ["gang","0"] == _gang) then { _members = _members + 1; };} forEach allPlayers;
_gHouse = false;
if (_members == 0) then {_gHouse = true};

{
	if (((str(_x) find _gang) == -1) || (_gHouse)) then {
		_house = _x;
		diag_log format["Cleaned up house: %1",[_house] call life_fnc_getBuildID];
		_numDoors = getNumber(configFile >> "CfgVehicles" >> (typeOf _house) >> "numberOfDoors");
		_house setVariable["life_locked", nil, true];
		for "_i" from 1 to _numDoors do
			{
				_house setVariable[format["bis_disabled_Door_%1", _i], nil, true];
			};
	};
} forEach _houses;