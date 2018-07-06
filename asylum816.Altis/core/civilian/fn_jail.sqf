/*
	File: fn_jail.sqf
	Author: Bryan "Tonic" Boardwine & John "Paratus" VanderZwet
	
	Description:
	Starts the initial process of jailing.
*/
private ["_jail","_jailSpawn","_jailRelease"];
_admin = [_this,0,false,[false]] call BIS_fnc_param;
_isSkiptracer = [_this,1,false,[false]] call BIS_fnc_param;
_isInterrogate = [_this,2,false,[false]] call BIS_fnc_param;
_guy = [_this,3,objNull,[objNull]] call BIS_fnc_param;

if(life_is_arrested) exitWith {}; //Already arrested
player setVariable["restrained",nil,true];
player setVariable["Escorting",nil,true];
player setVariable["transporting",nil,true];
//[player,false] remoteExecCall ["life_fnc_setRestrained",2];
life_disable_actions = false;

if(_isSkiptracer) then {
	if(isNull _guy) exitWith {};
	_value = life_wanted;
	if (_value > life_arrest_cap) then {_value = life_arrest_cap};
	_bonus = (_value / 2);
	if(_value + _bonus > 200000) then {_bonus = 200000 - _value};
	if(_value < 0) then {_value = 0};
	[_bonus,_bonus] remoteExecCall ["life_fnc_bountyReceive",_guy];
} else {
	if(_isInterrogate) then {
		_weaponHolder = createVehicle["WeaponHolderSimulated",getPosATL player,[],0,"CAN_COLLIDE"];
		{_weaponHolder addItemCargoGlobal [_x,1]} forEach (primaryWeaponItems player + [primaryWeapon player] + handgunItems player + [handgunWeapon player] + uniformItems player + vestItems player + backPackitems player + [uniform player] + [vest player] + [backpack player]);
		was_interrogated = true;
		removeAllContainers player;
	};
};

if(_admin) then {
	titleText[format["The admin %1 has jailed you as punishment. Consider reading the rules at gaming-asylum.com/forums.",param[1]],"PLAIN"];
} else {
	titleText["You have been arrested! You can wait your time out, pay your full bail, or process plates to reduce your bail.","PLAIN"];
};
systemChat "For being arrested you have lost the following licenses if you own them: Firearms License";

_jailSpawn = "jail_marker2";
_jailRelease = "jail_release2";

_jailPos = if (isNil (format["%1_notepad",_jailSpawn])) then { getMarkerPos _jailSpawn } else { getPosATL (missionNamespace getVariable format["%1_notepad",_jailSpawn]) };

if (isWeaponDeployed player) then { player playMove ""; };

player setPosATL _jailPos;

//Check to make sure they goto check
if(player distance _jailPos > 74) then
{
	player setPosATL _jailPos;
};

license_civ_gun = false;
license_civ_bounty = false;
{
	_x params ["_item","_value"];
	_num = missionNamespace getVariable([_item,0] call life_fnc_varHandle);
	if (_num > 0) then {[false,_item,_num] call life_fnc_handleInv};
} forEach life_illegal_items;

life_is_arrested = true;
player setVariable ["arrested", true, true];
removeAllWeapons player;
{player removeMagazine _x} foreach (magazines player);
if (uniform player in ["U_Competitor","U_Rangemaster","U_B_CombatUniform_mcam_worn","U_I_CombatUniform_shortsleeve"]) then {removeUniform player;};
if (vest player in ["V_HarnessOGL_brn","V_TacVest_blk_POLICE"]) then {removeVest player;};
if (headgear player in ["H_CrewHelmetHeli_B", "H_Cap_police"]) then {removeHeadgear player;};
player switchMove "AmovPercMstpSnonWnonDnon";
player playMoveNow "AmovPercMstpSnonWnonDnon";

_side = if (_admin) then {"ADMIN"} else {side _guy};
if !(isNull _guy) then {
[199, _guy, format["%1(%3) arrested %2(%4) with a bounty of $%5", name _guy, profileName, _side,getPlayerUID player, [life_wanted] call life_fnc_numberText]] remoteExecCall ["ASY_fnc_logIt",2];
};
[player,_jailSpawn,_jailRelease] remoteExecCall ["life_fnc_jailSys",2];
[] call life_fnc_sessionUpdate;
[getPlayerUID player] remoteExecCall ["life_fnc_removeBounty",-2];
