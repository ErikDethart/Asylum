/*
	File: fn_oilPump.sqf
	Author: Gnashes
	
	Description:
	Toggles oil truck pumps on and off
*/
private["_vehicle","_fuel","_pos","_ui","_progress","_pgText","_cP","_delayInt","_upp","_nBuilding"];

_vehicle = param [3,ObjNull,[ObjNull]];

if (isNull _vehicle) exitWith {systemChat "Error! Null Vehicle"};
if !(alive _vehicle) exitWith {systemChat "Error! Dead Vehicle"};
if (player distance2D _vehicle > 7) exitWith {systemChat "Error! Too Far Away"};

if ({player distance getMarkerPos format["oil_%1",_x] < 150} count [1,2,3,4,5] == 0) exitWith { hint "You can't drill for oil at this location!"};

if !(_vehicle getVariable["oilPump", false]) then {    
    hint "The pump and drill are setting up.";
	
	//Setup our progress bar.
	_upp = "Setting up the Drill and Pump";
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
	if (!life_action_in_use) exitWith {hint "Action cancelled. Aborted drill setup!"; 5 cutText ["","PLAIN"]; life_is_processing = false; life_action_in_use = false;};
	if(player distance _vehicle > 10) exitWith {hint "You need to stay within 10m to setup the drill."; 5 cutText ["","PLAIN"]; life_is_processing = false; life_action_in_use = false;};
	if(!(alive player)) exitWith {hint "You need to be alive to setup the drill."; 5 cutText ["","PLAIN"]; life_is_processing = false; life_action_in_use = false;};
	if (count(crew _vehicle) > 0) exitWith {hint "No one should be inside the truck without special gear."; 5 cutText ["","PLAIN"]; life_is_processing = false; life_action_in_use = false;};
	5 cutText ["","PLAIN"];
	life_is_processing = false;
	life_action_in_use = false;
	_vehicle setVariable["oilPump", true, true];
	
}
else
{
    hint "You are retracting the drill.";
	//Setup our progress bar.
	_upp = "Retracting the Drill";
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
	if (!life_action_in_use) exitWith {hint "Action cancelled. You didn't retract the drill!"; 5 cutText ["","PLAIN"]; life_is_processing = false; life_action_in_use = false;};
	if(player distance _vehicle > 10) exitWith {hint "You need to stay within 10m to retract the drill."; 5 cutText ["","PLAIN"]; life_is_processing = false; life_action_in_use = false;};
	if(!(alive player)) exitWith {hint "You need to be alive to retract the drill."; 5 cutText ["","PLAIN"]; life_is_processing = false; life_action_in_use = false;};
	life_action_in_use = false;
	5 cutText ["","PLAIN"];
	life_is_processing = false;
	life_action_in_use = false;
	(_vehicle setVariable["oilPump", false, true]);
	_vehicle setHit [getText (configfile >> "CfgVehicles" >> typeOf _vehicle >> "HitPoints" >> "HitEngine" >> "name"), 0];
    
};
