/*
	File: fn_vehInvSeize.sqf
	Author: Bryan "Tonic" Boardwine & Gnashes
	
	Description:
	Moves Illegal Items, Weapons, and Magazines into a nearby police vehicle.
*/
private["_vehicle","_vehicleInfo","_value"];
_vehicle = cursorTarget;
if(isNull _vehicle) exitWith {};
if(!((_vehicle isKindOf "Air") || (_vehicle isKindOf "Ship") || (_vehicle isKindOf "LandVehicle") || (_vehicle getVariable["containerId", -1] > -1) || ((typeOf _vehicle) in ["Land_TentA_F","Land_TentDome_F"]))) exitWith {};
if (!alive _vehicle) exitWith {hint "Couldn't search the vehicle."};
if ((_vehicle getVariable["containerId", -1] > -1) && ((life_coplevel < 5) || (getPlayerUID player in ["76561197969172915"]))) exitWith {hint "You must be an LT or higher to seize house crates!"};

_sideVehicle = _vehicle getVariable["dbInfo",[""]] select 4;
_vehicleInfo = _vehicle getVariable ["Trunk",[[],0]];
_newTrunk = _vehicleInfo select 0;
_newWeight = _vehicleInfo select 1;
_weapons = WeaponCargo _vehicle;
_magazines = MagazineCargo _vehicle;
_wepItems = []; 
{ 
    for "_i" from 1 to 3 do 
    { 
        if ((_x select _i) != "") then 
        { 
            _wepItems = _wepItems + [_x select _i] 
        }; 
    }; 
     
    if ((_x select 4 select 0) != "") then 
    { 
        _wepItems = _wepItems + [_x select 4 select 0]; 
    }; 
} forEach weaponsItemsCargo _vehicle;

_bpWeps = []; 
{ 
_bpWeps = _bpWeps +  (WeaponsItemsCargo _x); 
} foreach (everyBackpack _vehicle); 
_bpItems = [];  
{  
 for "_i" from 0 to 3 do 
 { 
  if ((_x select _i) != "") then  
  {  
   _bpItems = _bpItems + [_x select _i]  
  };  
 };  
  
 if ((_x select 4 select 0) != "") then  
 {  
  _bpItems = _bpItems + [_x select 4 select 0];  
 };  
} forEach _bpWeps; 
{  
_bpItems = _bpItems +  (magazineCargo _x); 
_bpItems = _bpItems +  (itemCargo _x); 
} foreach (everyBackpack _vehicle);

_illegalClothing = ["U_Competitor","U_Rangemaster","U_B_CombatUniform_mcam_worn","U_I_CombatUniform_shortsleeve","U_C_Scientist","V_HarnessOGL_brn","V_TacVest_blk_POLICE"];
_clothes = [];
{
	if ((_x select 0) in _illegalClothing) then {
	_clothes pushBack (_x select 0);
	};
} forEach (everyContainer _vehicle);

_nearVehicle = objNull;
_near = nearestObjects[(getPos (_vehicle)),["Car","Air","Ship"],30];
{
	_sideNearVehicle = _x getVariable["dbInfo",[""]] select 4;
	if (_sideNearVehicle == "cop") exitWith {_nearVehicle = _x};
} foreach _near;

_veh_info = _nearVehicle getVariable ["Trunk",[[],0]];
_copTrunk = _veh_info select 0;
_copWeight = _veh_info select 1;

_value = 0;
{
	_var = _x select 0;
	_val = _x select 1;
	
	_index = [_var,life_illegal_items] call life_fnc_index;
	if(_index != -1) then
	{
		_value = _value + (_val * ((life_illegal_items select _index) select 1));
		_newTrunk = _newTrunk - [_x];
		_copTrunk = _copTrunk + [_x];
 		_newWeight = _newWeight - (([_x select 0] call life_fnc_itemWeight) *(_x select 1));
		_copWeight = _copWeight + (([_x select 0] call life_fnc_itemWeight) *(_x select 1));
	};
} foreach (_vehicleInfo select 0);

if (_vehicle getVariable ["drugrunning",false]) then { 
    _value = 10000;
    _vehicle setVariable ["drugrunning",false,true];
	_vehicle setVariable["illegalVehicle",true,true];
	[player, _value] spawn life_fnc_copSplit;
	[floor (_value / 10)] spawn life_fnc_earnPrestige;
[0,format["A drug plane was searched and $%1 worth of drugs / contraband has been taken into evidence.",[_value] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",-2];
	_value = 0;
    };

if((_value > 0) || (count(_weapons + _magazines + _wepItems + _bpItems + _clothes) > 0)) then
{
if (_sideVehicle == "cop") exitWith {hint "You cannot seize the trunk of a police vehicle! Take this vehicle back to an HQ to seize items into evidence!"};
if(isNull _nearVehicle) exitWith {hint "There aren't any nearby Police vehicles to seize this vehicle's illegal items into!"};
if(!alive _nearVehicle) exitWith {hint "You cannot seize items into a vehicle which has been destroyed!"};

	{
		_nearVehicle addItemCargoGlobal [_x,1];
	} forEach (_weapons + _magazines + _wepItems + _bpItems + _clothes);
	clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
	{
	clearWeaponCargoGlobal _x;
	clearMagazineCargoGlobal _x;
	clearItemCargoGlobal _x;
	} forEach everyBackpack _vehicle;

	if(_value > 0) then 
	{
		_vehicle setVariable["Trunk",[_newTrunk,_newWeight],true];
		_nearVehicle setVariable["Trunk",[_copTrunk,_copWeight],true];
[0,format["A vehicle was searched and $%1 worth of drugs / contraband were taken into police custody.",[_value] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",-2];
		if (_value >= 5000) then {
			_vehicle setVariable["illegalVehicle",true,true];
		};
	};
	titleText["The illegal items from this vehicle have been seized into the nearest police vehicle. The items can be placed into evidence from any Police HQ.","PLAIN"];
}
else
{
	hint "Nothing illegal to seize in this vehicle.";
};
