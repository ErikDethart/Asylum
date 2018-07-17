/*
	Description: Initiates the local map system, sets the zones, etc
*/
localMap_zoneLocations = [
	[[3598.78,13113,3.903], 600, "zone1"],  	//Kavala
	[[4493.07,14035.8,0], 350, "zone2"], 		//Kavala checkpoint
	[[5478.34,14997.7,0], 350, "zone3"], 		//Skiptracer base
	[[5082.22,10787.1,0], 350, "zone4"], 		//Airshop kav
	[[8984.34,12028,0], 350, "zone5"], 			//Turf drug dealer
	[[10635.4,12292.2,0], 350, "zone6"], 		//Therisa
	[[14790.9,10831,0], 350, "zone7"], 			//Bank of altis
	[[20525.1,8871.25,0], 350, "zone8"], 		//Turf drug dealer
	[[21638.2,10973,0], 350, "zone9"], 			//idk
	[[19965.8,11428.8,0], 350, "zone10"], 		//DP22
	[[16843.7,12719.3,0], 1000, "zone11"],		//Pyrgos
	[[16727.6,13607,0], 350, "zone12"], 		//Jail
	[[17785.8,14698.2,0], 350, "zone13"],		//skiptracer base
	[[15453.5,16001,0], 350, "zone14"], 		//Chop shop airfield
	[[16097,17003.5,0], 350, "zone15"], 		//Federal reserve
	[[14031.2,18725.3,0], 500, "zone16"], 		//Athira
	[[8595.85,18455.9,0], 350, "zone17"], 		//Lumber mill
	[[18411.1,18792.8,0], 350, "zone18"],		//Oil rig
	[[19350.5,18943.8,0], 350, "zone19"], 		//oil barrel processing
	[[21564.1,19445,0], 350, "zone20"],			//Lumber mill
	[[25704.1,21352.4], 500, "zone21"], 		//Sofia
	[[15278.5,22501.1,0], 350, "zone22"],		//Athira rebel
	[[22145.4,14470,0], 350, "zone23"],			//Meth lab
	[[23722.8,16240.3,0], 350, "zone24"],		//Salt flats
	[[23532,19937.2,0], 350, "zone25"]			//HW patrol outpost
];




//Debug information drawn on map to show zones
mapDebugEnabled = false;
testRadius = 0;
testRadiusSpawn = 0;
testRadiusDeSpawn = 0;

[] spawn{
	sleep 120;//we wait 120 seconds giving admins time to turn on mapDebugEnabled = true; if they wish to see the zones
	if(!mapDebugEnabled) exitWith {};
	if(isDedicated) exitWith {};
	sleep 10;
	findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw",
	{
		{
			_despawnRadius = 1250;
			if((_x select 1) <= 200) then {
				_despawnRadius = 550;
			};

			_this select 0 drawEllipse [
				(_x select 0), (_x select 1) + _despawnRadius, (_x select 1) + _despawnRadius, 0, [1, 0, 0, 1], "#(rgb,8,8,3)color(1,0,0,0.2)"
			];
		}foreach localMap_zoneLocations;

		{
			_spawnRadius = 1000;
			if((_x select 1) <= 200) then {
				_spawnRadius = 400;
			};

			_this select 0 drawEllipse [
				(_x select 0), (_x select 1) + _spawnRadius, (_x select 1) + _spawnRadius, 0, [0, 1, 0, 1], "#(rgb,8,8,3)color(0,1,0,0.3)"
			];
		}foreach localMap_zoneLocations;

		{
			_this select 0 drawEllipse [
				(_x select 0), (_x select 1), (_x select 1), 0, [0, 0, 1, 1], "#(rgb,8,8,3)color(0,0,1,0.3)"
			];

			(_this select 0) drawIcon [
				'iconStaticMG',
				[1,1,1,1],
				(_x select 0),
				30,
				30,
				0,
				(_x select 2),
				1,
				0.06,
				'EtelkaNarrowMediumPro',
				'right'
			];
		}foreach localMap_zoneLocations;

		_this select 0 drawEllipse [
			(getPosWorld player), testRadius + testRadiusDeSpawn, testRadius + testRadiusDeSpawn, 0, [1, 0, 0, 1], "#(rgb,8,8,3)color(1,0,0,0.2)"
		];

		_this select 0 drawEllipse [
			(getPosWorld player), testRadius + testRadiusSpawn, testRadius + testRadiusSpawn, 0, [0, 1, 0, 1], "#(rgb,8,8,3)color(0,1,0,0.3)"
		];

		_this select 0 drawEllipse [
			(getPosWorld player), testRadius, testRadius, 0, [0, 0, 1, 1], "#(rgb,8,8,3)color(0,0,1,0.3)"
		];

	}];
};

