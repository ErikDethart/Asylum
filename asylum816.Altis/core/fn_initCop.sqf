 /*
	File: fn_initCop.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Cop Initialization file.
*/

life_maxTalents = switch (life_configuration select 12) do {
	case 1:{21};
	case 2:{22};
	case 3:{23};
	case 4:{24};
	default{20};
};
if (life_coplevel > 2) then { life_maxTalents = life_maxTalents + (2 * (life_coplevel - 2)); };

player addRating 9999999;
waitUntil {!(isNull (findDisplay 46))};
[] spawn life_fnc_trackMarkers;

if(life_blacklisted) exitWith
{
	["NotWhitelisted",false,false] call BIS_fnc_endMission;
};

life_track_radius = switch (true) do
{
	case (8 in life_coptalents): { 200 };
	case (7 in life_coptalents): { 300 };
	case (6 in life_coptalents): { 400 };
	case (5 in life_coptalents): { 500 };
	case (4 in life_coptalents): { 800 };
	case (3 in life_coptalents): { 900 };
	case (2 in life_coptalents): { 1000 };
	default { 1400 };
};

life_maxWeight = 90;

switch (true) do
{
	case (str(player) == "Swat_comm"):
	{
		if(life_swatlevel == 3) then {
			player setVariable["swatlevel", 3, true]; // for showing rank, etc
		} else {
			endMission "Loser";
		};
	};

	case (str(player) in ["Swat_rifle","Swat_supp","Swat_med"]):
	{
		_found = false; { if (str _x == "Swat_comm") then { _found = true; }; } foreach allPlayers;
		if((_found && life_swatlevel >= 1) || life_swatlevel == 3) then {
			player setVariable["swatlevel", 1, true]; // for showing rank, etc
		} else {
			["NotWhitelisted",false,false] call BIS_fnc_endMission;
		};
	};

	case (str(player) == "Swat_mark"):
	{
		_found = false; { if (str _x == "Swat_comm") then { _found = true; }; } foreach allPlayers;
		if((_found && life_swatlevel >= 2) || life_swatlevel == 3) then {
			player setVariable["swatlevel", 2, true]; // for showing rank, etc
		} else {
			["NotWhitelisted",false,false] call BIS_fnc_endMission;
		};
	};

	default
	{
		switch (true) do
		{
			case (life_coplevel > 0) : {}; // Do nothing
			//case (life_adminlevel > 1) : {}; //Do nothing
			default {["NotWhitelisted",false,false] call BIS_fnc_endMission;};
		};
	};
};

if ((str(player) in ["cop_warrant_1","cop_warrant_2","cop_warrant_3","cop_warrant_4","cop_warrant_5","cop_drug_1","cop_drug_2","cop_drug_3","cop_drug_4","cop_medic_1","cop_medic_2","cop_medic_3","cop_medic_4","cop_detective_1","cop_detective_2","cop_detective_3","cop_detective_4"]) && (life_coplevel < 3 || !life_precinct)) then
{
	["NotWhitelisted",false,false] call BIS_fnc_endMission;
};

player setVariable["copLevel", life_coplevel, true]; // for showing rank, etc
if (life_coplevel > 4) then {player setVariable["LT+", true, true]}; //For handleDamage and things
//if(life_coplevel > 2) then {player setVariable ["swatlevel",1,true]};
//[25, player, format["Initialized as cop of rank %1", life_coplevel]] remoteExecCall ["ASY_fnc_logIt",2];

if (count life_talents > life_maxTalents && life_adminlevel < 2) then { life_talents resize life_maxTalents};

//Checks for talent prerequisites. DO NOT MODIFY
life_talentinfo sort true;
{
	if !((_x select 3) == 0) then {
		if ((_x select 0) in life_talents) then {
			if !((_x select 3) in life_talents) then { life_talents = life_talents - [_x select 0];};
		};
	};
}forEach life_talentInfo;

//Thread to monitor coprole
/*
if ((life_adminlevel < 3) && (life_coplevel < 6)) then {
	[]spawn {
		while {true} do {
			_role = life_coprole;
			switch (_role) do {
				case "warrant":{if !((str(player) in ["cop_warrant_1","cop_warrant_2","cop_warrant_3","cop_warrant_4","cop_warrant_5")) then {life_coprole = ""}};
				case "detective":{if !((str player) in ["cop_detective_1","cop_detective_2","cop_detective_3"]) then {life_coprole = ""};};
				default {};
			};
		waitUntil {sleep 30; (life_coprole != _role)};
		};
	};
};
*/

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
						_gwh addBackpackCargoGlobal  [_bag, 1];
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

[] call life_fnc_spawnMenu;
waitUntil{!isNull (findDisplay 38500)}; //Wait for the spawn selection to be open.
waitUntil{isNull (findDisplay 38500)}; //Wait for the spawn selection to be done.

[] call life_fnc_equipGear;
