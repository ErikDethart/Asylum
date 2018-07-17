/*
	File: fn_initCiv.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Initializes the civilian.
*/
private["_spawnPos","_marker","_house"];

[] spawn life_fnc_trackMarkers;

if (license_civ_bounty) then {
[player] remoteExecCall ["life_fnc_bountyFetch",2];
};

life_maxTalents = switch (life_configuration select 12) do {
	case 1:{29};
	case 2:{31};
	case 3:{33};
	case 4:{35};
	default{27};
};
life_maxGangTalents = 7;
life_maxWeight = 64;

// was ["Land_i_House_Big_01_V1_F","Land_i_House_Small_01_V2_F","Land_i_House_Small_03_V1_F"]
civ_spawn_1 = nearestObjects[getMarkerPos "civ_spawn_1", ["Land_i_Shop_01_V1_F","Land_i_Shop_02_V1_F","Land_i_Shop_01_V1_dam_F","Land_i_Shop_02_V1_dam_F","Land_i_Barracks_V1_F","Land_i_Barracks_V2_dam_F","Land_i_Barracks_V2_F","Land_i_Garage_V1_F"],100];
civ_spawn_2 = nearestObjects[getMarkerPos "civ_spawn_2", ["Land_i_Shop_01_V1_F","Land_i_Shop_02_V1_F","Land_i_Shop_01_V1_dam_F","Land_i_Shop_02_V1_dam_F","Land_i_Barracks_V1_F","Land_i_Barracks_V2_dam_F","Land_i_Barracks_V2_F","Land_i_Garage_V1_F"],100];
civ_spawn_3 = nearestObjects[getMarkerPos "civ_spawn_3", ["Land_i_Shop_01_V1_F","Land_i_Shop_02_V1_F","Land_i_Shop_01_V1_dam_F","Land_i_Shop_02_V1_dam_F","Land_i_Barracks_V1_F","Land_i_Barracks_V2_dam_F","Land_i_Barracks_V2_F","Land_i_Garage_V1_F"],100];
civ_spawn_4 = nearestObjects[getMarkerPos "civ_spawn_4", ["Land_i_Shop_01_V1_F","Land_i_Shop_02_V1_F","Land_i_Shop_01_V1_dam_F","Land_i_Shop_02_V1_dam_F","Land_i_Barracks_V1_F","Land_i_Barracks_V2_dam_F","Land_i_Barracks_V2_F","Land_i_Garage_V1_F"],100];
donor_town = nearestObjects[getMarkerPos "donor_town", ["Land_i_Shop_01_V1_F","Land_i_Shop_02_V1_F","Land_i_Shop_01_V1_dam_F","Land_i_Shop_02_V1_dam_F","Land_i_Barracks_V1_F","Land_i_Barracks_V2_dam_F","Land_i_Barracks_V2_F","Land_i_Garage_V1_F"],150];

if ((count life_houses) > 0) then
{
	{
		_house = _x;
		_numDoors = getNumber(configFile >> "CfgVehicles" >> (typeOf _house) >> "numberOfDoors");
		_house setVariable["life_locked", 1, true];
		_house setVariable["storageVisible",false, true];
		//_house setVariable["home_owner", getPlayerUID player, true];
		for "_i" from 1 to _numDoors do
		{
			_house setVariable[format["bis_disabled_Door_%1", _i], 1, true];
		};
		_id = [_x] call life_fnc_getBuildID;
		deleteMarkerLocal format["phouse_%1", _id];
		_marker = createMarkerLocal [format["phouse_%1", _id], getPos _house];
		_marker setMarkerTextLocal getText(configFile >> "CfgVehicles" >> (typeOf _house) >> "displayName");
		_marker setMarkerShapeLocal "ICON"; 
		_marker setMarkerColorLocal "ColorBlue";
		_marker setMarkerTypeLocal "mil_end";
	} forEach life_houses;
};

//Checks for non-combinable vars on init
if (life_adminlevel < 2) then {
if (license_civ_bounty && license_civ_rebel) then { missionNamespace setVariable["license_civ_bounty",false] };
if (126 in life_talents && 31 in life_talents) then { life_talents = life_talents - [126] };
if (count life_talents > life_maxTalents) then { life_talents resize life_maxTalents};
};
//Checks for talent prerequisites. DO NOT MODIFY
life_talentinfo sort true;
{
	if !((_x select 3) == 0) then {
		if ((_x select 0) in life_talents) then {
			if !((_x select 3) in life_talents) then { life_talents = life_talents - [_x select 0];};
		};
	};
}forEach life_talentInfo;

