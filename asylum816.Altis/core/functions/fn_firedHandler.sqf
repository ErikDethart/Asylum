/*
	File: fn_firedHandler.sqf
	Author: Chronic [MIT]

	Description:
	Handles weapon shots
*/
params [
    ["_unit",objNull,[objNull]],
    "",
    "",
    "",
    ["_ammoType","",[""]],
    "",
    ["_projectile",objNull,[objNull]]
];

// restrained people don't get to shoot
if ((_unit getVariable ["restrained",false]) || (_unit getVariable ["isCivRestrained",false]) || (_unit getVariable ["downed",false])) then {
	deleteVehicle _projectile;
};

/* BOLT ACTION GUNS
_BoltAction = (["srifle_EBR", _weapon, false] call BIS_fnc_inString) || (["srifle_DMR", _weapon, false] call BIS_fnc_inString);
if(_BoltAction) then {
	scopeName "magLoop";
	_magazines = magazinesAmmoFull _unit;
	_ammoCount = 0;
	{
		if(_x select 2 && _x select 0 == _magazine) then {
			_ammoCount = _x select 1;
			breakTo "magLoop";
		};
	} foreach _magazines;
	_unit setAmmo [_weapon, 0];
	_stopReload = (findDisplay 46) displayAddEventHandler ["KeyDown", {(_this select 1) in (actionKeys "ReloadMagazine");
		}];
	[_unit, _weapon, _ammoCount, _stopReload] spawn {
		sleep 0.5;
		(_this select 0) say3D "BoltAction";
		sleep 1.3;
		(findDisplay 46) displayRemoveEventHandler ["KeyDown",_this select 3];
		(_this select 0) setAmmo [_this select 1, _this select 2];
	};
};
*/

// Electro-magnetic pulses. Need a Stone grenade to use.
if(_ammoType isEqualTo "GrenadeHand_stone" && playerSide isEqualTo west) then {
	[_projectile] spawn life_fnc_fireEMP;
};