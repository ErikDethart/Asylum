/*
	File: fn_seizeToVehicle.sqf
	Author: Gnashes

	Description:
	Seizes a player's illegal items and stores them into the nearest police vehicle.
*/
private ["_vehicle"];
_exempt = ["Binocular","ItemWatch","ItemCompass","ItemGPS","ItemMap","NVGoggles","FirstAidKit","ToolKit"];
_vehicle = [_this,0,Objnull,[Objnull]] call BIS_fnc_param;

if (isNull _vehicle) exitWith {};

{
	if(!(_x in _exempt)) then {
	_vehicle addItemCargoGlobal [_x,1];
	};
} forEach (primaryWeaponItems player + [primaryWeapon player] + handgunItems player + [handgunWeapon player] + uniformItems player + vestItems player + backPackitems player);

{
	if(!(_x in _exempt)) then {
		player removeWeapon _x;
	};
} foreach weapons player;
{
	if(!(_x in _exempt)) then {
		player removeItemFromUniform _x;
	};
} foreach uniformItems player;
{
	if(!(_x in _exempt)) then {
		player removeItemFromVest _x;
	};
} foreach vestItems player;
{
	if(!(_x in _exempt)) then {
		player removeItemFromBackpack _x;
	};
} foreach backpackItems player;
{player removeMagazine _x} forEach magazines player;

if (uniform player in ["U_Competitor","U_Rangemaster","U_B_CombatUniform_mcam_worn","U_I_CombatUniform_shortsleeve","U_C_Scientist"]) then {_vehicle addItemCargoGlobal [uniform player,1]; removeUniform player;};
if (vest player in ["V_HarnessOGL_brn","V_TacVest_blk_POLICE"]) then {_vehicle addItemCargoGlobal [vest player,1]; removeVest player;};
if (headgear player in ["H_CrewHelmetHeli_B", "H_Cap_police"]) then {_vehicle addItemCargoGlobal [headgear player,1]; removeHeadgear player;};
if (hmd player == "NVGoggles_OPFOR") then {player unassignItem "NVGoggles_OPFOR"; player removeItem "NVGoggles_OPFOR"; _vehicle addItemCargoGlobal ["NVGoggles_OPFOR",1];};

license_civ_gun = false;

{
	_veh_data = _vehicle getVariable ["Trunk",[[],0]];
	_inv = _veh_data select 0;
	_var = [_x select 0,0] call life_fnc_varHandle;
	_val = missionNamespace getVariable _var;
	_itemWeight = ([_var] call life_fnc_itemWeight) * _val;
		if(_val > 0) then
		{
		_inv set[count _inv,[_x select 0,_val]];
		_vehicle setVariable["Trunk",[_inv,(_veh_data select 1) + _itemWeight],true];
		[false, [_var, 1] call life_fnc_varHandle, _val] call life_fnc_handleInv;
		};
} foreach life_illegal_items;

[] call life_fnc_sessionUpdate;
titleText["Your weapons and illegal items have been seized into the nearest police vehicle.","PLAIN"];