/*
	File: fn_buyHouse.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Purchases a house and initiates DB entry
*/
private["_house", "_buildingID", "_buildingName", "_owners", "_isLocked", "_uid", "_price"];
if (life_corruptData) exitWith { hint "YOUR PLAYER DATA IS DAMAGED. You must log out to the lobby and rejoin. Your progress will not save until you do this. Most likely caused by a script-kiddie." };

if !(isNil "life_restartLock") exitWith {hint "You cannot buy this item right now. Try again later!"};
//if (life_server_instance isEqualTo 2) exitWith {hint "House purchases are disabled on this server! This server will be removed on April 1st, 2018"};

_house = life_menu_house;
_maxHouses = switch (worldName) do
{
	case "Altis": { 5 };
	case "Tanoa": { 2 };
	default { 1 };
};

if (player distance _house > 20) exitWith {};
if (!(_house isKindOf "House")) exitWith {};

_uid = getPlayerUID player;
_price = [typeOf _house] call life_fnc_housePrice;
_buildingID = [_house] call life_fnc_getBuildID;
_buildingName = getText(configFile >> "CfgVehicles" >> (typeOf _house) >> "displayName");

_salePrice = _house getVariable ["salePrice", 0];
_saleOwner = _house getVariable ["saleOwner", ""];
if (_saleOwner == "") then {_salePrice = 0}; //prevent bugged sale houses from taking money and giving it to nobody
if  (_salePrice > 0) then { _price = _salePrice; };

if (!license_civ_home) exitWith {hint "You do not have a home owners license!";};
if ((life_gangHouse select 0) in life_ownHouses) then {_maxHouses = _maxHouses + 1};
if (count life_ownHouses >= _maxHouses) exitWith {hint format["You may only own %1 houses (excluding your Ganghouse) at one time.",_maxHouses];};
if (_price < 0 || _buildingID in life_public_houses) exitWith{hint "This building is not for sale";};
if (life_atmmoney < _price) exitWith {hint format["You do not have $%1 in your bank to purchase %2",[_price] call life_fnc_numberText,_buildingName];};
//if ((_house getVariable['life_houseId',-1]) > -1 && life_donator < 5) exitWith{ hint "This house is available to rank 5 donors only."; };

["atm","take",_price] call life_fnc_updateMoney;
titleText[format["You have purchased %1 for $%2!", _buildingName, [_price] call life_fnc_numberText],"PLAIN"];

if  (_salePrice > 0) then
{
	_house setVariable ["salePrice", nil, true];
	_house setVariable ["saleOwner", nil, true];
	life_forSaleHouses = life_forSaleHouses - [getpos _house];
	publicVariable "life_forSaleHouses";
	_online = {if(getPlayerUID _x == _saleOwner) exitWith {_x}; ObjNull} forEach allPlayers;
	if(!isNull _online) exitWith {
["atm","add",_price] remoteExecCall ["life_fnc_updateMoney",_online];
		[[0,2],format["A house (%1) you have listed has sold, and %2 has been added to your bank!",_buildingName,[_price] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",_online];
	};
//[_saleOwner, player, format["You've sold a house (%1) and $%2 has been added to your bank account!", _buildingName, _price], _price] remoteExecCall ["ASY_fnc_addMessage",2];
[_saleOwner,_price] remoteExecCall ["KBW_fnc_offlineComp",2];
};

//If crates were shown when the house was purchased, delete them!
_containers = (getPos _house) nearEntities[["Box_East_Support_F","Box_East_WpsSpecial_F","Land_WaterBarrel_F"],30];
if (count _containers > 0) then {
	{
		if (_x getVariable["house",""] == _house) then {
				[_x, player] remoteExecCall ["ASY_fnc_removeStorage",2];
			};
	} forEach _containers;
};

if (_salePrice == 0) then {
[597, player, format["Purchased house %1 for $%2 on Server: %3", _buildingID, _price, life_server_instance]] remoteExecCall ["ASY_fnc_logIt",2];
} else {
[595, player, format["Purchased house %1 for $%2 on Server: %3 - House was listed by (%4)", _buildingID, _price, life_server_instance,_saleOwner]] remoteExecCall ["ASY_fnc_logIt",2];
};
closeDialog 0;

[_buildingID, _uid, 0, position _house] remoteExecCall ["DB_fnc_insertHouse",2];
life_houses set [count life_houses, _house];
life_ownHouses set [count life_ownHouses, _house];
life_experience = life_experience + 50;