localMap_static_status = "idle";
localMap_static_objectList = [];
localMap_static_activeObjects = [];

{
	missionNamespace setVariable [(format["localMap_%1_status",(_x select 2)]),"idle"];
	missionNamespace setVariable [(format["localMap_%1_objectList",(_x select 2)]),[]];
	missionNamespace setVariable [(format["localMap_%1_activeObjects",(_x select 2)]),[]];
}foreach localMap_zoneLocations;

_shitObjects = ["I_Heli_light_03_unarmed_F","I_Heli_Transport_02_F","O_Heli_Light_02_unarmed_F","Headgear_H_Bandanna_sand","Headgear_H_Beret_blk","Headgear_H_Booniehat_mcamo","Headgear_H_Booniehat_oli","Headgear_H_Cap_blk","Headgear_H_Cap_blu","Headgear_H_Cap_grn","Headgear_H_Cap_marshal","Headgear_H_Cap_police","Headgear_H_Cap_red","Headgear_H_Hat_blue","Headgear_H_Hat_brown","Headgear_H_Hat_checker","Headgear_H_Hat_grey","Headgear_H_Hat_tan","Headgear_H_HelmetB_light_desert","Headgear_H_HelmetCrew_I","Headgear_H_HelmetLeaderO_oucamo","Headgear_H_HelmetSpecB","Headgear_H_HelmetSpecO_blk","Headgear_H_MilCap_blue","Headgear_H_MilCap_ocamo","Headgear_H_RacingHelmet_1_blue_F","Headgear_H_RacingHelmet_1_green_F","Headgear_H_RacingHelmet_1_orange_F","Headgear_H_RacingHelmet_1_red_F","Headgear_H_RacingHelmet_1_white_F","Headgear_H_RacingHelmet_3_F","Headgear_H_RacingHelmet_4_F","Headgear_H_ShemagOpen_khk","Headgear_H_ShemagOpen_tan","Headgear_H_Shemag_olive","Headgear_H_StrawHat","Headgear_H_Watchcap_cbr","Vest_V_BandollierB_blk","Vest_V_BandollierB_cbr","Vest_V_PlateCarrier1_blk","Vest_V_PlateCarrierIA2_dgtl","Vest_V_PlateCarrierIAGL_oli","Vest_V_RebreatherB","Vest_V_TacVest_blk_POLICE","Vest_V_TacVest_brn","Vest_V_TacVest_camo","Vest_V_TacVest_khk","Vest_V_TacVest_oli","Weapon_arifle_Katiba_F","Weapon_arifle_MXM_F","Weapon_arifle_MX_F","Weapon_arifle_TRG20_F","Weapon_arifle_TRG21_F","Weapon_hgun_ACPC2_F","Weapon_hgun_P07_F","Weapon_hgun_PDW2000_F","Weapon_hgun_Pistol_heavy_01_F","Weapon_hgun_Pistol_heavy_02_F","Weapon_hgun_Rook40_F","Weapon_launch_Titan_short_F","Weapon_LMG_Mk200_F","Weapon_SMG_01_F","Weapon_SMG_02_F","Weapon_srifle_DMR_01_F","Weapon_srifle_DMR_02_F","Weapon_srifle_DMR_03_F","Weapon_srifle_EBR_F","Weapon_srifle_GM6_F","Box_Syndicate_Wps_F","Box_IND_Wps_F","Box_GEN_Equip_F","Box_NATO_Uniforms_F","Land_OfficeCabinet_01_F","Land_MetalCase_01_small_F","Box_AAF_Uniforms_F","B_Heli_Transport_01_F","B_MBT_01_mlrs_F","Land_MetalCase_01_large_F","C_Offroad_01_repair_F","C_Heli_Light_01_civil_F"];

