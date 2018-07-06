/*
	File: fn_openSafe.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Try to open a bank safe.
*/
params ["","_caller","","_explosive"];
_safe = cursorObject;
if (life_action_in_use) exitWith {};

if ((typeOf _safe) != "Land_Research_house_V1_F" && (typeOf _safe) != "Land_Research_HQ_F") exitWith {};
if ((_caller distance _safe) > 15) exitWith {};
if (isNull objectParent _caller) then {hint "You can't do this from within a vehicle."};
if (!([5, true] call life_fnc_policeRequired) && !(life_bank_inProgress)) exitWith {};

if (!isNil "life_bank_lastRobbed" && {life_bank_lastRobbed > (time - 1800)}) exitWith{hint format["Security is high due to a recent robbery and you cannot crack this safe.  Try again in %1 minute(s).", ceil ((life_bank_lastRobbed - (time - 1800))/60)]};

_locked = _safe getVariable ["life_locked", 1];
_inRange = false;
_doorPos = [0,0,0];
{
	if ((_caller distance _x) < 2) then { _doorPos = _x; _inRange = true; };
} forEach life_bank_safe_pos;

if !(_locked isEqualTo 1) exitWith {hint "This safe has already been unlocked.  You can open this door."};
if (!_inRange) exitWith {hint "You are not close enough to the safe door."};
if (_explosive && !(116 in life_talents)) exitWith {hint "You do not understand how to use a demo charge."};
if (_explosive) then {
	if !([false,"demoCharge",1] call life_fnc_handleInv) exitWith {};
};

life_action_in_use = true;
_success=false;
_pos = getPosATL _caller;

if (!_explosive) then {
	_upp = "Cracking vault locks...";
	//Setup our progress bar.
	disableSerialization;
	5 cutRsc ["life_progress","PLAIN"];
	_ui = uiNameSpace getVariable "life_progress";
	_progress = _ui displayCtrl 38201;
	_pgText = _ui displayCtrl 38202;
	_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
	_progress progressSetPosition 0.01;
	_cP = 0.01;
	for "_i" from 0 to 1 step 0 do {
		if(animationState _caller != "acts_carfixingwheel") then {
			_caller playMoveNow "Acts_carFixingWheel";
			[_caller,"Acts_carFixingWheel"] remoteExecCall ["life_fnc_animSync",-2];
		};
		sleep 0.38;
		_cP = _cP + 0.01;
		_progress progressSetPosition _cP;
		_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
		if(_cP >= 1) exitWith {_success=true;};
		if (_caller distance _pos > 4) exitWith {};
		if (!alive _caller) exitWith {};
		if (speed _caller > 2) exitWith {};
		if (!life_action_in_use) exitWith {};
	};
	5 cutText ["","PLAIN"];
} else {
	_bomb = "GrenadeHand" createVehicle _doorPos;
	_bomb setPos _doorPos;
	[_caller, "bombarm",30] remoteExecCall ["life_fnc_playSound",-2];
	sleep 5;
	_success = true;
};
life_action_in_use = false;

if (_success) then {
	_numDoors = getNumber(configFile >> "CfgVehicles" >> (typeOf _safe) >> "numberOfDoors");
	_safe setVariable["life_locked", 0, true];
	for "_i" from 1 to _numDoors do {
		_safe setVariable[format["bis_disabled_Door_%1", _i], 0, true];
	};
	life_experience = life_experience + 25;
	hint "The safe has been cracked and is now unlocked.";
	if (!life_bank_inProgress) then {
		_chance = if (_explosive && {117 in life_talents}) then {1} else {2};
		if ((floor random _chance) isEqualTo 0) then {[_caller] remoteExec ["ASY_fnc_fedAlarm",2]; };
	};
};
