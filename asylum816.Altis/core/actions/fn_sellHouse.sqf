/*
	File: fn_sellHouse.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Sell a house and initiates DB removal
*/
private["_house", "_buildingID", "_buildingName", "_val", "_bankSale", "_uid", "_price"];

_bankSale = [_this,0,true,[true]] call BIS_fnc_param;
_house = life_menu_house;

if (player distance _house > 20) exitWith {};
if (!(_house isKindOf "House")) exitWith {};

_uid = getPlayerUID player;
_price = [typeOf _house] call life_fnc_housePrice;
_buildingID = [_house] call life_fnc_getBuildID;
_buildingName = getText(configFile >> "CfgVehicles" >> (typeOf _house) >> "displayName");
_price = _price * 0.75; // 75% of buy price for sale
_salePrice = _house getVariable ["salePrice", 0];

if (_salePrice > 0) then {systemChat "If you wish to remove this house from the market; you may do so by listing it for $0."};

if (!(_house in life_ownHouses)) exitWith {hint "You do not own this property!";};
if !(isNil "life_restartLock") exitWith {hint "You cannot perform this action right now. Try again after the restart!"};

if (_bankSale) then
{
	["atm","add",_price] call life_fnc_updateMoney;
	titleText[format["You have sold %1 for $%2!", _buildingName, [_price] call life_fnc_numberText],"PLAIN"];
	
	deleteMarkerLocal format["phouse_%1", _buildingID];
	life_houses = life_houses - [_house];
	life_ownHouses = life_ownHouses - [_house];
	[_buildingID, _house] remoteExecCall ["DB_fnc_deleteHouse",2];
	[_buildingID] remoteExecCall ["life_fnc_gangDisbanded",civilian];
	[598, player, format["Sold house %1 for $%2 on Server: %3", _buildingID, _price, life_server_instance]] remoteExecCall ["ASY_fnc_logIt",2];
	if  (_salePrice > 0) then
	{
		_house setVariable ["salePrice", nil, true];
		_house setVariable ["saleOwner", nil, true];
		life_forSaleHouses = life_forSaleHouses - [getpos _house];
		publicVariable "life_forSaleHouses";
	};
}
else
{
	_val = parseNumber(ctrlText 7702);
	if(_val > 999999) exitWith {hint "You can't list for more then $999,999";};
	if(_val < 0) exitwith {};
	if((_val != 0) && (_val < [typeOf _house] call life_fnc_housePrice)) exitWith {hint "You cannot list this house for less than it's worth!"};
	if(!([str(_val)] call life_fnc_isnumber)) exitWith {hint "Enter only numbers, no other characters, for the list price."};\
	if (_val > 0) then {
		titleText[format["You have listed %1 on the market for $%2!", _buildingName, [_val] call life_fnc_numberText],"PLAIN"];
		life_forSaleHouses pushBackUnique getpos _house;
		[_buildingID, player] remoteExecCall ["life_fnc_gangDisbanded",civilian];
	} else {
		titleText[format["You have removed %1 from the market!", _buildingName, [_val] call life_fnc_numberText],"PLAIN"];
		_index = life_forSaleHouses findIf {_x isEqualTo (getpos _house)};
		life_forSaleHouses deleteAt _index;
	};
	[_buildingID, _house, _val] remoteExecCall ["KBW_fnc_listHouse",2];
	publicVariable "life_forSaleHouses";
	_house setVariable["salePrice",_val,true];
	[599, player, format["Listed house %1 for $%2 on Server: %3", _buildingID, _val, life_server_instance]] remoteExecCall ["ASY_fnc_logIt",2];
};

closeDialog 0;
closeDialog 0;