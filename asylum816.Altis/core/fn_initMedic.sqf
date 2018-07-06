/*
	File: fn_initMedic.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Initializes the medic..
*/
private["_end"];
life_maxTalents = 9;
life_maxWeight = 80;
player addRating 99999999;
if(life_blacklisted) exitWith
{
	["NotWhitelisted",false,false] call BIS_fnc_endMission;
};
waitUntil {!(isNull (findDisplay 46))};

[] spawn life_fnc_medicMarkers;
[] call life_fnc_medicLoadout;

[] spawn
{
	while {true} do
	{
		waitUntil {sleep 3; !(currentWeapon player in life_disallowedThreatWeapons)};
		removeAllWeapons player;
	};
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

[] call life_fnc_spawnMenu;
waitUntil{!isNull (findDisplay 38500)}; //Wait for the spawn selection to be open.
waitUntil{isNull (findDisplay 38500)}; //Wait for the spawn selection to be done.