/*
	File: fn_onTakeItem.sqf
	Author: Dom
	Description: Monitors what item someone picks up
*/
params [
	["_unit",objNull,[objNull]],
	["_container",objNull,[objNull]],
	["_item","",[""]]
];

if (life_laser_inprogress) exitWith {deleteVehicle _container};

private _house = _container getVariable["house", objNull];
if (!isNull _house) exitWith {
	_containerId = _container getVariable["containerId", -1];
	if (_containerId > -1) then { _container setVariable["lootModified", true, true]; };
};

switch _item do {
	case "ItemRadio": {if (life_radio_chan > -1 && !("ItemRadio" in (assignedItems player))) then { [nil,nil,nil,-1] spawn life_fnc_useRadio; };};
	case "U_B_HeliPilotCoveralls": { if (!difficultyEnabledRTD) then { removeUniform player } };
	case "V_HarnessOGL_brn": { if (!(33 in life_talents)) then { removeUniform player } };
	case "U_NikosAgedBody": { if (getPlayerUID player != (life_configuration select 0)) then { removeUniform player } };
	case "U_O_CombatUniform_ocamo": { if (!(8 in life_lootRewards) && playerSide != west) then { removeUniform player } };
	case "U_O_PilotCoveralls": { if (!(9 in life_lootRewards) && playerSide != west) then { removeUniform player } };
	case "U_O_Protagonist_VR":{ if (life_donator < 5) then { removeUniform player } };
	case "U_O_Wetsuit":{ if (life_donator < 4) then { removeUniform player } };
	case "H_PilotHelmetHeli_O": { if !((vehicle player) isKindOf "Air") then { removeHeadgear player } };
	case "H_HelmetB_light": { if (!(6 in life_lootRewards)) then { removeHeadgear player } };
	case "H_HelmetB_light_snakeskin": { if (!(7 in life_lootRewards)) then { removeHeadgear player } };
	case "H_HelmetB_light_black": { if (!(6 in life_lootRewards) && !(7 in life_lootRewards)) then { removeHeadgear player } };
};

[] spawn life_fnc_sessionUpdate;