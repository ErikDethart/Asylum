/*
	File: fn_receiveMoney.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Receives money
*/
private["_unit","_val","_from"];
_unit = [_this,0,Objnull,[Objnull]] call BIS_fnc_param;
_val = [_this,1,"",[""]] call BIS_fnc_param;
_from = [_this,2,Objnull,[Objnull]] call BIS_fnc_param;
if(isNull _unit OR isNull _from OR _val == "") exitWith {};
if(player != _unit) exitWith {};
if(!([_val] call life_fnc_isnumber)) exitWith {};

hint format["%1 has given you $%2",[name _from] call life_fnc_cleanName,[(parseNumber (_val))] call life_fnc_numberText];
["cash","add",parseNumber(_val)] call life_fnc_updateMoney;

[59, player, format["Given $%1 from %2 (%3)", _val, name _from, getPlayerUID _from]] remoteExecCall ["ASY_fnc_logIt",2];


_time = (_from getVariable ["drugtrace",-1000]);
if (time - _time < 400) then {
	systemChat "Druggies!";
[getPlayerUID player, "drugtrace", _time] remoteExecCall ["ASY_fnc_varPersist",2];
	[_time] spawn {
		_time = _this select 0;
		waitUntil {sleep 1; (life_money == 0) || ((time - _time) > 400)};
		if (life_money == 0) then {[getPlayerUID player, "drugtrace", -1000] remoteExecCall ["ASY_fnc_varPersist",2];};
	};
};
