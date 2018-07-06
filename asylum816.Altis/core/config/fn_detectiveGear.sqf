/*
	File: fn_detectiveGear.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Loads the detective out with the default gear.
*/

//{missionNamespace setVariable[_x,0];} forEach life_inv_items;
life_carryWeight = 0;

removeAllContainers player;
removeAllWeapons player;
removeHeadGear player;
_uniforms = ["U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_OG_Guerilla3_1","U_OG_Guerilla3_2","U_IG_Guerilla2_1","U_IG_Guerilla2_2","U_IG_Guerilla2_3","U_C_HunterBody_grn","U_OrestesBody","U_NikosBody","U_I_G_resistanceLeader_F","U_I_G_Story_Protagonist_F","U_C_Man_casual_1_F","U_C_man_sport_3_F","U_C_Man_casual_5_F"];
_backpacks = ["B_Carryall_oucamo","B_Bergen_sgg","B_Carryall_khk","B_Carryall_cbr","B_Bergen_mcamo","B_Bergen_rgr","B_Bergen_blk"];
_vests = ["V_Rangemaster_belt","V_BandollierB_cbr","V_BandollierB_khk","V_BandollierB_rgr","V_BandollierB_blk","V_BandollierB_oli"];
player forceAddUniform (_uniforms select (floor (random (count _uniforms))));
player addBackpack (_backpacks select (floor (random (count _backpacks))));
player addVest (_vests select (floor (random (count _backpacks))));

for "_x" from 1 to 3 do { player addMagazine "30Rnd_9x21_Mag"; };
player addWeapon "hgun_P07_F";
player addHandgunItem "muzzle_snds_L";
player linkItem "ItemMap";
player linkItem "ItemGPS";
player linkItem "ItemCompass";
player linkItem "NVGoggles";

(unitBackpack player) addMagazine "30Rnd_556x45_Stanag_Tracer_Green";
_weapon = if (395180 in (getDLCs 1)) then {
	selectRandom["arifle_SPAR_01_khk_F","arifle_SPAR_01_snd_F","arifle_TRG21_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F","arifle_TRG20_F"];
	} else {
	selectRandom["arifle_TRG21_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F","arifle_TRG20_F"];
};
(unitBackpack player) addWeaponCargo [_weapon,1];
(unitBackpack player) addItemCargo ["optic_MRCO",1];
(unitBackpack player) addItemCargo ["V_tacVest_blk_police",1];
(unitBackpack player) addItemCargo ["H_Cap_police",1];
for "_x" from 1 to 4 do { player addMagazine "30Rnd_556x45_Stanag"; };
for "_x" from 1 to 7 do { player addMagazine "30Rnd_556x45_Stanag_Tracer_Green"; };
if (82 in life_talents) then {for "_x" from 1 to 2 do { player addMagazine "MiniGrenade"; };};
for "_x" from 1 to 3 do { player addMagazine "SmokeShell"; };

if (life_donator > 1 && life_inv_debitCard < 1) then { [true,"debitcard",1] call life_fnc_handleInv; };
[] call life_fnc_saveGear;
