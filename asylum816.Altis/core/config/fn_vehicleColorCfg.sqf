/*
    File: fn_vehicleColorCfg.sqf
    Author: Bryan "Tonic" Boardwine
    
    Format: [Texture1,Side,Texture2,Texture3,Texture4,DonationReq,PrestigeReq,LootRewardReq,VehicleShopReq]
    
    Description:
    Master configuration for vehicle colors.
*/
private["_vehicle","_ret","_path"];
_vehicle = [_this,0,"",[""]] call BIS_fnc_param;
if(_vehicle == "") exitWith {[]};
_ret = [];

switch (_vehicle) do
{
	case "I_Heli_Transport_02_F":
	{
		_path = "\a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_";
		_ret =
		[
			[_path + "1_ion_co.paa","civ",_path + "2_ion_co.paa",_path + "3_ion_co.paa"],
			[_path + "1_dahoman_co.paa","civ",_path + "2_dahoman_co.paa",_path + "3_dahoman_co.paa"],
			["CHROME","civ","CHROME","CHROME","CHROME",7]
		];
	};

	case "C_Hatchback_01_sport_F":
	{
		_path = "\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_";
		_ret set[8,["images\rustbucket.jpg","civ"]];
		_ret set[2,[_path + "sport03_co.paa","civ","","","",1]];
		_ret set[4,[_path + "sport05_co.paa","civ","","","",1]];
		_ret set[3,[_path + "sport04_co.paa","civ","","","",2]];
		_ret set[5,[_path + "sport06_co.paa","civ","","","",3]];
		_ret set[1,[_path + "sport02_co.paa","civ","","","",4]];
		_ret set[0,[_path + "sport01_co.paa","civ","","","",7]];
		_ret set[6,["images\police_hatchback.jpg","cop"]];
		_ret set[7,["images\hatchback_prestige.jpg","civ","","","",2,17]];
		_ret set[9,["images\asylumhondahigh.paa","civ","","","",3]];
		_ret set[10,["images\police_hatchback_super.jpg","cop"]];
		_ret set[11,["images\police_hatchback_hwypat.jpg","cop"]];
		_ret set[12,["images\medic_hatchback.jpg","med"]];
		_ret set[13,["images\lc3_bandit.jpg","civ","","","",0,0,28]];
		_ret set[14,["images\lc3_lee_flag.jpg","civ","","","",0,0,29]];
		_ret set[15,["images\lc3_lee_noflag.jpg","civ","","","",0,0,29]];
	};

	case "C_Plane_Civil_01_F":
	{
		_path = "\a3\air_f_exp\plane_civil_01\data\btt_";
		[
			[_path+"ext_01_racer_co.paa","civ",_path+"ext_02_racer_co.paa",_path+"int_01_tan_co.paa",_path+"int_02_tan_co.paa",3],
			[_path+"ext_01_racer_co.paa","civ",_path+"ext_02_racer_co.paa",_path+"int_01_co.paa",_path+"int_02_co.paa",3],
			[_path+"ext_01_redline_co.paa","civ",_path+"ext_02_redline_co.paa",_path+"int_01_tan_co.paa",_path+"int_02_tan_co.paa",1],
			[_path+"ext_01_redline_co.paa","civ",_path+"ext_02_redline_co.paa",_path+"int_01_co.paa",_path+"int_02_co.paa",1],
			[_path+"ext_01_wave_co.paa","civ",_path+"ext_02_wave_co.paa",_path+"int_01_tan_co.paa",_path+"int_02_tan_co.paa",0],
			[_path+"ext_01_wave_co.paa","civ",_path+"ext_02_wave_co.paa",_path+"int_01_co.paa",_path+"int_02_co.paa",0],
			[_path+"ext_01_tribal_co.paa","civ",_path+"ext_02_tribal_co.paa",_path+"int_01_tan_co.paa",_path+"int_02_tan_co.paa",2],
			[_path+"ext_01_tribal_co.paa","civ",_path+"ext_02_tribal_co.paa",_path+"int_01_co.paa",_path+"int_02_co.paa",2]
		]
	};

	case "C_Scooter_Transport_01_F":
	{
		_path = "\a3\boat_f_exp\scooter_transport_01\data\scooter_transport_01_";
		_ret =
		[
			[_path + "black_co.paa","civ",_path + "vp_black_co.paa","","",4],
			[_path + "lime_co.paa","civ",_path + "vp_lime_co.paa","","",3],
			[_path + "yellow_co.paa","civ",_path + "vp_yellow_co.paa","","",2],
			[_path + "grey_co.paa","civ",_path + "vp_grey_co.paa","","",2],
			[_path + "red_co.paa","civ",_path + "vp_red_co.paa","","",1],
			[_path + "co.paa","civ",_path + "vp_co.paa","","",0],
			[_path + "blue_co.paa","civ",_path + "vp_blue_co.paa","","",0]
		];
		
	};
	
	case "I_C_Offroad_02_LMG_F";
	case "C_Offroad_02_unarmed_F":
	{
		// Has 4 textures; but 2 and 4 aren't used and are duplicates of 1 and 3.
		_path = "\a3\soft_f_exp\offroad_02\data\offroad_02_";
		_ret =
		[
			[_path + "ext_orange_co.paa","civ","",_path + "int_orange_co.paa","",1],
			[_path + "ext_red_co.paa","civ","",_path + "int_red_co.paa","",4],
			[_path + "ext_blue_co.paa","civ","",_path + "int_black_co.paa","",3],
			[_path + "ext_green_co.paa","civ","",_path + "int_green_co.paa","",2],
			[_path + "ext_olive_co.paa","civ","",_path + "int_olive_co.paa","",1],
			[_path + "ext_brown_co.paa","civ","",_path + "int_brown_co.paa","",0],
			[_path + "ext_black_co.paa","civ","",_path + "int_black_co.paa","",7],
			[_path + "ext_white_co.paa","civ","",_path + "int_white_co.paa","",0]
		];
		if (worldName == "Tanoa") then {
		_ret set[8,["images\police_jeep.jpg","cop","",_path + "int_black_co.paa","",0]];
		};
	};
	
	case "B_T_LSV_01_unarmed_F":
	{
		_path = "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_";
		_ret =
		[
			
			[_path + "01_dazzle_CO.paa","reb",_path + "02_olive_CO.paa",_path + "03_olive_CO.paa","adds_olive_CO.paa",0], // This using olive in 3-5 is correct
			[_path + "01_sand_CO.paa","civ",_path + "02_sand_CO.paa",_path + "03_sand_CO.paa","adds_sand_CO.paa",2],
			[_path + "01_black_CO.paa","reb",_path + "02_black_CO.paa",_path + "03_black_CO.paa","adds_black_CO.paa",3],
			[_path + "01_olive_CO.paa","civ",_path + "02_olive_CO.paa",_path + "03_olive_CO.paa","adds_olive_CO.paa",1],
			["images\police_prowler.jpg","cop",_path + "02_black_CO.paa",_path + "03_black_CO.paa","adds_black_CO.paa"]
		];
	};
	
	case "O_LSV_02_armed_F";
	case "O_T_LSV_02_unarmed_F":
	{
		_path = "\a3\soft_f_exp\lsv_02\data\csat_lsv_";
		_ret =
		[
			[_path + "01_arid_co.paa","reb",_path + "02_arid_co.paa",_path + "03_arid_co.paa","",0],
			[_path + "01_ghex_co.paa","reb",_path + "02_ghex_co.paa",_path + "03_ghex_co.paa","",2],
			[_path + "01_black_co.paa","civ",_path + "02_black_co.paa",_path + "03_black_co.paa","",4]
		];
	};
	
	case "C_Boat_Transport_02_F":
	{
		_path = "\a3\boat_f_exp\boat_transport_02\data\boat_transport_02_";
		_ret =
		[
			[_path + "exterior_civilian_co.paa","civ",_path + "interior_2_civilian_co.paa","","",0],
			[_path + "exterior_co.paa","civ",_path + "interior_2_co.paa","","",3]
		];
	};
		
	case "C_Offroad_01_F":
	{
		_path = "\A3\soft_F\Offroad_01\Data\offroad_01_ext_";
		_ret = 
		[
			[_path + "co.paa", "civ"], 
			[_path + "BASE01_CO.paa", "civ"],
			[_path + "BASE02_CO.paa", "civ"],
			[_path + "BASE03_CO.paa","civ"],
			[_path + "BASE04_CO.paa","civ"],
			[_path + "BASE05_CO.paa","civ"],
			["#(ai,64,64,1)Fresnel(0.3,3)","fed"],
			["images\police_offroad.jpg","cop"], // ["#(ai,64,64,1)Fresnel(1.3,7)","cop"],
			["#(argb,8,8,3)color(0.6,0.3,0.01,1)","civ"]
		];
		_ret set[9,["#(argb,8,8,3)color(0.1,0,0.1,1)","civ","","","",1]]; // purple
		_ret set[10,["#(argb,8,8,3)color(0.2,0,0.2,1)","civ","","","",7]]; // pink
		_ret set[11,["#(argb,8,8,3)color(0,0.1,0.3,1)","civ","","","",3]]; // sky
		_ret set[12,["#(argb,8,8,3)color(0.5,0,0,1)","civ","","","",4]]; // red
		_ret set[13,["#(argb,8,8,3)color(0.3,0.3,0,1)","civ","","","",4]]; // yellow
		_ret set[14,["#(argb,8,8,3)color(0,0.5,0,1)","civ","","","",7]]; // lime
		_ret set[15,["images\offroad_01_ext_paramedic_co.jpg","med"]];
		_ret set[16,["CHROME","civ","CHROME","CHROME","CHROME",7]];
	};
		
	case "B_G_Offroad_01_armed_F":
	{
		_ret = 
		[
			["\A3\soft_f_gamma\Offroad_01\Data\offroad_01_ext_ig01_co.paa", "reb"],
			["images\police_offroad.jpg","cop"]
		];
	};
	
	case "I_Plane_Fighter_03_CAS_F":
	{
		_ret = 
		[
			["images\jet_civ_01.jpg","civ","images\jet_civ_02.jpg"]
		];
	};
	
	case "C_Hatchback_01_F":
	{
		_path = "\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_base";
		_ret =
		[
			[_path + "01_co.paa","civ"],
			[_path + "02_co.paa","civ"],
			[_path + "03_co.paa","civ"],
			[_path + "04_co.paa","civ"],
			[_path + "06_co.paa","civ"],
			[_path + "07_co.paa","civ"],
			[_path + "08_co.paa","civ"],
			[_path + "09_co.paa","civ"]
		];
	};
	
	case "C_SUV_01_F":
	{
		_path = "\a3\soft_f_gamma\SUV_01\Data\suv_01_ext_";
		_ret =
		[
			[_path + "co.paa","civ"],
			["images\police_suv.jpg","cop"],
			[_path + "03_co.paa","civ"],
			[_path + "04_co.paa","civ"],
			[_path + "02_co.paa","civ"],
			["images\suv_01_ext_paramedic_co.jpg","med"]
		];
	};
	
    case "C_Van_01_box_F":
    {    
        _ret = 
        [
            ["\a3\soft_f_gamma\Van_01\Data\Van_01_ext_co.paa","civ","","","",0,0,0],
            ["\a3\soft_f_gamma\Van_01\Data\van_01_ext_red_co.paa","civ","","","",0,0,0],
            ["images\Van_01_ext_crank.jpg","civ","images\Van_01_adds_crank.jpg","","",0,0,0,"civ_special"]
        ];
    };
	
	case "C_Van_01_transport_F":
	{
		_ret = 
		[
			["\a3\soft_f_gamma\Van_01\Data\Van_01_ext_co.paa","civ"],
			["\a3\soft_f_gamma\Van_01\Data\van_01_ext_red_co.paa","civ"]
		];
	};
	
	case "C_Van_02_vehicle_F":
	{
		_ret = 
		[
			["\a3\soft_f_orange\van_02\data\van_body_CO.paa","civ"],
			["images\van_02_blood.jpg","civ","","","",4],
			["images\van_02_ateam.jpg","civ","","","",4],
			["images\van_02_news.jpg","civ","","","",5],
			["images\van_02_mystery.jpg","civ","","","",7]
		];
	};

	case "C_Van_02_transport_F":
	{
		_ret = 
		[
			["images\van_02_police.jpg","cop"],
			["images\van_02_school.jpg","civ","","","",6],
			["images\van_02_rusty.jpg","civ",3],
			["\a3\soft_f_orange\van_02\data\van_body_white_CO.paa","civ"]
			
		];
	};
	
	case "B_Quadbike_01_F":
	{
		_ret = 
		[
			["\A3\Soft_F\Quadbike_01\Data\Quadbike_01_co.paa","cop"],
			["\A3\Soft_F\Quadbike_01\Data\quadbike_01_opfor_co.paa","reb"],
			["\A3\Soft_F_beta\Quadbike_01\Data\quadbike_01_civ_black_co.paa","civ"],
			["\A3\Soft_F_beta\Quadbike_01\Data\quadbike_01_civ_blue_co.paa","civ"],
			["\A3\Soft_F_beta\Quadbike_01\Data\quadbike_01_civ_red_co.paa","civ"],
			["\A3\Soft_F_beta\Quadbike_01\Data\quadbike_01_civ_white_co.paa","civ"],
			["\A3\Soft_F_beta\Quadbike_01\Data\quadbike_01_indp_co.paa","reb"],
			["\a3\soft_f_gamma\Quadbike_01\data\quadbike_01_indp_hunter_co.paa","civ","","","",3],
			["\a3\soft_f_gamma\Quadbike_01\data\quadbike_01_indp_hunter_co.paa","reb"]
		];
	};
	
	case "B_Heli_Light_01_F";
	case "C_Heli_Light_01_civil_F":
	{
		_path = "\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_";
		_ret = 
		[
			["images\heli_light_01_ext_police_co.jpg","cop"],
			["images\heli_light_01_ext_police_co.jpg","fed"],
			["\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_blue_co.paa","civ"],
			["\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_co.paa","civ"],
			["\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_indp_co.paa","reb"],
			[_path + "blueline_co.paa","civ"],
			[_path + "elliptical_co.paa","civ"],
			[_path + "furious_co.paa","civ"],
			[_path + "jeans_co.paa","civ"],
			[_path + "speedy_co.paa","civ"],
			[_path + "sunset_co.paa","civ"],
			[_path + "vrana_co.paa","civ"],
			[_path + "wave_co.paa","civ"],
			[_path + "digital_co.paa","reb"],
			["images\heli_light_01_ext_paramedic_co.jpg","med"],
			["CHROME","civ","CHROME","CHROME","CHROME",7],
			[_path + "shadow_co.paa","civ"],
			[_path + "graywatcher_co.paa","civ"],
			[_path + "wasp_co.paa","civ"],
			["images\heli_news.jpg","civ","","","",5]
		];
	};
	
	case "O_Heli_Light_02_unarmed_F":
	{
		_path = "\a3\air_f\Heli_Light_02\Data\heli_light_02_ext_";
		_ret = 
		[
			[_path + "co.paa","fed"],
			[_path + "civilian_co.paa","civ"],
			[_path + "indp_co.paa","reb"],
			[_path + "opfor_co.paa","reb"],
			["\a3\air_f_heli\heli_light_02\data\heli_light_02_ext_opfor_v2_co.paa","civ","","","",7],
			["images\heli_light_02_ext_pirate.jpg","reb","","","",0,0,13],
//			["images\heli_light_02_ext_pirate.jpg","civ","","","",0,0,13],
			["images\heli_light_02_ext_police.jpg","cop","","","",0,0],
			["images\lc3_orca_rescue.jpg","civ","","","",0,0,30]
		];
	};
	
	case "B_MRAP_01_F":
	{
		_ret = 
		[
			["images\police_hunter_base.jpg","cop","images\police_hunter_add.jpg"],
			["#(argb,8,8,3)color(0.05,0.05,0.05,1)","fed"],
			["images\civilian_hunter_base.jpg","civ","images\civilian_hunter_adds.jpg"],
			["images\lc3_primefront.jpg","civ","images\lc3_primerear.jpg","","",0,0,26]
		];
	};
	
	case "O_MRAP_02_F":
	{
		_ret = 
		[
			["\A3\soft_f\MRAP_02\data\mrap_02_ext_01_co.paa","reb","\A3\soft_f\MRAP_02\data\mrap_02_ext_02_co.paa"],
			["images\mrap_02_assimov_01.jpg","reb","images\mrap_02_assimov_02.jpg","","",0,0,16],
			["images\mrap_02_wartorn_01.jpg","reb","images\mrap_02_wartorn_02.jpg","","",0,0,17],
			["images\mrap_02_pirate_01.jpg","reb","images\mrap_02_pirate_02.jpg","","",0,0,18],
			["images\lc3_molten.jpg","reb","#(argb,8,8,3)color(0.05,0.05,0.05,1)","","",0,0,27],
			["images\lc3_green1.jpg","reb","images\lc3_green2.jpg","","",0,0,20],
			["images\lc3_orange1.jpg","reb","images\lc3_orange2.jpg","","",0,0,21],
			["images\lc3_red1.jpg","reb","images\lc3_red2.jpg","","",0,0,22],
			["images\lc3_violet1.jpg","reb","images\lc3_violet2.jpg","","",0,0,23],
			["images\lc3_white1.jpg","reb","images\lc3_white2.jpg","","",0,0,24],
			["images\lc3_yellow1.jpg","reb","images\lc3_yellow2.jpg","","",0,0,25],
			["images\lc3_blue1.jpg","reb","images\lc3_blue2.jpg","","",0,0,19]
		];
	};
	
	case "I_MRAP_03_F":
	{
		_ret = 
		[
			["images\mrap_03_police_co.jpg","cop"],
			["#(argb,8,8,3)color(0.05,0.05,0.05,1)","fed"]
		];
	};
	
	case "I_Truck_02_covered_F":
	{
		_ret = 
		[
			["\A3\Soft_F_Beta\Truck_02\Data\truck_02_kab_co.paa","civ","\A3\Soft_F_Beta\Truck_02\data\truck_02_kuz_co.paa"],
			["#(argb,8,8,3)color(0.05,0.05,0.05,1)","fed"]
		];
	};
	
	case "I_Truck_02_transport_F":
	{
		_ret = 
		[
			["\A3\Soft_F_Beta\Truck_02\Data\truck_02_kab_co.paa","civ","\A3\Soft_F_Beta\Truck_02\data\truck_02_kuz_co.paa"],
			["#(argb,8,8,3)color(0.05,0.05,0.05,1)","fed"]
		];
	};
	
	
	case "I_Heli_light_03_unarmed_F":
	{
		_ret = 
		[
			["images\police_hellcat.jpg","cop"],
			["\A3\air_f_epb\Heli_Light_03\data\heli_light_03_base_co.paa","reb"],
			["\A3\air_f_epb\Heli_Light_03\data\heli_light_03_base_indp_co.paa","reb"],
			["#(argb,8,8,3)color(0.5,0.05,0.05,1)","reb"],
			["#(argb,8,8,3)color(0.5,0.5,0.5,1)","reb"],
			["#(argb,8,8,3)color(0,0.1,0.3,1)","reb"]
		];
	};
	
	case "C_Van_01_fuel_F":
	{
		_ret =
		[
			["\a3\soft_f_gamma\Van_01\Data\van_01_ext_black_co.paa","civ","images\fuel_boxtruck.jpg"]
		];
	};
	
	case "C_Truck_02_fuel_F":
	{
		_ret =
		[
			["#(argb,8,8,3)color(0.05,0.05,0.05,1)","civ","images\fuel_zamak.jpg"]
		];
	};
};

_ret;