waitUntil {!(isNull (findDisplay 46))};

if(life_is_arrested) then
{
	life_is_arrested = false;
	[] spawn life_fnc_jail;
}
else
{
	if (life_alive) then
	{
		{
			if(life_worldspace distance getMarkerPos _x < 150) exitWith {
				_players = getMarkerPos _x nearEntities ["Man",150];
				{if(!isPlayer _x) then {_players = _players - [_x]}} forEach _players;
				if(count _players == 0) exitWith {};
				[[1,2],"A potentially hostile player has entered the world nearby!"] remoteExecCall ["life_fnc_broadcast",_players];
			};
		} forEach ["Rebelop_1","Rebelop_2","Rebelop_3","Rebelop_4","Rebelop_5"];
		player setPosATL life_worldspace;
		sleep 5;//We wait 5 seconds to let objects spawn in around them if they have a postion saved in DB
	}
	else
	{
		[0] call life_fnc_setPain;
		[false] call life_fnc_brokenLeg;
		[] call life_fnc_spawnMenu;
		waitUntil{!isNull (findDisplay 38500)}; //Wait for the spawn selection to be open.
		waitUntil{isNull (findDisplay 38500)}; //Wait for the spawn selection to be done.
	};
};
player addRating 9999999;

// Disallow 7.62 and guns in jail
[] spawn
{
	private ["_prev","_tal"];
	while {true} do
	{
		waitUntil { alive player && life_alive };
		_prev = primaryWeapon player;
		_tal = life_talents;
		if ((_prev in ["srifle_DMR_01_F","srifle_EBR_F","srifle_DMR_03_khaki_F","srifle_DMR_03_multicam_F","srifle_DMR_03_tan_F","srifle_DMR_03_woodland_F","srifle_DMR_06_olive_F","srifle_DMR_06_camo_F","arifle_SPAR_03_snd_F","arifle_SPAR_03_khk_F","arifle_AK12_F","arifle_AKM_F"]) && !(31 in life_talents)) then
		{
			_gwh = createVehicle ["GroundWeaponHolder", getPosATL player, [], 0, "CAN_COLLIDE"];
			_gwh addWeaponCargoGlobal [_prev, 1];
			{
				_gwh addItemCargoGlobal [_x, 1];
			}forEach (primaryWeaponItems player);
			player removeWeapon (primaryWeapon player);
			hint "You cannot carry a 7.62mm weapon without the Marksman Talent!";
		};
		if ((life_is_arrested && !life_laser_inprogress && _prev != "") || ((!license_civ_bounty || !(126 in life_talents) || count life_honortalents == 0) && _prev in["arifle_MX_F","arifle_MXC_F"])) then
		{
			_gwh = createVehicle ["GroundWeaponHolder", getPosATL player, [], 0, "CAN_COLLIDE"];
			_gItems = primaryWeaponItems player;
			player removeWeapon (primaryWeapon player);
			_gwh addWeaponCargoGlobal [_prev, 1];
			{
				_gwh addItemCargoGlobal [_x, 1];
			}forEach _gItems;
			hint "You cannot carry an MX without a BH License and the Master Bounty Hunter Talent!!";
		};
		if(_prev == "srifle_DMR_03_ARCO_F") then { player removeWeapon (primaryWeapon player); };
		waitUntil {sleep 10; _prev != (primaryWeapon player) || !(_tal isEqualTo life_talents) || ( _prev in["arifle_MX_F","arifle_MXC_F"] && !license_civ_bounty)};
	};
};

