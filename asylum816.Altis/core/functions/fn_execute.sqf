/*
	File: fn_execute.sqf
	Author: John "Paratus" VanderZwet

	Description:
	Execute an unconcious player.
*/

private _unit = cursorTarget;
params ["","","",["_harvest",false,[false]]];

_diff = ["manflesh",1,life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
if(_harvest && _diff <= 0) exitWith { hint "You don't have enough room to hold all of these organs!" };

if (time - (player getVariable ["organ", -10000]) < 3600) then { hint "You can only harvest organs once per hour!"; _harvest = false; };

if (isNull _unit) exitWith {};
if !(_unit isKindOf "Man") exitWith {};
if (alive _unit) exitWith {};
if ((currentWeapon player) in life_disallowedThreatWeapons) exitWith {};
if (player distance _unit > 2.5) exitWith {};

if (((player distance (getMarkerPos "city") < 1000) || (player distance (getMarkerPos "civ_spawn_3") < 500) || (player distance (getMarkerPos "civ_spawn_4") < 500) || (player distance (getMarkerPos "civ_spawn_2") < 500)) && !((player distance (getMarkerPos "execute_exempt_01") < 4) || (player distance (getMarkerPos "execute_exempt_02") < 5) || (player distance (getMarkerPos "execute_exempt_03") < 4) || (player distance (getMarkerPos "execute_exempt_04") < 3) || (player distance (getMarkerPos "bankMarker") < 250))) exitWith { hint "You cannot execute someone so close to a populated area." };

life_action_in_use = true; //Lockout the controls.
_targetName = _unit getVariable["name","Unknown"];

//Setup our progress bar
_success = false;
_title = format["Executing %1",_targetName];
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNamespace getVariable ["life_progress",displayNull];
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;

[player,"AinvPknlMstpSnonWnonDnon_medic1"] remoteExecCall ["life_fnc_animSync",-2];
systemChat _title;
for "_i" from 0 to 1 step 0 do {
	sleep 0.038;
	_cP = _cP + 0.01;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if (isNull _unit) exitWith {};
	if (alive _unit) exitWith {};
	if (player getVariable ["downed",false]) exitWith {};
	if (isWeaponDeployed player) exitWith {};
	if (player distance _unit > 3) exitWith {};
	if (_cP >= 1) exitWith{ _success = true; };
	if (!life_action_in_use) exitWith {};
};

if (_harvest && life_action_in_use) then
{
	_title = "Harvesting Organs";
	_titleText ctrlSetText format["%2 (1%1)...","%",_title];
	_progressBar progressSetPosition 0.01;
	_cP = 0.01;

[player,"AinvPknlMstpSnonWnonDnon_medic1"] remoteExecCall ["life_fnc_animSync",-2];
	for "_i" from 0 to 1 step 0 do {
		sleep 0.038;
		_cP = _cP + 0.01;
		_progressBar progressSetPosition _cP;
		_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
		if (isNull _unit) exitWith {};
		if (alive _unit) exitWith {};
		if (player getVariable ["downed",false]) exitWith {};
		if (isWeaponDeployed player) exitWith {};
		if (player distance _unit > 3) exitWith {};
		if (_cP >= 1) exitWith{ _success = true; };
		if (!life_action_in_use) exitWith {};
	};
};

5 cutText ["","PLAIN"];

life_action_in_use = false;
player playActionNow "stop";
if (!_success) exitWith {};

if (_harvest) then
{
	[[0,2], format["You EXECUTED %1 and harvested their healthy organs!", _targetName]] call life_fnc_broadcast;
	[true,"manflesh",1] call life_fnc_handleInv;
	[player,"exe"] remoteExec ["life_fnc_addWanted", 2];
	[player,"org"] remoteExec ["life_fnc_addWanted", 2];
[getPlayerUID player, "organ", time] remoteExecCall ["ASY_fnc_varPersist",2];
}
else
{
	[[0,2], format["You EXECUTED %1!", _targetName]] call life_fnc_broadcast;
	if (playerSide == civilian) then
	{
		[player,"exe"] remoteExec ["life_fnc_addWanted", 2];
	};
};

[] remoteExecCall ["life_fnc_doRespawn",_unit];