private["_zone","_zoneCheck"];
{
	_zone = "static";

	if(!(_x select 4)) then {
		if(((_x select 3) find "_isStatic = true") == -1) then {
			if((_x select 1) distance2d (getMarkerPos "jail_marker_asylum") > 110) then {
				for "_i" from 0 to ((count localMap_zoneLocations) - 1) do {
					_zoneCheck = (localMap_zoneLocations select _i);

					if(((_zoneCheck select 0) distance2d (_x select 1)) < (_zoneCheck select 1)) exitWith {
						_zone = _zoneCheck select 2;
					};
				};
			};
		};

		if(_x select 0 in life_decorObjects) then {
			if(!(_x select 0 in _shitObjects)) then {
				if(round(random(99)) <= 20) then {
					missionNamespace setVariable [(format["localMap_%1_objectList",_zone]),(missionNamespace getVariable [(format["localMap_%1_objectList",_zone]),[]]) + [_x]];
				};
			};
		}else{
			missionNamespace setVariable [(format["localMap_%1_objectList",_zone]),(missionNamespace getVariable [(format["localMap_%1_objectList",_zone]),[]]) + [_x]];
		};

	};
}foreach localMapData;

localMap_fnc_loadArea = {
	_status = (call compile format["localMap_%1_status",_this]);
	if(_status in ["creating", "removing", "active"]) exitWith {};
	(call compile format["localMap_%1_status = 'creating';",_this]);

	{
		_object = objNull;
		_object = _x call life_fnc_createLocalVehicle;

		sleep 0.0005;//small sleep to minimize lag on zone loading


		if(!isNull _object) then {
			missionNamespace setVariable [(format["localMap_%1_activeObjects",_this]),(missionNamespace getVariable [(format["localMap_%1_activeObjects",_this]),[]]) + [_object]];
		};
	}foreach (call compile format["localMap_%1_objectList",_this]);

	if(mapDebugEnabled) then {
		hint format["Dynamicaly loaded %1 objects in zone: %2", count (call compile format["localMap_%1_activeObjects",_this]),_this];
	};
	

	(call compile format["localMap_%1_status = 'active';",_this]);
};

localMap_fnc_unloadArea = {
	_status = (call compile format["localMap_%1_status",_this]);
	if(_status in ["creating", "idle", "removing"]) exitWith {};
	(call compile format["localMap_%1_status = 'removing';",_this]);

	_objectsRemoved = 0;
	{
		deleteVehicle _x;
		_objectsRemoved = _objectsRemoved + 1;
		sleep 0.002;
	}foreach (call compile format["localMap_%1_activeObjects",_this]);

	(call compile format["localMap_%1_activeObjects = [];",_this]);
	
	if(mapDebugEnabled) then {
		hint format["Dynamicaly un-loaded %1 objects in zone: %2", _objectsRemoved,_this];
	};
	
	(call compile format["localMap_%1_status = 'idle';",_this]);
};

[] spawn{
	private["_playerPos","_status"];

	"static" spawn localMap_fnc_loadArea;

	while{true} do {
		sleep 2;
		_playerPos = getPosWorld player;

		if(alive player && ((_playerPos distance2d getMarkerPos("Respawn_west")) > 600)) then {
			{
				_status = (call compile format["localMap_%1_status",(_x select 2)]);

				switch(_status) do {
					case "idle": {
						_radiusIncrease = 1000;
						if((_x select 1) <= 200) then {
							_radiusIncrease = 400;
						};

						if((_playerPos distance2d (_x select 0)) < ((_x select 1) + _radiusIncrease)) then {
							(_x select 2) spawn localMap_fnc_loadArea;
						};
					};

					case "active": {
						_radiusIncrease = 1250;
						if((_x select 1) <= 200) then {
							_radiusIncrease = 550;
						};

						if((_playerPos distance2d (_x select 0)) > ((_x select 1) + _radiusIncrease)) then {
							(_x select 2) spawn localMap_fnc_unloadArea;

						};
					};
					case "creating": {

					};
					case "removing": {

					};
				};
			}foreach localMap_zoneLocations;
		};
	};
};