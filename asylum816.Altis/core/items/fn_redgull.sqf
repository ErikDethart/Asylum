/*
		File: fn_redgull.sqf
		Author: John "Paratus" VanderZwet
		
		Description: Removes fatigue temporarily
*/
if (life_revive_fatigue > 0) exitWith { hint "This item has no effect due to revive fatigue." };

if(([false,"redgull",1] call life_fnc_handleInv)) then
{
	life_thirst = 100;
	player setFatigue 0;
	life_redgull_effect = time;
	titleText["You can now run without rest for 3 minutes","PLAIN"];
	player enableFatigue false;
	[] spawn
		{
			waitUntil {sleep 1; (!alive player || ((time - life_redgull_effect) > (3 * 60)))};
			player enableFatigue true;
		};
};
[] call life_fnc_hudUpdate;