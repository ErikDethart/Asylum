/*
	File: fn_vehInvSearch.sqf
	Author: Gnashes

	Description:
	Searches vehicle and displays hint for contents.
*/
[] spawn {

_vehicle = cursorTarget;
_className = typeOf _vehicle;
_displayName = getText(configFile >> "CfgVehicles" >> _className >> "displayName");
_vehicleInfo = _vehicle getVariable ["Trunk",[[],0]];
_owner = _vehicle getVariable "vehicle_info_owners" select 0 select 1;
if (isNil "_owner") then {_owner = ""}; //Crates

hint "Searching...";
sleep 2;

if(isNull _vehicle) exitWith {};
if(!((_vehicle isKindOf "Air") || (_vehicle isKindOf "Ship") || (_vehicle isKindOf "LandVehicle") || (_vehicle getVariable["containerId", -1] > -1) || ((typeOf _vehicle) in ["Land_TentA_F","Land_TentDome_F"]))) exitWith {};
if (!alive _vehicle) exitWith {hint "Couldn't search the vehicle"};

_value = 0;
_inv = "";
{
	_index = [_x select 0,life_illegal_items] call life_fnc_index;
		if(_index != -1) then
		{
			_inv = _inv + format["%1 %2<br/>",_x select 1,[([_x select 0,0] call life_fnc_varHandle)] call life_fnc_varToStr];
			_value = _value + ((_x select 1) * ((life_illegal_items select _index) select 1));
		};
} foreach (_vehicleInfo select 0);
if (count _inv == 0) then { _inv = "No Illegal Items"; };

_class = [];
_qty = [];
_weapons = "";
_weaponsVehicle = getWeaponCargo _vehicle select 0;
{
	if (!(_x in _class)) then { _class pushBack _x; _qty pushBack 0; };
	_index = -1;
	_className = _x;
	{ if (_x == _className) then { _index = _forEachIndex }} forEach _class;
	_qty set [_index, getWeaponCargo _vehicle select 1 select _index];
} forEach _weaponsVehicle;
if (count _class == 0) then { _weapons = "No Weapons"; }
else
{
	{
		_weapons = _weapons + format["%2x %1<br/>", getText(configFile >> "CfgWeapons" >> _x >> "displayName"), _qty select _forEachIndex];
	} forEach _class;
};

_class = [];
_qty = [];
_magazines = "";
_magazinesVehicle = getMagazineCargo _vehicle select 0;
{
	if (!(_x in _class)) then { _class pushBack _x; _qty pushBack 0; };
	_index = -1;
	_className = _x;
	{ if (_x == _className) then { _index = _forEachIndex }} forEach _class;
	_qty set [_index, getMagazineCargo _vehicle select 1 select _index];
} forEach _magazinesVehicle;
if (count _class == 0) then { _magazines = "No magazines or grenades"; }
else
{
	{
		_magazines = _magazines + format["%2x %1<br/>", getText(configFile >> "CfgMagazines" >> _x >> "displayName"), _qty select _forEachIndex];
	} forEach _class;
};

_illegalClothing = ["U_Competitor","U_Rangemaster","U_B_CombatUniform_mcam_worn","U_I_CombatUniform_shortsleeve","U_C_Scientist","V_HarnessOGL_brn","V_TacVest_blk_POLICE"];
_class = [];
_qty = [];
_clothes = "";
_clothesVeh = [];
{
	if ((_x select 0) in _illegalClothing) then {
	_clothesVeh pushBack (_x select 0);
	};
} forEach (everyContainer _vehicle);
{
	if (!(_x in _class)) then { _class pushBack _x; _qty pushBack 0; };
	_index = -1;
	_className = _x;
	{ if (_x == _className) then { _index = _forEachIndex }} forEach _class;
	_qty set [_index, {_x == _className} count _clothesVeh];
} forEach _clothesVeh;
if (count _class == 0) then { _clothes = "No illegal Clothing"; }
else
{
	{
		_name = switch (true) do {
			case (_x == "V_HarnessOGL_brn"): { "Suicide Vest" };
			case (_x == "U_B_CombatUniform_mcam_worn"): { "Police Uniform (SGT+)" };
			case (_x == "U_I_CombatUniform_shortsleeve"): { "Medic Uniform" };
			case (_x == "U_Rangemaster"): { "Police Uniform" };
			default { getText(configFile >> "CfgWeapons" >> _x >> "displayName") };
		};
		_clothes = _clothes + format["%2x %1<br/>", _name, _qty select _forEachIndex];
	} forEach _class;
};

if (_vehicle getVariable ["drugrunning",false]) then {
	_displayName = "Drugrunner's Plane";
	_value = 10000;
	_inv = "Assorted Contraband";
	if(random(100) > 95) then {_inv = _inv + " (and a very large bag full of snakes)"};
    };

hint parseText format["<t color='#FF0000'><t size='2'>%5</t></t><br/>Owned by: %6<br/><br/><br/><t color='#FFD700'><t size='1.5'>Illegal Items:</t></t><br/>%1<br/><t color='#FFD700'><t size='1.5'>Weapons:</t></t><br/>%3<br/><t color='#FFD700'><t size='1.5'>Magazines:</t></t><br/>%4<br/><t color='#FFD700'><t size='1.5'>Clothing:</t></t><br/>%7<br/><br/><t color='#FF0000'><t size='1.5'>Value of Illegal Items:</t></t><br/><t size='1.5'>$%2</t>",_inv,[_value] call life_fnc_numberText,_weapons,_magazines, _displayName, _owner, _clothes];
};