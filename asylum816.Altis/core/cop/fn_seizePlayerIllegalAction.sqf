/*
	File: fn_seizePlayerIllegalAction.sqf
	Author: Skalicon

	Description:
	Removes the players weapons client side
*/
if (playerSide == west) exitWith {};

private _exempt = ["Binocular", "ItemWatch", "ItemCompass", "ItemGPS", "ItemMap", "NVGoggles", "FirstAidKit", "ToolKit"];
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
if (uniform player in ["U_Competitor","U_Rangemaster","U_B_CombatUniform_mcam_worn","U_I_CombatUniform_shortsleeve","U_C_Scientist"]) then {removeUniform player;};
if (vest player in ["V_HarnessOGL_brn","V_TacVest_blk_POLICE"]) then {removeVest player;};
if (headgear player in ["H_CrewHelmetHeli_B", "H_Cap_police"]) then {removeHeadgear player;};
//if (goggles player in ["G_Aviator"]) then {removeGoggles player;};
// if player is wearing cop NVGs, remove them
if (hmd player == "NVGoggles_OPFOR") then {
	player unassignItem "NVGoggles_OPFOR";
    player removeItem "NVGoggles_OPFOR";
};

license_civ_gun = false;
{
	_x params ["_item","_value"];
	_num = missionNamespace getVariable([_item,0] call life_fnc_varHandle);
	if (_num > 0) then {[false,_item,_num] call life_fnc_handleInv};
} forEach life_illegal_items;

//[] call life_fnc_civFetchGear;
[] call life_fnc_sessionUpdate; //Should make weapon remove persistent
//[] call life_fnc_civLoadGear;
if(param[0,true]) then {titleText["Your weapons and illegal items have been seized into evidence.","PLAIN"]};