/*
	File: fn_receiveItem.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Receive an item from a player.
*/
private["_unit","_val","_item","_from","_diff"];
_unit = _this select 0;
if(_unit != player) exitWith {};
_val = _this select 1;
_item = _this select 2;
_from = _this select 3;

_diff = [_item,(parseNumber _val),life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;

if(_diff != (parseNumber _val)) then
{
	if(([true,_item,_diff] call life_fnc_handleInv)) then
	{
		hint format["%1 has gave you %2 but you can only hold %3 so %4 was returned back.",[name _from] call life_fnc_cleanName,_val,_diff,((parseNumber _val) - _diff)];
[_from,_item,str((parseNumber _val) - _diff),_unit] remoteExecCall ["life_fnc_giveDiff",_from];
//[61, player, format["Given %1 from %2 but only had room for %3", _val, name _from, _diff]] remoteExecCall ["ASY_fnc_logIt",2];
	}
		else
	{
[_from,_item,_val,_unit,false] remoteExecCall ["life_fnc_giveDiff",_from];
	};
}
	else
{
	if(([true,_item,(parseNumber _val)] call life_fnc_handleInv)) then
	{
		private["_type"];
		_type = [_item,0] call life_fnc_varHandle;
		_type = [_type] call life_fnc_varToStr;
		hint format["%1 has gave you %2 %3",[name _from] call life_fnc_cleanName,_val,_type];
		if (_item == "bank_money") then {
			_time = (_from getVariable ["banktrace",-1000]);
			if (time - _time < 400) then {
[getPlayerUID player, "banktrace", _time] remoteExecCall ["ASY_fnc_varPersist",2];
			};
		};
//[60, player, format["Given %1 %2 from %3", _val, _type, name _from]] remoteExecCall ["ASY_fnc_logIt",2];
	}
		else
	{
[_from,_item,_val,_unit,false] remoteExecCall ["life_fnc_giveDiff",_from];
	};
};
