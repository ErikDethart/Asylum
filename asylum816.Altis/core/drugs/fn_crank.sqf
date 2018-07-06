/*
	File: fn_crank.sqf
	Author: John "Paratus" VanderZwet and Bamf
	
	Description:
	Not even once!
*/

if (!([false,"crankp",1] call life_fnc_handleInv)) exitWith {};

life_drug_level = life_drug_level + 0.4;
if (life_drug_level > 1) then { life_drug_level = 1; };

if (life_crank_effect == 0) then
{
	life_crank_effect = time;
	[] spawn
	{
		"ColorInversion" ppEffectEnable true;
		"ColorInversion" ppEffectAdjust [life_drug_level / 5,0,life_drug_level / 5];
		"ColorInversion" ppEffectCommit 1;
		"chromAberration" ppEffectEnable true;
		"chromAberration" ppEffectAdjust [life_drug_level / 10,life_drug_level / 10,true];
		"chromAberration" ppEffectCommit 1;
		sleep 2.25;	
		
		while {alive player && ((time - life_crank_effect) < (4 * 60))} do
		{
			"ColorInversion" ppEffectEnable true;
			"ColorInversion" ppEffectAdjust [life_drug_level / 5,0,life_drug_level / 5];
			"ColorInversion" ppEffectCommit 1;
			"chromAberration" ppEffectEnable true;
			"chromAberration" ppEffectAdjust [life_drug_level / 10,life_drug_level / 10,true];
			"chromAberration" ppEffectCommit 1;
			sleep 2;
		};
		
		"chromAberration" ppEffectEnable false;
		"ColorInversion" ppEffectEnable false;
		life_crank_effect = 0;
	};
};

life_crank_effect = time;

[] spawn
{
	systemChat "You feel incredible!";
	player setAnimSpeedCoef 1.15;
	player setFatigue 0;
	player enableFatigue false;
	waitUntil {!alive player OR ((time - life_crank_effect) > (4.5 * 60))};
	life_crank_effect = 0;
	player enableFatigue true;
	player setAnimSpeedCoef 1;
};

[] call life_fnc_hudUpdate;
["crank"] call life_fnc_drugUsed;