/*
	File: fn_medicLoadout.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Loads the medic out with the default gear.
*/

{missionNamespace setVariable[_x,0];} foreach life_inv_items;
life_carryWeight = 0;

removeAllContainers player;
removeAllWeapons player;
removeHeadGear player;

if (571710 in (getDLCs 1)) then {
	player forceAddUniform "U_C_Paramedic_01_F";
	player addBackPack "B_Messenger_Black_F";
	player addGoggles "G_Respirator_white_F";
	player linkItem "NVGoggles";
	player linkItem "ItemGPS";
	player addItem "FirstAidKit";
	player addItem "FirstAidKit";
	player addItem "FirstAidKit";
	player addItem "FirstAidKit";
	player addItem "FirstAidKit";
}
else {
	player forceAddUniform "U_I_CombatUniform_shortsleeve";
	player linkItem "NVGoggles";
	player linkItem "ItemGPS";
	player addItem "FirstAidKit";
	player addItem "FirstAidKit";
	player addItem "FirstAidKit";
	player addItem "FirstAidKit";
	player addItem "FirstAidKit"; 
};

/* What??
if(hmd player != "") then {
	player unlinkItem (hmd player);
}; */

[true,"defib",1] call life_fnc_handleInv;
[true,"painkillers",8] call life_fnc_handleInv;
[true,"bloodbag",8] call life_fnc_handleInv;
[true,"splint",4] call life_fnc_handleInv;

if (life_donator > 1) then { [true,"debitcard",1] call life_fnc_handleInv; };

[] call life_fnc_equipGear;