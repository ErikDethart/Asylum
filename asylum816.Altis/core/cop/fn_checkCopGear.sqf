/*
	File: fn_checkCopGear.sqf
	Author: Skalicon
	
	Description:
	Check and removed non whitelisted gear
*/

private["_gear","_whitelist","_recruit","_officer","_sergeant","_lieutenant","_captain","_depchief","_chief","_gear_x","_areEqual"];

if (life_coprole in ["all","detective"]) exitWith {};
if (life_adminlevel > 1) exitWith {};
_gear = cop_gear select 0;
if(isNil "_gear") exitWith {[] call life_fnc_copDefault;};
if(count _gear == 0) exitWith {[] call life_fnc_copDefault;};

//Establish the basic list of allowed gear
_cadet = [
	'U_Rangemaster',
	'H_Cap_police',
	'B_Parachute',
	'G_Shades_Black',
	'G_Shades_Blue',
	'G_Sport_Blackred',
	'G_Sport_Checkered',
	'G_Sport_Blackyellow',
	'G_Sport_BlackWhite',
	'G_Aviator',
	'30Rnd_9x21_Mag_SMG_02_Tracer_Yellow',
	'U_B_GEN_Commander_F',
	'U_B_GEN_Soldier_F',
	'H_MilCap_gen_F',
	'SMG_05_F',
//	'arifle_SPAR_01_blk_F',
	'G_Squares',
	'G_Combat',
	'G_Tactical_Black',
	'G_Tactical_Clear',
	'ItemMap',
	'ItemCompass',
	'ItemWatch',
	'ItemRadio',
	'Binocular',
	'ItemGPS',
	'ToolKit',
	'FirstAidKit',
	'NVGoggles_OPFOR',
	'O_NVGoggles_urb_F',
	'optic_Holosight',
	'optic_Holosight_smg',
	'optic_Holosight_blk_F',
	'hgun_P07_F',
	'muzzle_snds_L',
	'acc_flashlight',
	'16Rnd_9x21_Mag',
	'SmokeShell',
	'SmokeShellRed',
	'SmokeShellGreen',
	'SmokeShellYellow',
	'SmokeShellPurple',
	'SmokeShellBlue',
	'SmokeShellOrange',
	'Chemlight_green',
	'Chemlight_red',
	'Chemlight_yellow',
	'Chemlight_blue',
	'H_Beret_blk',
	'H_Beret_02',
	'H_Beret_Colonel',
	'V_BandollierB_cbr',
	'SMG_02_F',
//	'arifle_Mk20_F',
	'30Rnd_556x45_Stanag_Tracer_Green',
	'30Rnd_9x21_Mag',
	'30Rnd_9x21_Mag_SMG_02',
	'V_TacVest_blk_POLICE',
	'V_TacVest_gen_F',
	'V_Rangemaster_belt',
	'V_BandollierB_khk',
	'V_BandollierB_cbr',
	'V_BandollierB_rgr',
	'V_BandollierB_blk',
	'V_BandollierB_oli',
	'optic_Aco_smg',
	'optic_ACO_grn_smg',
	'U_B_Wetsuit',
	'G_Diving',
	'V_RebreatherB',
	'U_B_Protagonist_VR'
];
_constable = [
//	'arifle_MXC_Black_F',
//	'arifle_MX_Black_F',
	'30Rnd_556x45_Stanag',
	'30Rnd_65x39_caseless_mag',
	'30Rnd_65x39_caseless_mag_Tracer',
//	'U_O_PilotCoveralls',
	'optic_MRCO',
	'optic_Arco_blk_F',
	'optic_ERCO_blk_F',
//	'H_HelmetB_light_black',
	'optic_Hamr',
//	'acc_pointer_IR',
//	'MiniGrenade',
//	'arifle_SDAR_F',
	'20Rnd_556x45_UW_mag',
	'H_HelmetB_light_black'
];
_corporal = [
//	'arifle_MXM_Black_F'
];
_sergeant = [
//	'B_UAV_01_backpack_F',
	'B_UavTerminal',
	'U_B_CombatUniform_mcam_worn',
	'H_Beret_gen_F'
];
_lieutenant = [
	'hgun_Pistol_heavy_01_F',
	'acc_pointer_IR',
//	'arifle_SPAR_03_blk_F',
	'11Rnd_45ACP_Mag',
	'optic_MRD',
	'acc_flashlight_pistol',
//	'srifle_DMR_03_F',
	'20Rnd_762x51_Mag',
	'G_Goggles_VR'
];
_captain = [];

//Now we add items allowed by talents, lootcrates, and donor requirements!
if (71 in life_talents) then {_sergeant pushBack 'B_UAV_01_backpack_F';};

if (77 in life_talents) then {
	_cadet pushBack 'arifle_Mk20_F';
	_cadet pushBack 'arifle_SPAR_01_blk_F';
};

if (78 in life_talents) then {
	_constable pushBack 'arifle_MXC_Black_F';
	_constable pushBack 'arifle_SDAR_F';
};

