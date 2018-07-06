/*
	File: fn_handleTagged.sqf
	Author: John "Paratus" VanderZwet
	
	Description: Been tagged, yo!
*/
_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;

player setDamage 0;
if (!life_istagged) then
{
	player allowDamage false;
	player setVariable["laserTagged", true, true];
	life_istagged = true;
[player] remoteExecCall ["ASY_fnc_laserEliminated",2];
	disableUserInput true;
	
	_obj = "Land_ClutterCutter_small_F" createVehicle (getPosATL player);
	_obj setPosATL (getPosATL player);
	player attachTo [_obj,[0,0,0]];
[player,"AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon","playNow"] remoteExecCall ["life_fnc_animSync",-2];
	
	{
		if (_x distance (getMarkerPos "lasertag") < 35) then
		{
[0,format["%1 was tagged by %2.", profileName, name _unit]] remoteExecCall ["life_fnc_broadcast",_x];
		};
	} forEach allPlayers;
	
	sleep 5;
	
	disableUserInput false;
	detach player;
	deleteVehicle _obj;
	
	player setPos (player getVariable ["life_laser_pos", getMarkerPos "city"]);
	if (count (units life_old_group) < life_groupCap) then
	{
		[player] joinSilent (life_old_group);
	}
	else
	{
		[player] joinSilent (createGroup civilian);
	};
	
	life_laser_inprogress = false;
	life_istagged = false;
	sleep 2;
	player allowDamage true;
};
