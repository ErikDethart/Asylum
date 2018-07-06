/*
	File: fn_recipes.sqf
	Author: John "Paratus" VanderZwet

	Description:
	Recipes for crafting items
*/
private["_shop"];
_shop = _this;
_items = [];

_items = switch (worldName) do
{
	case "Tanoa":
	{
		switch (_shop) do
		{
			case "vehicles" : { ["C_Hatchback_01_F","C_SUV_01_F","C_Hatchback_01_sport_F","C_Van_01_transport_F","C_Van_01_box_F","I_Truck_02_transport_F","I_Truck_02_covered_F","B_Truck_01_transport_F","B_Truck_01_box_F","C_Heli_Light_01_civil_F","B_Heli_Light_01_F","I_Heli_Transport_02_F","O_Heli_Light_02_unarmed_F"] };
			case "blackmarket" : { ["B_G_Offroad_01_F","B_G_Offroad_01_armed_F","I_Heli_light_03_unarmed_F","O_Heli_Light_02_unarmed_F","30Rnd_65x39_caseless_green","20Rnd_762x51_Mag","arifle_Katiba_F","arifle_Katiba_C_F","LMG_Mk200_F","srifle_DMR_01_F","srifle_EBR_F","srifle_DMR_03_khaki_F","srifle_DMR_03_multicam_F","srifle_DMR_03_tan_F","srifle_DMR_03_woodland_F","srifle_DMR_06_olive_F","srifle_DMR_06_camo_F","arifle_AKM_F","arifle_AK12_F","arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F","LMG_03_F","30Rnd_762x39_Mag_F"] };
			case "weapons" : { ["30Rnd_45ACP_Mag_SMG_01","30Rnd_9x21_Mag","9Rnd_45ACP_Mag","hgun_ACPC2_F","hgun_PDW2000_F","SMG_02_F","SMG_01_F"] };
			default { [] };
		};
	};
	default
	{
		switch (_shop) do
		{
			case "vehicles" : { ["C_Hatchback_01_F","C_SUV_01_F","C_Hatchback_01_sport_F","C_Van_01_transport_F","C_Van_01_box_F","I_Truck_02_transport_F","I_Truck_02_covered_F","B_Truck_01_transport_F","B_Truck_01_box_F","C_Heli_Light_01_civil_F","B_Heli_Light_01_F","I_Heli_Transport_02_F","O_Heli_Light_02_unarmed_F"] };
			case "blackmarket" : { ["B_G_Offroad_01_F","B_G_Offroad_01_armed_F","O_MRAP_02_F","I_Heli_light_03_unarmed_F","O_Heli_Light_02_unarmed_F","30Rnd_65x39_caseless_green","20Rnd_762x51_Mag","arifle_Katiba_F","arifle_Katiba_C_F","LMG_Mk200_F","srifle_DMR_01_F","srifle_EBR_F","srifle_DMR_03_khaki_F","srifle_DMR_03_multicam_F","srifle_DMR_03_tan_F","srifle_DMR_03_woodland_F","srifle_DMR_06_olive_F","srifle_DMR_06_camo_F","arifle_AKM_F","arifle_AK12_F","arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F","LMG_03_F","30Rnd_762x39_Mag_F"] };
			case "weapons" : { ["30Rnd_45ACP_Mag_SMG_01","30Rnd_9x21_Mag","9Rnd_45ACP_Mag","hgun_ACPC2_F","hgun_PDW2000_F","SMG_02_F","SMG_01_F"] };
			default { [] };
		};
	};
};

_items;