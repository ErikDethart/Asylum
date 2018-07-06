/*
	File: fn_varHandle.sqf
	Author: Bryan "Tonic" Boardwine, rewritten by Gnashes
	
	Description:
	Rewritten master handler for getting a variables name, short name, etc.
*/
params [
	["_var","",[""]],
	["_mode",-1,[0]]
];
if (_var isEqualTo "" || _mode isEqualTo -1) exitWith {""};

switch (_mode) do {
	case 0: {
		switch (_var) do {
			case "money": {"life_money"};
			case "fishing": {"life_inv_fishingpoles"};
			case "iron_r": {"life_inv_ironr"};
			case "copper_r": {"life_inv_copperr"};
			case "salt_r": {"life_inv_saltr"};
			case "diamondc": {"life_inv_diamondr"};
			case "cocaine": {"life_inv_coke"};
			case "cocainep": {"life_inv_cokep"};
			case "cocainepure": {"life_inv_cokepure"};
			default {format["life_inv_%1",_var]};
		};
	};
	
	case 1: {
		switch (_var) do {
			case "life_money": {"money"};
			case "life_inv_fishingpoles": {"fishing"};
			case "life_inv_ironr": {"iron_r"};
			case "life_inv_copperr": {"copper_r"};
			case "life_inv_saltr": {"salt_r"};
			case "life_inv_diamondr": {"diamondc"};
			case "life_inv_coke": {"cocaine"};
			case "life_inv_cokep": {"cocainep"};
			case "life_inv_cokepure": {"cocainepure"};
			default {(_var select [((_var find "inv_")+4)])};
		};
	};
};