if (79 in life_talents) then {
	_cadet pushBack 'V_TacVest_blk_POLICE';
	_cadet pushBack 'V_TacVest_gen_F';
};

if (80 in life_talents) then {_constable pushBack 'arifle_MX_Black_F';};

if (81 in life_talents) then {
	_corporal pushBack 'arifle_MXM_Black_F';
	_lieutenant pushBack 'arifle_SPAR_03_blk_F';
	_lieutenant pushBack 'srifle_DMR_03_F';
	_lieutenant pushBack 'srifle_dmr_03_f';
};

if (82 in life_talents) then {_constable pushBack 'MiniGrenade';};
if (6 in life_lootRewards || 7 in life_lootRewards) then {_constable pushBack 'H_HelmetB_light_black';};
if (8 in life_lootRewards || 9 in life_lootRewards) then {_constable pushBack 'U_O_PilotCoveralls';};
if (life_donator >= 2) then {_cadet pushBack 'H_Beret_blk'};
if (life_donator >= 4) then {_cadet pushBack 'H_Beret_02'};

if (life_donator >= 7) then {
	_cadet pushBack 'H_Beret_Colonel';
	_cadet pushBack 'U_B_Protagonist_VR';
};


//Figure out what the cop can actually have!
_whitelist = switch (life_coplevel) do {
	case (1):{_cadet};
	case (2):{_cadet + _constable};
	case (3):{_cadet + _constable + _corporal};
	case (4):{_cadet + _constable + _corporal + _sergeant};
	case (5):{_cadet + _constable + _corporal + _sergeant + _lieutenant};
	case (6):{_cadet + _constable + _corporal + _sergeant + _lieutenant + _captain};
	default{_captain};
};

/*
for "_x" from 0 to ((count _gear) - 1) do {
	if (typeName(_gear select _x) == "ARRAY") then {
		_gear_x = _gear select _x;
		for "_y" from 0 to ((count _gear_x) - 1) do {
			if (!((_gear_x select _y) in (_whitelist))) then {_gear_x set [_y,''];};
		};
		_gear set [_x,_gear_x];
	} else {
		if (!((_gear select _x) in (_whitelist))) then {_gear set [_x,''];};
	};
};
//[] call life_fnc_saveGear; // Because somehow _gear overwrites cop_gear by this point; we calculate it again. ~Gnash (DISABLED FOR TESTING)

_areEqual = [cop_gear select 0,_gear] call BIS_fnc_areEqual;
if !(_areEqual) then {
	cop_gear set [0,_gear];
	[] spawn life_fnc_loadGear;
};*/

//Remove bad items!
{
	if(!(_x in _whitelist)) then {
		player removeWeapon _x;
	};
} foreach weapons player;
{
	if(!(_x in _whitelist)) then {
		player removeItemFromUniform _x;
	};
} foreach uniformItems player;
{
	if(!(_x in _whitelist)) then {
		player removeItemFromVest _x;
	};
} foreach vestItems player;
{
	if(!(_x in _whitelist)) then {
		player removeItemFromBackpack _x;
	};
} foreach backpackItems player;
{
	if(!(_x in _whitelist)) then {
	player removeMagazine _x
	};
} forEach magazines player;
{
	if(!(_x in _whitelist)) then {
	player removePrimaryWeaponItem _x
	};
} forEach primaryWeaponItems player;

{
	if(!(_x in _whitelist)) then {
	player removeHandgunItem _x
	};
} forEach handgunItems player;

if !(uniform player in _whitelist) then {removeUniform player;};
if !(vest player in _whitelist) then {removeVest player;};
if !(backpack player in _whitelist) then {removeBackpack player;};
if !(headgear player in _whitelist) then {removeHeadgear player;};

//Swap out for the Gendarmerie gear if it's Tanoa!
if (worldName == "Tanoa") then
{
	if (uniform player == "U_Rangemaster") then { player forceAddUniform "U_B_GEN_Soldier_F" };
	if (uniform player == "U_B_CombatUniform_mcam_worn") then { player forceAddUniform "U_B_GEN_Commander_F" };
	if (vest player == "V_tacVest_blk_police") then { player addVest "V_TacVest_gen_F" };
	//if (headgear player == "H_Cap_police") then { if (life_copLevel >= 4) then { player addHeadgear "H_Beret_gen_F" } else { player addHeadgear "H_MilCap_gen_F" }; };
}
else
{
	if (uniform player == "U_B_GEN_Soldier_F") then { player forceAddUniform "U_Rangemaster" };
	if (uniform player == "U_B_GEN_Commander_F") then { player forceAddUniform "U_B_CombatUniform_mcam_worn" };
	if (vest player == "V_TacVest_gen_F") then { player addVest "V_tacVest_blk_police" };
	//if (headgear player in ["H_Beret_gen_F","H_MilCap_gen_F"]) then { player addHeadgear "H_Cap_police" };
};
