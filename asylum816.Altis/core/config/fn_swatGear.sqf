/*
	File: fn_swatGear.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Loads equipment based on SWAT role
*/

private ["_role","_water"];

_role = [_this,0,0,[0]] call BIS_fnc_param;
_water = [_this,1,false,[false]] call BIS_fnc_param;

removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

switch (_role) do
{
	case 0: // Assault
	{
		if (_water) then
		{
			player forceAddUniform "U_B_Wetsuit";
			player addVest "V_RebreatherB";
			player addBackpack "B_AssaultPack_blk";
		}
		else
		{
			player forceAddUniform "U_B_CombatUniform_mcam_worn";
			player addVest "V_PlateCarrier1_blk";
		};
		if(life_deploySWAT select 2 > 100) then {player addBackpack "B_Parachute"; player addVest "V_PlateCarrier1_blk"};
		for "_i" from 1 to 10 do {player addItem "20Rnd_762x51_Mag";};
		for "_i" from 1 to 2 do {player addItem "SmokeShell";};
		for "_i" from 1 to 3 do {player addItem "MiniGrenade";};
		for "_i" from 1 to 6 do {player addItem "FirstAidKit";};
		player addItem "SmokeShell";
		player addItem "SmokeShellGreen";
		player addItem "11Rnd_45ACP_Mag";
		player addHeadgear "H_CrewHelmetHeli_B";
		player addGoggles "G_Balaclava_blk";
		player addWeapon "srifle_DMR_03_ARCO_F";
		player addPrimaryWeaponItem "acc_pointer_IR";
		player linkItem "ItemGPS";
	};
	case 1: // Recon
	{
		if (_water) then
		{
			player forceAddUniform "U_B_Wetsuit";
			player addVest "V_RebreatherB";
		}
		else
		{
			player forceAddUniform "U_B_CombatUniform_mcam_worn";
			player addVest "V_PlateCarrier1_blk";
		};
		if(life_deploySWAT select 2 > 100) then {player addBackpack "B_Parachute"; player addVest "V_PlateCarrier1_blk"} else {player addBackpack "B_UAV_01_backpack_F"};
		for "_i" from 1 to 4 do {player addItem "30Rnd_556x45_Stanag_Tracer_Green";};
		for "_i" from 1 to 5 do {player addItem "30Rnd_556x45_Stanag";};
		for "_i" from 1 to 2 do {player addItem "MiniGrenade";};
		for "_i" from 1 to 4 do {player addItem "SmokeShell";};
		for "_i" from 1 to 6 do {player addItem "FirstAidKit";};
		player addItem "SmokeShell";
		player addItem "SmokeShellGreen";
		player addGoggles "G_Balaclava_blk";
		player addWeapon "arifle_Mk20_F";
		player addPrimaryWeaponItem "muzzle_snds_acp";
		player addPrimaryWeaponItem "optic_ACO_grn";
		player linkItem "B_UavTerminal";
	};
	case 2: // Leader
	{
		if (_water) then
		{
			player forceAddUniform "U_B_Wetsuit";
			player addVest "V_RebreatherB";
		}
		else
		{
			player forceAddUniform "U_B_CombatUniform_mcam_worn";
			player addVest "V_PlateCarrier1_blk";
		};
		if(life_deploySWAT select 2 > 100) then {player addBackpack "B_Parachute"; player addVest "V_PlateCarrier1_blk"} else {player addBackpack "B_AssaultPack_blk"};
		for "_i" from 1 to 10 do {player addItem "20Rnd_762x51_Mag";};
		player addItem "SmokeShell";
		player addItem "SmokeShellGreen";
		for "_i" from 1 to 2 do {player addItem "MiniGrenade";};
		for "_i" from 1 to 2 do {player addItem "11Rnd_45ACP_Mag";};
		player addItem "Medikit";
		for "_i" from 1 to 6 do {player addItem "FirstAidKit";};
		for "_i" from 1 to 5 do {player addItem "SmokeShell";};
		player addGoggles "G_Balaclava_combat";
		player addWeapon "srifle_DMR_03_ARCO_F";
		player addPrimaryWeaponItem "acc_pointer_IR";
		player linkItem "ItemGPS";
		life_inv_ladder = 1;
	};
};

player addWeapon "hgun_Pistol_heavy_01_F";

player addWeapon "Rangefinder";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "NVGoggles_OPFOR";

[player,"TFAegis"] call bis_fnc_setUnitInsignia;
[] call life_fnc_equipGear;