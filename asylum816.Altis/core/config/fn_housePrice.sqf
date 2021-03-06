/*
	File: fn_housePrice.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Returns the buyable house price.
*/
private _type = param [0,"",[""]];
if(_type == "") exitWith {-1};

_price = switch (_type) do
{
	case "Land_i_House_Small_01_V1_F": {70000};
	case "Land_i_House_Small_01_V2_F": {70000};
	case "Land_i_House_Small_01_V3_F": {70000};
	case "Land_i_House_Small_02_V1_F": {70000};
	case "Land_i_House_Small_02_V2_F": {70000};
	case "Land_i_House_Small_02_V3_F": {70000};
	case "Land_i_House_Small_03_V1_F": {70000};
	case "Land_i_House_Big_01_V1_F": {150000};
	case "Land_i_House_Big_01_V2_F": {150000};
	case "Land_i_House_Big_01_V3_F": {150000};
	case "Land_i_House_Big_02_V1_F": {150000};
	case "Land_i_House_Big_02_V2_F": {150000};
	case "Land_i_House_Big_02_V3_F": {150000};
	case "Land_House_Small_01_F": {40000};
	case "Land_House_Small_02_F": {70000};
	case "Land_House_Small_03_F": {70000};
	case "Land_House_Small_04_F": {70000};
	case "Land_House_Small_05_F": {70000};
	case "Land_House_Small_06_F": {70000};
	case "Land_House_Big_01_F": {140000};
	case "Land_House_Big_02_F": {200000};
	case "Land_House_Big_03_F": {200000};
	case "Land_House_Big_04_F": {200000};
	case "Land_Shed_05_F": {40000};
	case "Land_i_Stone_HouseSmall_V1_F": {120000};
	case "Land_i_Stone_HouseSmall_V2_F": {120000};
	case "Land_i_Stone_HouseSmall_V3_F": {120000};
	case "Land_i_Stone_Shed_V1_F": {40000};
	case "Land_i_Stone_Shed_V2_F": {40000};
	case "Land_i_Stone_Shed_V3_F": {40000};
	case "Land_i_Addon_02_V1_F": {40000};
	case "Land_i_Garage_V1_F": {60000};
	case "Land_i_Garage_V2_F": {55000};
	case "Land_i_Garage_V1_dam_F": {40000};
	case "Land_i_Shed_Ind_F": {200000};
	case "Land_HouseA";
	case "Land_HouseB";
	case "Land_HouseB1";
	case "Land_HouseC_R";
	case "Land_HouseA1_L";
	case "Land_HouseB1_L";
	case "Land_HouseC1_L";
	case "Land_HouseA1": {250000};
	case "Land_HouseDoubleAL";
	case "Land_HouseDoubleAL2": {600000};
	default {-1};
};

/*
_markers = [];
{ if (_x find "FMV_" > 0) then { _markers pushBack _x }; } forEach allMapMarkers;
_marker = [_markers, player] call BIS_fnc_nearestPosition;
_price = selectMax [(_price * (3*(1-(player distance2D (getMarkerPos _marker))/3000))),_price];
*/

_discount = switch (life_configuration select 12) do {
	case 2:{.95};
	case 3:{.90};
	case 4:{.75};
	default {1};
};
if (3 in life_achievements) then {_discount = _discount * .95};

_price = _price * _discount;

(floor _price);