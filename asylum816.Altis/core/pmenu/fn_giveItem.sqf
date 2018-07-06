/*
	File: fn_giveItem.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Gives the selected item & amount to the selected player and
	removes the item & amount of it from the players virtual
	inventory.
*/
private["_unit","_val"];
_val = ctrlText 2010;
ctrlShow[2002,false];
if((lbCurSel 2023) == -1) exitWith {hint "No one was selected!";ctrlShow[2002,true];};
_unit = lbData [2023,lbCurSel 2023];
_unit = call compile format["%1",_unit];
if((lbCurSel 2005) == -1) exitWith {hint "You didn't select an item you wanted to give.";ctrlShow[2002,true];};
_item = lbData [2005,(lbCurSel 2005)];
if(_item == "") exitWith {ctrlShow[2002,true];};
if(isNil "_unit") exitWith {ctrlShow[2002,true];};
if(_unit == player) exitWith {ctrlShow[2002,true];};
if(isNull _unit) exitWith {ctrlShow[2002,true];};

//A series of checks *ugh*
if(life_is_processing && life_action_in_use) exitWith {hint "You cannot give items while processing";};
if (player getVariable ["restrained",false]) exitWith {hint "Your hands are bound, how can you possibly give that person anything?"};
if(lineIntersects[eyePos player, aimPos _unit,vehicle player,_unit]) exitWith {hint "It would be hard to pass things through the wall, don't you think?"};
if(!([_val] call life_fnc_isnumber)) exitWith {hint "You didn't enter an actual number format.";ctrlShow[2002,true];};
if(parseNumber(_val) <= 0) exitWith {hint "You need to enter an actual amount you want to give.";ctrlShow[2002,true];};
if(isNil "_unit") exitWith {ctrlShow[2001,true]; hint "The selected player is not within range";};
if (_item == "dirty_money" && (parseNumber _val) < life_inv_dirty_money) exitWith { hint "Dirty money can only be traded when transferring the full amount!"; ctrlShow[2002,true]; };
if (_item in ["goldbar","debitcard"]) exitWith {hint "You can't trade this item!";ctrlShow[2002,true];};
if(!([false,_item,(parseNumber _val)] call life_fnc_handleInv)) exitWith {hint "Couldn't give that much of that item, maybe you don't have that amount?";ctrlShow[2002,true];};
if !(isNil "life_restartLock") exitWith {hint "You cannot perform this action right now. Try again after the restart!"};
[_unit,_val,_item,player] remoteExecCall ["life_fnc_receiveItem",_unit];
_type = [_item,0] call life_fnc_varHandle;
_type = [_type] call life_fnc_varToStr;
hint format["You gave %1 %2 %3",[name _unit] call life_fnc_cleanName,_val,_type];
//[false] spawn life_fnc_inventory;
_display = if (_isPhone) then { findDisplay 2001 } else { findDisplay 602 };
_inv = _display displayCtrl 2005;
lbClear _inv;

if (life_lootKeys select 0 > 0) then
{
	_inv lbAdd format["%1x - %2",life_lootKeys select 0,"Loot Crate Keys"];
	_inv lbSetData [(lbSize _inv)-1,""];
};
if (life_lootKeys select 1 > 0) then
{
	_inv lbAdd format["%1x - %2",life_lootKeys select 1,"Guardian Crate Keys"];
	_inv lbSetData [(lbSize _inv)-1,""];
};
if (life_lootKeys select 2 > 0) then
{
	_inv lbAdd format["%1x - %2",life_lootKeys select 2,"Aggressor Crate Keys"];
	_inv lbSetData [(lbSize _inv)-1,""];
};

{
	_str = [_x] call life_fnc_varToStr;
	_shrt = [_x,1] call life_fnc_varHandle;
	_val = missionNameSpace getVariable _x;
	if(_val > 0) then
	{
		_inv lbAdd format["%1x - %2",_val,_str];
		_inv lbSetData [(lbSize _inv)-1,_shrt];
		_inv lbSetPicture [(lbSize _inv)-1,format["icons\%1.paa",_shrt]];
	};
} foreach life_inv_items;
profileNameSpace setVariable["asy_dedup",[life_instance_id,time]];

ctrlShow[2002,true];
