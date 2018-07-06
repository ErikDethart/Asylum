/*
	File: fn_crankLab.sqf
	Author: Bamf and Gnashes
	
	Description:
	Toggles a mobile meth (crank) lab on and off
*/
private["_vehicle","_fuel","_pos","_ui","_progress","_pgText","_cP","_delayInt","_upp","_nBuilding"];

_vehicle = param [3,ObjNull,[ObjNull]];

if (isNull _vehicle) exitWith {systemChat "Error! Null Vehicle"};
if !(alive _vehicle) exitWith {systemChat "Error! Dead Vehicle"};
if (player distance2D _vehicle > 7) exitWith {systemChat "Error! Too Far Away"};

if (player distance (getMarkerPos "city") < 1000 || player distance (getMarkerPos "city_athira") < 1000 || player distance (getMarkerPos "city_pyrgos") < 1000 || player distance (getMarkerPos "city_sofia") < 1000) exitWith { hint "Starting a meth lab this close to a city would be unwise." };
if (player distance (getMarkerPos "arms_island_crank") < 3200) exitWith { hint "The arms dealers don't like drug dealers around, starting a meth lab here is not possible."};
if (player distance (getMarkerPos "skull_island_crank") < 600) exitWith { hint "The spirits of those who have been sacrificed can not be desecrated in this manner.  Try starting the lab elsewhere."};
if (player distance (getMarkerPos "courtroom") < 300) exitWith { hint "Really???"};
if (player distance (getMarkerPos "Respawn_west") < 1000) exitWith { hint "Really???"};
if (player distance (getMarkerPos "admin_island") < 1000) exitWith { hint "This island is not a suitable place to cook crank."};
if (player distance (getMarkerPos "oilrig_1") < 500) exitWith { hint "You would have to be high on this stuff to think this is a good idea."};
if (count (nearestObjects [player, ["Land_i_Shed_Ind_F"], 20]) > 0) exitWith {hint "You cannot prep your RV this close to an industrial shed!"};
if({player distance getMarkerPos format["police_hq_%1",_x] < 300} count [1,2,3,4,5] > 0) exitWith { hint "You want to go to jail right?"};

//Building checks
_nBuilding = nearestBuilding player; 
if (player distance _nBuilding <= 10) exitWith { hint "You're too close to a building to be messing with a mobile lab."};

_exit = false;
_numDP = 25;
for "_i" from 1 to _numDP do
        {
            if (player distance (getMarkerPos format["dp_1_%1", _i]) < 300) exitWith {_exit = true; hint "I think the delivery man is watching you.  Did he just call the cops?"};
        };
if (_exit) exitWith {};

if !(_vehicle getVariable["labMode", false]) then {    
    hint "The lab is warming up.";
	
	//Setup our progress bar.
	_upp = "Warming up the lab";
	disableSerialization;
	5 cutRsc ["life_progress","PLAIN"];
	_ui = uiNameSpace getVariable "life_progress";
	_progress = _ui displayCtrl 38201;
	_pgText = _ui displayCtrl 38202;
	_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
	_progress progressSetPosition 0.01;
	_cP = 0.01;

	life_is_processing = true;
	life_action_in_use = true;
	_vehicle enableRopeAttach false;
	_vehicle setHit [getText (configfile >> "CfgVehicles" >> typeOf _vehicle >> "HitPoints" >> "HitEngine" >> "name"), 1];

	_delayInt = 0.3;
	while{true} do {
		sleep _delayInt;
		_cP = _cP + 0.01;
		_progress progressSetPosition _cP;
		_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
		if(_cP >= 1) exitWith {};
		if(player distance _vehicle > 10) exitWith {};
		if (!life_action_in_use) exitWith {};
		if (count(crew _vehicle) > 0) exitWith {};
	};
	if (!life_action_in_use) exitWith {hint "Action cancelled. Aborted lab warm up!"; 5 cutText ["","PLAIN"]; life_is_processing = false; life_action_in_use = false;};
	if(player distance _vehicle > 10) exitWith {hint "You need to stay within 10m to warm up the lab."; 5 cutText ["","PLAIN"]; life_is_processing = false; life_action_in_use = false;};
	if(!(alive player)) exitWith {hint "You need to be alive to warm up the lab."; 5 cutText ["","PLAIN"]; life_is_processing = false; life_action_in_use = false;};
	if (count(crew _vehicle) > 0) exitWith {hint "No one should be inside the truck without special gear."; 5 cutText ["","PLAIN"]; life_is_processing = false; life_action_in_use = false;};
	5 cutText ["","PLAIN"];
	life_is_processing = false;
	life_action_in_use = false;
	_vehicle setVariable["labMode", true, true];
	
_vehicle remoteExec ["life_fnc_crankSmoke",-2];
}
else
{
    hint "You are breaking down the lab equipment.";
	//Setup our progress bar.
	_upp = "Breaking down the lab";
	disableSerialization;
	5 cutRsc ["life_progress","PLAIN"];
	_ui = uiNameSpace getVariable "life_progress";
	_progress = _ui displayCtrl 38201;
	_pgText = _ui displayCtrl 38202;
	_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
	_progress progressSetPosition 0.01;
	_cP = 0.01;

	life_is_processing = true;
	life_action_in_use = true;
	_vehicle enableRopeAttach true;

	_delayInt = 0.1;
	while{true} do {
		sleep _delayInt;
		_cP = _cP + 0.01;
		_progress progressSetPosition _cP;
		_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
		if(_cP >= 1) exitWith {};
		if(player distance _vehicle > 10) exitWith {};
		if (!life_action_in_use) exitWith {};
	};
	if (!life_action_in_use) exitWith {hint "Action cancelled. You didn't break down the lab!"; 5 cutText ["","PLAIN"]; life_is_processing = false; life_action_in_use = false;};
	if(player distance _vehicle > 10) exitWith {hint "You need to stay within 10m to break down the lab."; 5 cutText ["","PLAIN"]; life_is_processing = false; life_action_in_use = false;};
	if(!(alive player)) exitWith {hint "You need to be alive to break down the lab."; 5 cutText ["","PLAIN"]; life_is_processing = false; life_action_in_use = false;};
	life_action_in_use = false;
	5 cutText ["","PLAIN"];
	life_is_processing = false;
	life_action_in_use = false;
	(_vehicle setVariable["labMode", false, true]);
    
};