// Disallow CSAT and Carriers || PCs and Carryalls
if ((life_configuration select 12) < 3) then {
	[] spawn
	{
		private ["_uniform","_vest","_gwh","_bag"];
		while {true} do
		{
			waitUntil { alive player && life_alive };
			_uniform = uniform player;
			_vest = vest player;
			_bag = backPack player;
			if ({_uniform find _x >=0} count ["U_O_Pilot","U_O_Combat"] > 0) then 
			{
				if (_vest find "PlateCarrier" >= 0) then {
					_vItems = vestItems player;
					removeVest player;
					_gwh = createVehicle ["GroundWeaponHolder", getPosATL player, [], 0, "CAN_COLLIDE"];
					_gwh addItemCargoGlobal [_vest, 1];
					{
						(((everyContainer _gwh) select 0) select 1) addItemCargoGlobal [_x, 1];
					}forEach _vItems;
					_vest = "";
					hint "You cannot wear CSAT Uniforms and Plate Carriers at the same time!";
				};
				if (_bag find "Carryall" >= 0) then {
					if (_uniform find "U_O_Pilot" >=0) then {
						_bItems = backPackItems player;
						removeBackpack player;
						_gwh = createVehicle ["GroundWeaponHolder", getPosATL player, [], 0, "CAN_COLLIDE"];
						_gwh addBackpackCargoGlobal [_bag, 1];
						{
							(((everyContainer _gwh) select 0) select 1) addItemCargoGlobal [_x, 1];
						}forEach _bItems;
						_bag = "";
						hint "You cannot fit the Carryall Backpack over your CSAT Pilot Coveralls! The straps are too small!";
					};
				};
			};
			waitUntil {sleep 10; ((_uniform != uniform player || _vest != vest player || _bag != backPack player) && (typeName life_clothing_store != "STRING"))};
		};
	};
};

// Informants, etc.
[] spawn
{
	while {true} do
	{
		waitUntil {sleep 300; life_wanted > 1000};
		if (round (random 1) == 0) then
		{
			if ((player distance (getMarkerPos "city") < 250) || (player distance (getMarkerPos "donor_town") < 250) || (player distance (getMarkerPos "civ_spawn_2") < 250) || (player distance (getMarkerPos "civ_spawn_3") < 250) || (player distance (getMarkerPos "civ_spawn_4") < 250)) then
			{
["0",name player,6] remoteExecCall ["life_fnc_clientMessage",-2];
			}
			else
			{
				_marker = [allMapMarkers, player] call BIS_fnc_nearestPosition;
				if ((getMarkerColor _marker) in ["ColorRed","ColorEast"]) then
				{
					if (_marker find "_USER_DEFINED" == -1) then
					{ // Prevent manually placed markers from setting this off.
						if ((player distance2D (getMarkerPos _marker) < 300)) then
						{
["1",name player,6] remoteExecCall ["life_fnc_clientMessage",-2];
						}
					};
				};
			};
		};
	};
};

// Security Cams

if (worldName != "Tanoa") then
{
	[] spawn
	{
		private ["_chance"];
		while {true} do
		{
			_distance = 150;
			waitUntil {sleep 60; _lastRobbed = 0; _cops = 0; { if (side _x == west) then { _cops = _cops + 1; }; } forEach allPlayers; if (!isNil "life_bank_lastRobbed") then { _lastRobbed = life_bank_lastRobbed; }; (!life_bank_inProgress && (player distance (getMarkerPos "fed_reserve") < _distance) && (_lastRobbed < (time - 1800)) && _cops > 5)};
			_hidden = ((goggles player) in life_masks);
			_chance = 1;
			if (118 in life_talents) then { _chance = _chance + 1; };
			if (_hidden) then { _chance = _chance + 1; };
			_detected = ((floor random _chance) == 0);
			if (vehicle player != player) then { _detected = true };
			if (_detected && (life_inv_drill > 0 || life_inv_goldbar > 0 || life_inv_boltCutter > 0 || life_inv_demoCharge > 0)) then
			{
				_concealed = false;
				//{ if (player distance (getPos _x) < 25) then { _concealed = true; }; } forEach life_bank_vaults;
				if (!_concealed) then
				{
					hint "You have been spotted by the Federal Reserve Security and set off a security alarm! You, and any who are with you, are now wanted for bank robbery.";
[player] remoteExec ["ASY_fnc_fedAlarm",2];
				};
			};
		};
	};
};

// Reveal donor houses
/*if (worldName == "Altis") then
{
	[] spawn
	{
		private ["_h"];
		waitUntil {life_session_completed};
		sleep 3;
		_h = nearestObjects [(getMarkerPos "donor_town"), ["House_F"], 500];
		{ player reveal _x } forEach _h;
	};
};*/

//[24, player, format["Initialized as civilian"]] remoteExecCall ["ASY_fnc_logIt",2];
