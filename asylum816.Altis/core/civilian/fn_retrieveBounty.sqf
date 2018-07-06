/*
	File: fn_retrieveBounty.sqf
	Author: Gnashes
	
	Description:
	Retrieves bounty data for player and re-adds targets if necessary.
*/
private ["_bounty"];

_list = [_this,0,[],[[]]] call BIS_fnc_param;

life_bounty_list = _list;

if ((count life_bounty_list) > 0) then {
	{
[player,nil,nil,nil,_x select 0] remoteExecCall ["life_fnc_wantedGetBounty",2]; 
	} forEach life_bounty_list;
	life_last_bounty = [0,time]; //Set retrack to 5 minutes if they refresh old bounties
	["BountyUpdate",[format["Welcome back to %1, %2. Your previous bounty targets have been reassigned to you.", worldName, [name player] call life_fnc_cleanName]]] call BIS_fnc_showNotification;
};
