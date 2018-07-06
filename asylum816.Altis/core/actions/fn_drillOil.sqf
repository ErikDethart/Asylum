/*
	File: fn_drillOil.sqf
	Author: Gnashes
	
	Description:
	Drills for oil! Fills vehicle based on percentage when loop is broken.
*/

if(time - life_last_sold < 10) exitWith {hint "You cannot rapidly drill for oil!"};

private _vehicle = cursorTarget;
_veh_data = _vehicle getVariable ["Trunk",[[],0]];
_veh_inv = _veh_data select 0;
_oilInv = ["oilu",0];
_veh_weight = _veh_data select 1;
_totalWeight = ([_vehicle] call life_fnc_vehicleWeight select 0);
_openWeight = _totalWeight - _veh_weight;
_exit = false;
_time = time;

//Setup our progress bar.
_upp = "Filling Vehicle with Oil";
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_progress progressSetPosition 0.01;
_cP = 0.01;
if (_veh_weight > 0) then { _cP = (_veh_weight/_totalWeight)};

life_is_processing = true;
life_action_in_use = true;
_vehicle enableRopeAttach false;
//start playing your generator/drilling sound from the vehicle

_delayInt = ((_totalWeight/0.925924)/100);
if (105 in life_talents) then { _delayInt = _delayInt * .95 };
_delayFx = switch (life_configuration select 12) do {
    case 1:{.95};
    case 2:{.9};
    case 3:{.85};
    case 4:{.8};
    default {1};
};
_delayInt = _delayInt * _delayFx;
while{true} do {
	sleep _delayInt;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if(_cP >= 1) exitWith {};
	if(player distance _vehicle > 100) exitWith {};
	if (!life_action_in_use) exitWith {};
	if (count(crew _vehicle) > 0) exitWith {};
	if ((speed _vehicle) > 0) exitWith {};
	if !(_vehicle getVariable["oilPump", false]) exitWith {};
	if !(alive _vehicle) exitWith {_exit = true};
	if (isNull _vehicle) exitWith {_exit = true};
	if (time - _time > 120) then {_vehicle remoteExecCall ["ASY_fnc_setIdleTime",2]; _time = time;};
};

5 cutText ["","PLAIN"];
life_is_processing = false;
life_action_in_use = false;
//stop playing your generator/drilling sound from the vehicle

if (_exit) exitWith {};
_weightFilled = (floor(_cP*_totalWeight));
if (_weightFilled > _openWeight) then {_weightFilled = _totalWeight};
_qtyFilled = floor(_weightFilled / (["oilu"] call life_fnc_itemWeight));
_weight = (["oilu"] call life_fnc_itemWeight) * _qtyFilled;
_oilInv set[0,"oilu"];
_oilInv set[1,_qtyFilled];
_index = ["oilu",_veh_inv] call life_fnc_index;
if (_index == -1) then {_veh_inv pushBack _oilInv} else {_veh_inv set[_index,_oilInv]};
_vehicle setVariable ["Trunk",[_veh_inv,_weight],true];
[_vehicle] spawn life_fnc_calcVehWeight;
titleText[format["You have drilled for oil and your vehicle now contains %1 units of unprocessed oil!",[_qtyFilled] call life_fnc_numberText],"PLAIN"];
life_last_sold = time;