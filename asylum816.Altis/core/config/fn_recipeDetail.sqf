/*
	File: fn_recipeDetail.sqf
	Author: John "Paratus" VanderZwet

	Description:
	Returns an array of virtual items which are required for crafting
	the given item class.
*/
params [
	["_item","",[""]]
];

private _items = switch (_item) do
{
	case "C_Hatchback_01_F" : { [["life_inv_ironore",5]] };
	case "C_Offroad_01_F" : { [["life_inv_ironore",10]] };
	case "C_SUV_01_F" : { [["life_inv_ironore",10],["life_inv_rubber",2]] };
	case "C_Hatchback_01_sport_F" : { [["life_inv_rubber",3],["life_inv_ironr",13],["life_inv_oilp",10]] };
	case "C_Van_01_transport_F" : { [["life_inv_rubber",3],["life_inv_ironr",20],["life_inv_oilp",10]] };
	case "C_Van_01_box_F" : { [["life_inv_rubber",3],["life_inv_ironr",30],["life_inv_oilp",10]] };
	case "C_Heli_Light_01_civil_F" : { [["life_money",20000],["life_inv_rubber",6],["life_inv_oilp",10]] };
	case "I_Heli_Transport_02_F" : { [["life_money",30000],["life_inv_diamondf",1],["life_inv_rubber",10],["life_inv_oilp",20]] };
	case "B_Heli_Light_01_F" : { [["life_money",20000],["life_inv_rubber",6],["life_inv_diamondr",20],["life_inv_oilp",20]] };
	case "C_Offroad_01_F" : { [["life_inv_ironore",10],["life_inv_oilp",1]] };
	case "B_G_Offroad_01_F" : { [["life_inv_ironore",10],["life_inv_oilp",1]] };
	case "B_G_Offroad_01_armed_F" : { [["life_money",70000],["life_inv_diamondf",1],["life_inv_ironr",30],["life_inv_oilp",10],["life_inv_rubber",4]] };
	case "C_Boat_Civil_01_F" : { [["life_inv_ironore",10],["life_inv_turtle",2]] };
	case "C_Boat_Civil_01_rescue_F" : { [["life_inv_ironore",10],["life_inv_turtle",2]] };
	case "O_MRAP_02_F" : { [["life_money",40000],["life_inv_diamondf",2],["life_inv_ironr",30],["life_inv_oilp",10],["life_inv_rubber",6]] };
	case "I_Heli_light_03_unarmed_F" : { [["life_money",30000],["life_inv_diamondf",1],["life_inv_diamondr",20],["life_inv_oilp",10],["life_inv_rubber",10]] };
	case "O_Heli_Light_02_unarmed_F" : { [["life_money",40000],["life_inv_diamondf",1],["life_inv_diamondr",20],["life_inv_oilp",10],["life_inv_rubber",10]] };
	case "O_Heli_Transport_04_F" : { [["life_money",40000],["life_inv_diamondf",1],["life_inv_diamondr",20],["life_inv_oilp",10],["life_inv_rubber",10]] };
	case "O_Heli_Transport_04_bench_F" : { [["life_money",40000],["life_inv_diamondf",1],["life_inv_diamondr",20],["life_inv_oilp",10],["life_inv_rubber",10]] };
	case "I_Truck_02_transport_F" : { [["life_money",4000],["life_inv_ironr",30],["life_inv_oilp",10],["life_inv_rubber",4]] };
	case "I_Truck_02_covered_F" : { [["life_money",8000],["life_inv_ironr",30],["life_inv_oilp",10],["life_inv_rubber",6]] };
	case "B_Truck_01_transport_F" : { [["life_money",9000],["life_inv_ironr",30],["life_inv_oilp",10],["life_inv_rubber",6]] };
	case "B_Truck_01_box_F" : { [["life_money",14000],["life_inv_ironr",30],["life_inv_oilp",10],["life_inv_rubber",8]] };
	case "LMG_Mk200_F" : { [["life_money",20000],["life_inv_diamond",2],["life_inv_meth",30]] };
	case "hgun_PDW2000_F" : { [["life_inv_ironore",10],["life_inv_copperr",5]] };
	case "9Rnd_45ACP_Mag";
	case "30Rnd_45ACP_Mag_SMG_01";
	case "30Rnd_556x45_Stanag";
	case "30Rnd_9x21_Mag" : {[["life_inv_ironore",1]]};
	case "hgun_ACPC2_F" : { [["life_inv_ironore",6],["life_inv_copperr",2]] };
	case "SMG_02_F" : { [["life_inv_ironore",8],["life_inv_saltr",5]] };
	case "SMG_01_F" : { [["life_inv_ironore",10],["life_inv_saltr",7]] };
	case "30Rnd_65x39_caseless_green": { [["life_inv_heroinu",1]] };
	case "20Rnd_762x51_Mag": {[[if (worldName == "Altis") then { "life_inv_coke" } else { "life_inv_cocaleaf" },1]]};
	case "30Rnd_762x39_Mag_F": {[[if (worldName == "Altis") then { "life_inv_coke" } else { "life_inv_cocaleaf" },2]]};
	case "arifle_Katiba_C_F" : { [["life_inv_ironore",2],["life_inv_heroinu",10]] };
	case "arifle_Katiba_F" : { [["life_inv_ironore",2],["life_inv_heroinu",10]] };
	case "srifle_DMR_01_F" : { [["life_inv_diamond",2],[if (worldName == "Altis") then { "life_inv_coke" } else { "life_inv_cocaleaf" },13]] };
	case "srifle_EBR_F" : { [["life_inv_diamond",4],[if (worldName == "Altis") then { "life_inv_coke" } else { "life_inv_cocaleaf" },13]] };
	case "srifle_DMR_03_khaki_F" : { [["life_inv_diamond",4],[if (worldName == "Altis") then { "life_inv_coke" } else { "life_inv_cocaleaf" },13]] };
	case "srifle_DMR_03_multicam_F" : { [["life_inv_diamond",4],[if (worldName == "Altis") then { "life_inv_coke" } else { "life_inv_cocaleaf" },13]] };
	case "srifle_DMR_03_tan_F" : { [["life_inv_diamond",4],[if (worldName == "Altis") then { "life_inv_coke" } else { "life_inv_cocaleaf" },13]] };
	case "srifle_DMR_03_woodland_F" : { [["life_inv_diamond",4],[if (worldName == "Altis") then { "life_inv_coke" } else { "life_inv_cocaleaf" },13]] };
	case "srifle_DMR_06_olive_F" : { [["life_inv_diamond",4],[if (worldName == "Altis") then { "life_inv_coke" } else { "life_inv_cocaleaf" },13]] };
	case "srifle_DMR_06_camo_F" : { [["life_inv_diamond",4],[if (worldName == "Altis") then { "life_inv_coke" } else { "life_inv_cocaleaf" },13]] };
	case "arifle_AKM_F" : { [["life_inv_diamond",2],[if (worldName == "Altis") then { "life_inv_coke" } else { "life_inv_cocaleaf" },13]] };
	case "arifle_AK12_F" : { [["life_inv_diamond",4],[if (worldName == "Altis") then { "life_inv_coke" } else { "life_inv_cocaleaf" },13]] };
	case "arifle_SPAR_03_khk_F" : { [["life_inv_diamond",3],[if (worldName == "Altis") then { "life_inv_coke" } else { "life_inv_cocaleaf" },13]] };
	case "arifle_SPAR_03_snd_F" : { [["life_inv_diamond",3],[if (worldName == "Altis") then { "life_inv_coke" } else { "life_inv_cocaleaf" },13]] };
	case "LMG_03_F" : { [["life_money",1000],["life_inv_diamond",2],[if (worldName == "Altis") then { "life_inv_meth" } else { "life_inv_cokepure" },19]] };
	default { [] };
};

if (worldName == "Tanoa" && _item == "SMG_01_F") then { _items = [["life_inv_ironore",10],["life_inv_sugar",6]] };
if (worldName == "Tanoa" && _item == "SMG_02_F") then { _items = [["life_inv_ironore",8],["life_inv_sugar",8]] };

_items; 
