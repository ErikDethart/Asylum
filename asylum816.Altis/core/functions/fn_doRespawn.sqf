/*
	File: fn_doRespawn.sqf
	Author: John "Paratus" VanderZwet

	Description:
	Force respawn when at death screen.
*/

private ["_unit"];

_unit = player;
if (!(isNull life_corpse)) then { _unit = life_corpse };

if (playerSide in [civilian,west]) then
{
	[_unit,true,life_in_vehicle] spawn life_fnc_dropItems;
};

closeDialog 0;
life_respawned = true;

{
	_x setVariable ["aggressive", nil];
} forEach allPlayers;

[player, player] remoteExecCall ["life_fnc_medicRespondDone",independent];
[] call life_fnc_spawnMenu;
