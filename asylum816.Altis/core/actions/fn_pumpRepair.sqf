/*
	File: fn_pumpRepair.sqf
	
	Author: Gnashes
	
	Description: Quick simple action that is only temp.
*/

_veh = vehicle player;
if (_veh == player) exitWith {};

_source = "cash";
_success = false;

if (life_money < 50 && life_atmmoney < 50) exitWith { hint "You do not have $50 in cash or in your bank account." };
if (life_money < 50) then { _source = "atm" };

if((_veh isKindOf "Car") || (_veh isKindOf "Ship") || (_veh isKindOf "Air")) then
{
	_delay = 0.15;
	_displayName = getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "displayName");
	_upp = format["Repairing %1",_displayName];
	disableSerialization;
	5 cutRsc ["life_progress","PLAIN"];
	_ui = uiNameSpace getVariable "life_progress";
	_progress = _ui displayCtrl 38201;
	_pgText = _ui displayCtrl 38202;
	_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
	_progress progressSetPosition 0.01;
	_cP = 0.01;
	_started = getPosASL _veh;
	
	if (life_action_in_use) exitWith { systemChat "You are already performing an action." };
	life_action_in_use = true;
	
	while {true} do
	{
		sleep _delay;
		_cP = _cP + 0.01;
		_progress progressSetPosition _cP;
		_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
		if(_cP >= 1) exitWith {_success = true};
		if(!alive player) exitWith {};
		if(player == vehicle player) exitWith {};
		if(_veh distance2D _started > 5 || speed _veh > 5) exitWith {};
		if(player getVariable ["downed",false]) exitWith {};
		if (!life_action_in_use) exitWith {};
	};
	
	5 cutText ["","PLAIN"];
	life_action_in_use = false;
};
		
if (!_success) exitWith { hint "The repair has been interrupted and failed. Stay still next time!" };


_veh setDamage 0;
[_source,"take",50] call life_fnc_updateMoney;
hint "Your vehicle has been repaired for a fee of $50.";
