/*
	File: fn_equipGear.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Initializes custom gear textures
*/

private ["_customTexture","_hiddenTextures"];

_customTexture = switch (uniform player) do
{
	case "U_Rangemaster":
	{
		switch(life_coplevel) do
		{
			case 0;
			case 1: { "images\c_poloshirtpants_police_cadet_co.jpg" };
			case 2: { "images\police_rangemaster_constable.jpg" };
			case 3: { "images\police_rangemaster_corporal.jpg" };
			case 4: { "images\police_rangemaster_sergeant.jpg" };
			case 5: { "images\police_rangemaster_lieutenant.jpg" };
			case 6: { "images\police_rangemaster_captain.jpg" };
			default { "images\c_poloshirtpants_police_lieutenant_co.jpg" };
		};
	};
	case "U_O_PilotCoveralls": {
			if ((playerSide isEqualTo west) && {(player getVariable ["copLevel",0]) > 0}) then { 
				"images\c_coveralls_police.jpg"
			} else {
				"a3\Characters_f\Common\Data\pilot_suit_iran_co.paa" };
		};
	case "U_Competitor": { "images\c_poloshirtpants_police_cadet_co.jpg" };
	//case "U_O_CombatUniform_ocamo": { "images\c_uniform_csat.jpg" };
	case "U_O_OfficerUniform_ocamo": { "images\o_officer_desert.jpg" };
	case "U_B_CombatUniform_mcam_worn": 
	{
		if (life_activeSWAT) then { "images\c_combat_police_co.jpg" }
		else
		{
			switch(life_coplevel) do
			{
				case 4: { "images\police_combatu_sgt.jpg" };
				case 5: { "images\police_combatu_lt.jpg" };
				case 6: { "images\police_combatu_captain.jpg" };
				default { "images\police_combatu_sgt.jpg" };
			};
		};
	};
	case "U_I_CombatUniform_shortsleeve": { "images\medic_uniform.jpg" };
	case "U_C_Scientist": { "images\prisoner_uniform.jpg" };
	case "U_I_Protagonist_VR":
	{
		switch (true) do
		{
			case (life_donator < 5): { "#(argb,8,8,3)color(1,1,1,1)" };
			default { "#(argb,8,8,3)color(0.2,0.8,0.2,1,ca)" };
		};
	};
	case "U_B_Protagonist_VR":
	{
		switch (true) do
		{
			case (life_donator < 5): { "#(argb,8,8,3)color(1,1,1,1)" };
			default { "#(argb,8,8,3)color(0.0,0.6,1.0,1,ca)" };
		};
	};
	default { (player getVariable ["customTexture", ["",""]] select 1) };
};

if ((_customTexture == "images\prisoner_uniform.jpg") && (uniform player != "U_C_Scientist")) then {_customTexture = "";};

if (_customTexture == "") then {
	if !(isNil{player getVariable ["customTexture", nil]}) then {player setVariable ["customTexture", nil, true]};
} else {
	if !((toLower(getObjectTextures player select 0) find toLower(_customTexture)) > -1) then {
		_customTexture = [uniform player, _customTexture];
		player setObjectTextureGlobal[0,_customTexture select 1];
		player setVariable ["customTexture", _customTexture, true];
	};
};

if ((player getVariable ["customTextureBP", ["",""]]) select 0 != backpack player) then
{
	if (backpack player != "") then { player setVariable ["customTextureBP", nil, true]; };
	_hiddenTextures = getArray(configFile >> "CfgVehicles" >> (backpack player) >> "hiddenSelectionsTextures");
	if (count _hiddenTextures > 0) then {
		if !((toLower(_hiddenTextures select 0) find toLower(getObjectTextures(backpackContainer player) select 0)) > -1) then {
			//[player,_hiddenTextures select 0, true] remoteExecCall ["life_fnc_setUniform",-2];
			(backpackContainer player) setObjectTextureGlobal [0, _hiddenTextures select 0];
		};
	};
}
else
{
	diag_log toLower((player getVariable ["customTextureBP", ["",""]]) select 1);
	diag_log toLower(getObjectTextures(backpackContainer player) select 0);
	if !((toLower(getObjectTextures(backpackContainer player) select 0) find toLower((player getVariable ["customTextureBP", ["",""]]) select 1)) > -1) then {
		(backpackContainer player) setObjectTextureGlobal [0, (player getVariable ["customTextureBP", ["",""]]) select 1];
	};
};