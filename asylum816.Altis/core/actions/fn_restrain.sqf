/*
	File: fn_restrain.sqf
	Author: Skalicon
	
	Description:
	Retrains the target.
*/
private["_unit"];
_unit = cursorTarget;
if((_unit getVariable ["restrained",false])) exitWith {};
if((_unit getVariable ["Escorting",false])) exitWith {};
if((player getVariable ["playerSurrender",false]) || (player getVariable ["restrained",false])) exitWith {hint "How could you possibly restrain someone right now?"};
if(isNull _unit) exitWith {};
if(player == _unit) exitWith {};
if (vehicle player != player) exitWith {};
if (player distance (getMarkerPos "courtroom") < 50) exitWith {};

_restrainSound = "handcuffs";
if (side player != west) then {
	if(life_inv_ziptie < 1) exitWith {hint"You need a zip tie to restrain someone."};
	if(!([false,"ziptie",1] call life_fnc_handleInv)) exitWith {};
	if (!((getPlayerUID _unit) in life_bounty_uid) && group _unit != group player) then
	{

		_exit =
		{
			if(getPlayerUID _unit in (_x getVariable["myBounties",[]])) exitWith {true}; false
		} forEach (units group player - [player]);
		if(!isNil "_exit" && {_exit} && {126 in life_talents}) exitWith {};
		[player,"209"] remoteExec ["life_fnc_addWanted", 2];
	};
	_restrainSound = "ziptie";
};

[_unit, _restrainSound ,10] remoteExecCall ["life_fnc_playSound",-2];
[player,_unit] remoteExec ["life_fnc_restrainAction",_unit];
