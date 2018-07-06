/*
	File: fn_copDefault.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Default cop configuration.
*/
//Strip the player down
RemoveAllWeapons player;
{player removeMagazine _x;} foreach (magazines player);
removeUniform player;
removeVest player;
removeBackpack player;
removeGoggles player;
removeHeadGear player;
{
	player unassignItem _x;
	player removeItem _x;
} foreach (assignedItems player);

//Load player with default cop gear.
player forceAddUniform "U_Rangemaster";
if (79 in life_talents) then { player addVest "V_tacVest_blk_police" } else { player addVest "V_Rangemaster_belt" };
player addHeadgear "H_Cap_police";
player linkItem "ItemMap";
player linkItem "ItemWatch";
player linkItem "ItemCompass";
player linkItem "NVGoggles_OPFOR";
player linkItem "Binocular";
player linkItem "ItemGPS";
for "_x" from 1 to 4 do {player addItem "FirstAidKit";};
for "_x" from 1 to 3 do {player addMagazine "30Rnd_9x21_Mag";};
player addWeapon "hgun_P07_F";
player addHandgunItem "muzzle_snds_L";
if (77 in life_talents && life_copLevel >= 2) then {
	[player, "arifle_SPAR_01_blk_F", 6, "30Rnd_556x45_Stanag_Tracer_Green"] call BIS_fnc_addWeapon;
	for "_x" from 1 to 3 do {player addMagazine "30Rnd_556x45_Stanag";};
} else {
	[player, "SMG_05_F", 7, "30Rnd_9x21_Mag_SMG_02_Tracer_Yellow"] call BIS_fnc_addWeapon;
};
player addPrimaryWeaponItem "optic_ACO_grn_smg";

[] call life_fnc_saveGear;
[] call life_fnc_equipGear;