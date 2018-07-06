/*
	File: fn_virt_sell.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Sell a virtual item to the store / shop
*/
private["_type","_index","_price","_var","_amount","_name"];
if((lbCurSel 2402) == -1) exitWith {};
_type = lbData[2402,(lbCurSel 2402)];
_index = [_type,buy_array] call life_fnc_index;
if(_index == -1) exitWith {};
_price = (buy_array select _index) select 1;
_qty = _type call life_fnc_getQuantity;
_price = [_type,_price,_qty,false] call life_fnc_calcPrice;
_price = round _price;
_var = [_type,0] call life_fnc_varHandle;

if (_type in ["goldbar","dirty_money"] && player distance (getMarkerPos "Rebelop_1") > 200 && player distance (getMarkerPos "Rebelop_2") > 200 && player distance (getMarkerPos "Rebelop_3") > 200 && player distance (getMarkerPos "Rebelop_4") > 200 && player distance (getMarkerPos "Rebelop_5") > 200) exitWith {hint "You cannot sell this here!"};
if !(isNil "life_restartLock") exitWith {hint "You cannot access this menu right now. Try again after the restart!"};

_amount = ctrlText 2405;
if(!([_amount] call life_fnc_isnumber)) exitWith {hint "You didn't enter an actual number";};
_amount = parseNumber (_amount);
if(_amount > (missionNameSpace getVariable _var)) exitWith {hint "You don't have that many items to sell!"};
if(time - life_last_sold < 1) exitWith {hint "You cannot rapidly sell items!"};

_price = (_price * _amount);
_name = [_var] call life_fnc_vartostr;
if(([false,_type,_amount] call life_fnc_handleInv)) then
{
	// Wong item sale
	_extra = ".";
	if (life_shop_type == "wongs") then
	{
		_cut = 0;
		if ((life_capture_list select 3) select 2 != 1 || ((life_capture_list select 3) select 1 != life_gang || life_gang == "0")) then
		{
			_cut = floor (_price * 0.08); // 8% cut to Wong
			_var = capture_container_4 getVariable ["gangContainer", ["life_inv_dirty_money",0]];
			_newAmount = (_var select 1) + _cut;
			if (_newAmount > 100000) then { _newAmount = 100000; };
			_var set [1, _newAmount];
			capture_container_4 setVariable ["gangContainer", _var, true];
			_extra = format[", after a $%1 cut by the Wong triad.", [_cut] call life_fnc_numberText];
			_price = _price - _cut;
		};
	};
	
	if (life_shop_type in ["wongs","heroin"]) then
	{
[getPlayerUID player, "drugtrace", time] remoteExecCall ["ASY_fnc_varPersist",2];
		[time] spawn {
			_time = _this select 0;
			waitUntil {sleep 1; (life_money == 0) || ((time - _time) > 400)};
			if (life_money == 0) then {[getPlayerUID player, "drugtrace", -1000] remoteExecCall ["ASY_fnc_varPersist",2];};
		};
		if (4 in life_gangtalents) then { _price = _price * 1.05 };
		if (life_shop_type == "heroin" && 5 in life_gangtalents) then { _price = _price * 1.05 };
		if (life_shop_type == "wongs" && 6 in life_gangtalents) then { _price = _price * 1.05 };
		if (_type == "goldbar" && (life_gang == ((life_turf_list #1)#1))) then { _price = _price * 1.1 };
	};
	
	hint format["You sold %1 %2 for $%3%4",_amount,_name,[_price] call life_fnc_numberText,_extra];
	
	_itemWeight = ([_type] call life_fnc_itemWeight) * _amount;
	if (_itemWeight > 96) exitWith {[911, player, format["ITEM SALE HACK - BAN! (%1 %2)",_amount, _name]] remoteExecCall ["ASY_fnc_logIt",2];};
	
	["cash","add",_price] call life_fnc_updateMoney;
	
	_logItems = [
		"dirty_money",
		"storage1", 
		"storage2",
		"diamondf",
		"meth",
		"crankp",
		"treasure",
		"scotch_3",
		"dogp",
		"manfleshp",
		"cocainepure",
		"goldbar",
		"heroinp",
		"cocainep",
		"marijuana",
		"marijuanam",
		"whiskeyc_3",
		"whiskeyr_3",
		"sugar",
		"sugarcane",
		"gingerale_3",
		"rum_3",
		"turtlesoup",
		"turtle",
		"salt_r",
		"diamondc",
		"doubloon",
		"silverpiece",
		"ruby",
		"pearl",
		"adrenalineShot",
		"goatp",
		"sheepp",
		"chickenp",
		"timber",
		"timberl",
		"timberh",
		"plank",
		"plankl",
		"plankh",
		"rabbitp",
		"snakep",
		"pcp",
		"oilp",
		"rubber",
		"blindfold"
	];
	
	if (_type in _logItems) then {[93, player, format["Sold %1 %2 for $%3 on Server: %4", _amount, _name,_price, life_server_instance ]] remoteExecCall ["ASY_fnc_logIt",2]; };

	if (_qty > -1) then
	{
		_index = [_type, life_price_index] call life_fnc_index;
		life_price_index set [_index, [(life_price_index select _index) select 0,((life_price_index select _index) select 1) + _amount]];
		life_stock_update = [_type, _amount, player];
		publicVariableServer "life_stock_update";
	};
	[] call life_fnc_virt_update;
	life_last_sold = time;
	
};
