/*
	File: fn_revivePlayer.sqf
	Author: Bryan "Tonic" Boardwine and Chronic [MIT]

	Description:
	Starts the revive process on the player.
*/
private["_target","_revivable","_targetName","_ui","_progressBar","_titleText","_cP","_title","_delay"];
_target = cursorTarget;
if(isNull _target) exitWith {};
_targetName = _target getVariable["name","Unknown"];
if(_targetName == "Unknown") exitWith {}; //Error: Who is getting revived? To prevent reviving the ground.
_defibFx = switch (life_configuration select 12) do {
    case 1:{.9};
    case 2:{.85};
    case 3:{.8};
    case 4:{.7};
    default {1};
};

if (isWeaponDeployed player) then { player playMove ""; };
if (vehicle player != player) exitWith { hint "You can't revive someone from within a vehicle." };

_revivable = _target getVariable["Revive",FALSE];
if(_revivable) exitWith {};
_revivableTime = _target getVariable["can_revive", -1000];
//if(_revivableTime > time) exitWith {hint format["This person has been revived too frequently. Their body can't handle it for another %1 minute(s).", ceil ((_revivableTime - time) / 60)]};
if(_target getVariable ["Reviving",player] != player) exitWith {hint "Someone else is already reviving this person"};
if(time - (_target getVariable ["last_revived",-1000]) < (300 * _defibFx) && !(playerSide == west && life_coprole in ["medic","all"] && (36 in life_coptalents) && (29 in life_coptalents) && (32 in life_coptalents) && (35 in life_coptalents) && life_coplevel > 3)) exitWith {hint format["The victim was recently revived and cannot be revived again for %1 seconds.",((_target getVariable ["last_revived",-1000]) + 300) - time];};
if(player distance _target > 4) exitWith {}; //Not close enough.
if(playerSide == civilian && (time - ((profileNameSpace getVariable["recent_revive",[0,0]])#1) < (300 * _defibFx))) exitWith {hint format["You have recently revived someone! Your defibulators need time to recharge! They should be ready in %1 seconds.",(((profileNameSpace getVariable["recent_revive",[0,0]])#1) + (300 * _defibFx)) - time];};
if(time - (player getVariable["last_revived",-1000]) < (120 * _defibFx)) exitWith {hint "You cannot revive someone within 2 minutes of being revived yourself."};

//Fetch their name so we can shout it.

_title = format["Reviving %1",_targetName];
life_action_in_use = true; //Lockout the controls.

_target setVariable["Reviving",player,TRUE];
//Setup our progress bar
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNamespace getVariable ["life_progress",displayNull];
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;

_delay = switch (true) do
{
	case (112 in life_talents): { 0.1; };
	case (playerSide == west && life_coprole in ["medic","all"] && (35 in life_coptalents)): { 0.0375 };
	case (playerSide == west && life_coprole in ["medic","all"] && (34 in life_coptalents)): { 0.075 };
	case (playerSide == west && ((life_coprole in ["medic","all"] && (33 in life_coptalents)) || (life_coprole in ["detective","all"] && (48 in life_coptalents)))): { 0.1125 };
	default { 0.15 };
};
_delay = _delay * _defibFx;

_continue = true;
[player,"AinvPknlMstpSnonWnonDr_medic0","playNow",4] remoteExecCall ["life_fnc_animSync",-2];
systemChat _title;
while {_cP < 1 && _continue} do
{
	sleep _delay;
	_cP = _cP + 0.01;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];

	if(!alive player) then {
		_continue = false;
	};
	if(life_isdowned) then {
		_continue = false;
	};
	if (!life_action_in_use) then {
		_continue = false;
	};
	if(player getVariable["restrained",false]) then {
		_continue = false;
	};
	if (isWeaponDeployed player) then {
	hint "You should probably have your hands on your patient to revive them!";
		_continue = false;
	};
	if(player distance _target > 4) then {
		hint "You moved too far from your patient!";
		_continue = false;
	};
	if(_target getVariable["Revive",FALSE]) then {
		hint "This person either respawned or was already revived.";
		_continue = false;
	};
	if(isNull(_target getVariable["Reviving",ObjNull])) then {
		hint "This person can no longer be saved!";
		_continue = false;
	};
	if(_target getVariable["Reviving",ObjNull] != player) then {
		hint "Someone else is already reviving this person";
		_continue = false;
	};
};
life_action_in_use = false;
[player,""] remoteExecCall ["life_fnc_animSync",-2];

//Kill the UI display and check for various states
5 cutText ["","PLAIN"];
player playActionNow "stop";


_target setVariable["Reviving",NIL,TRUE];


if(_continue) then {
	_target setVariable["Revive",TRUE,TRUE];
[player,false,false,(life_copRole in ["medic","all"])] remoteExecCall ["life_fnc_revived",_target];
	profileNameSpace setVariable["recent_revive",[life_instance_id,time]];

	if (_target isKindOf "Man") then
	{
		if (playerSide == west && life_coprole in ["all","medic","detective"]) then { [500] spawn life_fnc_earnPrestige; };
	}
	else
	{
		titleText[format["You have revived %1 but it wasn't carrying a wallet so you receive no payment.",getText(configFile >> "CfgVehicles" >> (typeOf _target) >> "displayName")],"PLAIN"];
	};

	if (111 in life_talents) then
	{
		life_thirst = 100;
		life_hunger = 100;
		[] call life_fnc_hudUpdate;
	};

	sleep 0.6;
	player reveal _target;
};
