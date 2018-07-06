/*
	File: fn_prisonBreak.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Initiate a prison break.
*/
params [
	["_unit",objNull,[objNull]],
	"",
	"",
	["_phase",1,[0]]
];

if ((currentWeapon player) in ["","Binocular","hgun_Pistol_Signal_F"]) exitWith { hint "The prison guards aren't very intimidated by unarmed citizens."};

switch (_phase) do {
	case 0: { //disable power
		if (time - life_lastPrison < 2700) exitWith { hint "This prison is on lockdown.  Try again in a few minutes."; };
		if !([3] call life_fnc_policeRequired) exitWith {};
		
		life_prison_power = 1;
		publicVariable "life_prison_phase";
		
		[[0,2], "You have initiated a prison break and are now wanted for it!"] call life_fnc_broadcast;
		//Commented line below since it causes the prison break to automatically fail
		//[] remoteExecCall ["life_fnc_copPrison",west];
		
		[player,"901C"] remoteExec ["life_fnc_addWanted", 2];
		
		disableUserInput true;
		
		[player,"Acts_carFixingWheel","playNow",15] remoteExecCall ["life_fnc_animSync",-2];
		disableSerialization;
		5 cutRsc ["life_progress","PLAIN"];
		_ui = uiNameSpace getVariable "life_progress";
		_success = false;
		_progress = _ui displayCtrl 38201;
		_pgText = _ui displayCtrl 38202;
		_pgText ctrlSetText "Disabling Power";
		_progress progressSetPosition 0.01;
		_cP = 0.01;
		for "_i" from 0 to 1 step 0 do {
			sleep 0.6;
			_cP = _cP + 0.01;
			_progress progressSetPosition _cP;
			_pgText ctrlSetText format["Disabling Power... (%1%2)",round(_cP * 100),"%"];
			if (_cp >= 1) exitWith {_success = true};
			if (!alive player || player getVariable ["restrained",false] || player getVariable ["downed",false]) exitWith {};
		};
		5 cutText ["","PLAIN"];
		[player,""] remoteExecCall ["life_fnc_animSync",-2];
		disableUserInput false;		
		if (!_success) exitWith {};
		
		life_prison_power = 2;
		publicVariable "life_prison_power";
		
		[0,2,format["%1 DISABLED the prison power!", [profileName] call life_fnc_cleanName]] remoteExecCall ["life_fnc_broadcast",west];
		hint "Prison power is disabled. It will take 20 minutes before power is restored, unless an officer accesses this terminal.";
	};
	case 1: { // Power restore
		[player,"Acts_carFixingWheel","playNow",15] remoteExecCall ["life_fnc_animSync",-2];
		disableSerialization;
		5 cutRsc ["life_progress","PLAIN"];
		_ui = uiNameSpace getVariable "life_progress";
		_progress = _ui displayCtrl 38201;
		_pgText = _ui displayCtrl 38202;
		_pgText ctrlSetText "Restoring Power";
		_progress progressSetPosition 0.01;
		_cP = 0.01;
		_success = false;
		for "_i" from 0 to 1 step 0 do {
			sleep 0.6;
			_cP = _cP + 0.01;
			_progress progressSetPosition _cP;
			_pgText ctrlSetText format["Restoring Power... (%1%2)",round(_cP * 100),"%"];
			if (_cp >= 1) exitWith {_success = true};
			if (!alive player || player getVariable ["restrained",false] || player getVariable ["downed",false]) exitWith {};
		};
		5 cutText ["","PLAIN"];
		[player,""] remoteExecCall ["life_fnc_animSync",-2];
		if (!_success) exitWith {};
		
		life_prison_power = 0;
		publicVariable "life_prison_phase";
		
		[0,2,format["%1 RESTORED the prison power!", [profileName] call life_fnc_cleanName]] remoteExecCall ["life_fnc_broadcast",west];
	};
	case 2: { // Lockpick lobby
		if (time - life_lastPrison < 2700) exitWith { hint "This prison is on lockdown.  Try again in a few minutes."; };
		if ((prison_lobby animationPhase "Door_1_rot") >= 0.5) exitWith { hint "The building is already opened!" };
		if !([3] call life_fnc_policeRequired) exitWith {};
		_delay = 0.9;
		if (!isNull life_prison_hacker) exitWith { hint format["%1 is already bypassing building security.", name life_prison_hacker] };
		if (life_prison_power < 2) then { hint "The power locks are still active. This will take a few minutes to bypass."; _delay = _delay * 3 };
		
		life_prison_hacker = player;
		publicVariable "life_prison_hacker";
		
		if (!life_prison_inProgress) then {[player,1,_unit] remoteExec ["life_fnc_startPrisonBreak",2]; };
		disableSerialization;
		5 cutRsc ["life_progress","PLAIN"];
		_ui = uiNameSpace getVariable "life_progress";
		_progress = _ui displayCtrl 38201;
		_pgText = _ui displayCtrl 38202;
		_pgText ctrlSetText "Disabling Building Security";
		_progress progressSetPosition 0.01;
		_cP = 0.01;
		_success = false;
		for "_i" from 0 to 1 step 0 do {
			sleep _delay;
			_cP = _cP + 0.01;
			_progress progressSetPosition _cP;
			_pgText ctrlSetText format["Disabling Building Security... (%1%2)",round(_cP * 100),"%"];
			if (_cp >= 1) exitWith {_success = true};
			if (!alive player || player getVariable ["restrained",false] || player getVariable ["downed",false]) exitWith {};
		};
		5 cutText ["","PLAIN"];
		life_prison_hacker = objNull;
		publicVariable "life_prison_hacker";
		
		if (!_success) exitWith {};
		
		_numDoors = getNumber(configFile >> "CfgVehicles" >> (typeOf prison_lobby) >> "numberOfDoors");
		for "_i" from 1 to _numDoors do
		{
			prison_lobby animate [format["door_%1_rot",_i],1];
		};
	};
	case 3: // Open main gate
	{
		if (!life_prison_inProgress) exitWith { hint "You cannot use this device while this building is locked down." };
		_delay = 0.6;
		if (life_prison_power < 2) then { hint "The firewall power is still active. This will take a few minutes to bypass."; _delay = _delay * 3 };
		
		[player,"Acts_carFixingWheel","playNow",15] remoteExecCall ["life_fnc_animSync",-2];
		disableSerialization;
		5 cutRsc ["life_progress","PLAIN"];
		_ui = uiNameSpace getVariable "life_progress";
		_progress = _ui displayCtrl 38201;
		_pgText = _ui displayCtrl 38202;
		_pgText ctrlSetText "Hacking Gate Power";
		_progress progressSetPosition 0.01;
		_cP = 0.01;
		_success = false;
		_startPos = getPosASL player;
		for "_i" from 0 to 1 step 0 do {
			sleep _delay;
			_cP = _cP + 0.01;
			_progress progressSetPosition _cP;
			_pgText ctrlSetText format["Hacking Gate Power... (%1%2)",round(_cP * 100),"%"];
			if (_cp >= 1) exitWith {_success = true};
			if (!alive player || player getVariable ["restrained",false] || player getVariable ["downed",false] || player distance2D _startPos > 3) exitWith {};
		};
		5 cutText ["","PLAIN"];
		[player,""] remoteExecCall ["life_fnc_animSync",-2];
		if (!_success) exitWith {};
		
		prison_gate_1 animate ["door_1_rot",1];
		prison_gate_1 animate ["door_2_rot",1];
		[[0,2], "Primary gates disengaged. Lockdown will occur in 4 minutes! Move quickly!"] call life_fnc_broadcast;
		sleep 240;
		if (life_prison_inProgress) then
		{
			life_prison_inProgress = false;
			publicVariable "life_prison_inProgress";
		};
	};
};
