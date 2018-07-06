/*
	File: fn_prisonGate.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Open a single secondary prison gate.
*/

_gate = [_this,0,objNull,[objNull]] call BIS_fnc_param;
if (isNull _gate) exitWith {};

if (life_inv_lockpick < 1) exitWith { hint "You don't have any lockpicks!" };

disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNameSpace getVariable "life_progress";
_success = false;
_startPos = getPosATL player;
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText "Lockpicking Gate";
_progress progressSetPosition 0.01;
_cP = 0.01;
while{true} do {
	sleep 0.6;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["Lockpicking Gate... (%1%2)",round(_cP * 100),"%"];
	if (_cp >= 1) exitWith {_success = true};
	if (!alive player || player getVariable ["restrained",false] || player getVariable ["downed",false] || player distance2D _startPos > 2) exitWith {};
};
5 cutText ["","PLAIN"];
[player,""] remoteExecCall ["life_fnc_animSync",-2];
	
if (!_success) exitWith {};

_gate animate ["door_1_rot",1];
_gate animate ["door_2_rot",1];

if (str(_gate) == "prison_gate_4") then {
	life_prison_power = 4;
	publicVariable "life_prison_power";
	};
