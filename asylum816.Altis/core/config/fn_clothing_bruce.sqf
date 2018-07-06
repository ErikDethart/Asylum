/*
	File: fn_clothing_bruce.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Master configuration file for Bruce's Outback Outfits.
*/
private["_filter","_ret"];
_filter = [_this,0,0,[0]] call BIS_fnc_param;
//Classname, Custom Display name (use nil for Cfg->DisplayName, price

//Shop Title Name
ctrlSetText[3103,"Bruce's Outback Outfits"];

_ret = [];
switch (_filter) do
{
	//Uniforms
	case 0:
	{
		_ret = 
		[
			["U_C_Poloshirt_blue","Poloshirt Blue",25],
			["U_C_Poloshirt_burgundy","Poloshirt Burgundy",25],
			["U_C_Poloshirt_stripped","Poloshirt Stripped",25],
			["U_C_Poloshirt_tricolour","Poloshirt Tricolour",25],
			["U_C_Poloshirt_burgundy","Poloshirt Twitch",35,"images\c_poloshirt_twitch.jpg"],
			["U_C_Poloshirt_salmon","Poloshirt Salmon",25],
			["U_C_Poloshirt_redwhite","Poloshirt Red and White",25],
			["U_Marshal","Yellow Plaid",50,"images\marshal_yellow_plaid.jpg"],
			["U_C_Poloshirt_redwhite","Poloshirt Asylum Ent.",40,"images\c_poloshirt_asylum_red.jpg"],
			["U_C_Poor_1","Shirt Blue",25],
			["U_I_G_Story_Protagonist_F","Buttonup Black Camo",5],
			["U_I_G_resistanceLeader_F","Combat T Green",5],
			["U_NikosBody","Buttonup Red Dragon",5],
			["U_Marshal","White Shirt",5],
			["U_OrestesBody",nil,5],
			["U_C_HunterBody_grn","Hunter Cream",5],
			["U_OG_Guerilla1_1","Tan Guerilla",30],
			["U_OG_Guerilla1_1","Brown Guerilla",30,"\A3\characters_f_gamma\civil\data\c_cloth1_brown.paa"],
			["U_OG_Guerilla1_1","Metal Guerilla",30,"\A3\characters_f_gamma\civil\data\c_cloth1_black.paa"],
			["U_OG_Guerilla3_1","Hunter Tan",5],
			["U_OG_Guerilla3_2","Hunter Green",5],
			["U_IG_Guerilla2_1","Buttonup Black",5],
			["U_IG_Guerilla2_2","Buttonup Checked",5],
			["U_IG_Guerilla2_3","Buttonup Navy",50],
			["U_I_C_Soldier_Bandit_1_F",nil,30],
			["U_I_C_Soldier_Bandit_2_F",nil,30],
			["U_I_C_Soldier_Bandit_3_F",nil,30],
			["U_I_C_Soldier_Bandit_4_F",nil,30],
			["U_I_C_Soldier_Bandit_5_F",nil,30],
			["U_C_Man_casual_1_F",nil,30],
			["U_C_Man_casual_2_F",nil,30],
			["U_C_Man_casual_3_F",nil,30],
			["U_C_man_sport_1_F",nil,30],
			["U_C_man_sport_2_F",nil,30],
			["U_C_man_sport_3_F",nil,30],
			["U_C_Man_casual_4_F",nil,30],
			["U_C_Man_casual_5_F",nil,30],
			["U_C_Man_casual_6_F",nil,30],
			["U_C_IDAP_Man_cargo_F",nil,30],
			["U_C_IDAP_Man_Jeans_F",nil,30],
			["U_C_IDAP_Man_casual_F",nil,30],
			["U_C_IDAP_Man_shorts_F",nil,30],
			["U_C_IDAP_Man_Tee_F",nil,30],
			["U_C_IDAP_Man_TeeShorts_F",nil,30],
			["U_C_ConstructionCoverall_Black_F",nil,30],
			["U_C_ConstructionCoverall_Blue_F",nil,30],
			["U_C_ConstructionCoverall_Red_F",nil,30],
			["U_C_ConstructionCoverall_Vrana_F",nil,30],
			["U_C_Mechanic_01_F",nil,30]
		];
		if(1 in life_lootRewards) then
		{
			_ret set[count _ret,["U_C_Poloshirt_salmon","Troll Face Shirt",25,"images\c_poloshirt_troll.jpg"]];
		};
		if(2 in life_lootRewards) then
		{
			_ret set[count _ret,["U_C_Poloshirt_redwhite","Sorry Shirt",25,"images\c_poloshirt_officer.jpg"]];
		};
		if(3 in life_lootRewards) then
		{
			_ret pushBack ["U_C_Poloshirt_salmon","Bieber Feaver Shirt",25,"images\c_poloshirt_bieber.jpg"];
		};
		if(4 in life_lootRewards) then
		{
			_ret pushBack ["U_C_Poloshirt_redwhite","Unicorn Shirt",25,"images\c_poloshirt_unicorn.jpg"];
		};
		if(10 in life_lootRewards) then
		{
			_ret pushBack ["U_C_Poloshirt_salmon","Taylor Swift Shirt",25,"images\c_poloshirt_swift.jpg"];
		};
		if(11 in life_lootRewards) then
		{
			_ret pushBack ["U_C_Man_casual_5_F","F* the Police Shirt",35,"images\c_summer_police.jpg"];
		};
		if(12 in life_lootRewards) then
		{
			_ret pushBack ["U_C_Man_casual_4_F","Sad Pepe Shirt",35,"images\c_summer_pepe.jpg"];
		};
		if(life_donator >= 1) then
		{
			_ret set[count _ret,["U_C_Poloshirt_salmon","Donor Hawaiian",30,"images\c_poloshirt_flowers.jpg"]];
		};
		if(life_donator >= 3) then
		{
			_ret set[count _ret,["U_C_Poloshirt_blue","Nice Job Man",30,"images\c_nice_job_man.jpg"]];
		};
		if(life_donator >= 7) then
		{
			_ret set[count _ret,["U_B_Protagonist_VR","Blue VR Suit",200]];
			_ret set[count _ret,["U_O_Protagonist_VR","Red VR Suit",200]];
			_ret set[count _ret,["U_I_Protagonist_VR","Green VR Suit",200]];
		}
		else
		{
			_ret set[count _ret,["U_I_Protagonist_VR","White VR Suit",200]];
		};
		if (difficultyEnabledRTD) then
		{
			_ret pushBack ["U_B_HeliPilotCoveralls",nil,250];
			_ret pushBack ["U_I_HeliPilotCoveralls",nil,250];
		};
		if (life_adminlevel > 2) then 
		{
			_ret pushBack ["U_C_Poloshirt_salmon","Poloshirt ADMIN",0,"images\c_poloshirt_admin.jpg"];
		};
	};
	
	//Hats
	case 1:
	{
		_ret = 
		[
			["H_Cap_surfer",nil,5],
			["H_Cap_red",nil,5],
			["H_Cap_blu",nil,5],
			["H_Cap_oli",nil,5],
			["H_Cap_grn",nil,5],
			["H_Cap_grn_BI",nil,5],
			["H_Cap_tan",nil,5],
			["H_Cap_blk",nil,5],
			["H_Cap_headphones",nil,5],
			["H_Cap_blk_CMMG",nil,5],
			["H_Cap_blk_ION",nil,5],
			["H_Cap_oli_hs",nil,5],
			["H_Cap_press",nil,5],
			["H_Cap_usblack",nil,5],
			["H_Booniehat_grn",nil,5],
			["H_Booniehat_tan",nil,5],
			["H_Booniehat_dirty",nil,5],
			["H_Bandanna_surfer",nil,5],
			["H_Bandanna_surfer_blk",nil,5],
			["H_Bandanna_surfer_grn",nil,5],
			["H_Bandanna_khk",nil,5],
			["H_Bandanna_cbr",nil,5],
			["H_Bandanna_sgg",nil,5],
			["H_Bandanna_blu",nil,5],
			["H_Bandanna_sand",nil,5],
			["H_Bandanna_gry",nil,5],
			["H_StrawHat",nil,5],
			["H_StrawHat_dark",nil,5],
			["H_Hat_blue",nil,5],
			["H_Hat_brown",nil,5],
			["H_Hat_grey",nil,5],
			["H_Hat_tan",nil,5],
			["H_Watchcap_blk",nil,5],
			["H_Watchcap_khk",nil,5],
			["H_Watchcap_sgg",nil,5],
			["H_Watchcap_camo",nil,5],
			["H_Hat_checker",nil,5],
			["H_Helmet_Skate",nil,1500],
			["H_Cap_Black_IDAP_F",nil,5],
			["H_Cap_Orange_IDAP_F",nil,5],
			["H_Cap_White_IDAP_F",nil,5],
			["H_EarProtectors_black_F",nil,5]
		];
		
		if(life_donator >= 2) then
		{
			_ret set[count _ret,["H_Beret_blk","Stylish Beret",50]];
		};	
		if(life_donator >= 4) then
		{
			_ret set[count _ret,["H_Beret_02","Executive Beret",50]];
		};
		if(life_donator >= 5) then
		{
			_ret set[count _ret,["H_EarProtectors_orange_F","Ear Protectors (Orange)",50]];
			_ret set[count _ret,["H_EarProtectors_red_F","Ear Protectors (Red)",50]];
			_ret set[count _ret,["H_EarProtectors_white_F","Ear Protectors (White)",50]];
			_ret set[count _ret,["H_EarProtectors_yellow_F","Ear Protectors (Yellow)",50]];
		};
		if(life_donator >= 6) then
		{
			_ret set[count _ret,["H_Hat_Safari_olive_F","Safari Hat (Olive)",50]];
			_ret set[count _ret,["H_Hat_Safari_sand_F","Safari Hat (Sand)",50]];
		};
		if(life_donator >= 7) then
		{
			_ret set[count _ret,["H_Beret_Colonel","Master Beret",50]];
		};
	};
	
	//Glasses
	case 2:
	{
		_ret = 
		[
			["G_Shades_Black",nil,2],
			["G_Shades_Blue",nil,2],
			["G_Spectacles",nil,2],
			["G_Spectacles_Tinted",nil,2],
			["G_Lady_Red",nil,10],
			["G_Lady_Blue",nil,10],
			["G_Lady_Mirror",nil,10],
			["G_Lady_Dark",nil,10],
			["G_Sport_Blackred",nil,2],
			["G_Sport_Checkered",nil,2],
			["G_Sport_Blackyellow",nil,2],
			["G_Sport_BlackWhite",nil,2],
			["G_Sport_Greenblack",nil,2],
			["G_Sport_Red",nil,2],
			["G_Squares",nil,5],
			["G_Lowprofile",nil,3],
			["G_Combat",nil,5],
			["G_Aviator",nil,15],
			["G_Respirator_blue_F","Blue SARS mask",15],
			["G_Respirator_white_F","White SARS mask",15],
			["G_Respirator_yellow_F","Yellow SARS mask",15]

		];
		if(life_donator >= 5) then
		{
			_ret set[count _ret,["G_EyeProtectors_F","Safety Goggles",50]];
			_ret set[count _ret,["G_EyeProtectors_Earpiece_F","Safety Goggles (Nerd)",50]];
		};
		if(life_donator >= 7) then
		{
			_ret set[count _ret,["G_Goggles_VR",nil,50]];
		};
	};
	
	//Vest
	case 3:
	{
		_ret = 
		[
			["V_Rangemaster_belt",nil,350],
			["V_BandollierB_cbr",nil,450],
			["V_BandollierB_khk",nil,450],
			["V_BandollierB_rgr",nil,450],
			["V_BandollierB_blk",nil,450],
			["V_BandollierB_oli",nil,450],
			["V_Safety_blue_F",nil,50],
			["V_Safety_orange_F",nil,50],
			["V_Safety_yellow_F",nil,50]
		];
		if ((license_civ_bounty) || (life_coplevel >2)) then { _ret pushBack ["V_TacVest_blk",nil,2000] };
	};
	
	//Backpacks
	case 4:
	{
		_ret =
		[
			["B_AssaultPack_blk",nil,60],
			["B_AssaultPack_cbr",nil,60],
			["B_AssaultPack_khk",nil,60],
			["B_AssaultPack_sgg",nil,60],
			["B_AssaultPack_rgr",nil,60],
			["B_FieldPack_cbr",nil,100],
			["B_FieldPack_blk",nil,100],
			["B_Kitbag_mcamo",nil,150],
			["B_Kitbag_sgg",nil,150],
			["B_Kitbag_cbr",nil,150],
			["B_Bergen_sgg",nil,150],
			["B_Carryall_oucamo",nil,250],
			["B_Carryall_khk",nil,250],
			["B_Carryall_cbr",nil,250],
			["B_Messenger_Black_F",nil,50],
			["B_Messenger_Coyote_F",nil,50],
			["B_Messenger_Gray_F",nil,50],
			["B_Messenger_Olive_F",nil,50]
		];
		if(5 in life_lootRewards) then
		{
			_ret pushBack ["B_Carryall_khk","Hiker's Backpack",250,"images\b_carryall_hiker.jpg"];
		};
	};
};
_ret;