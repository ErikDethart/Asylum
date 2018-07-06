/*
	File: fn_jailMe.sqf
	Author Bryan "Tonic" Boardwine

	Description:
	Once word is received by the server the rest of the jail execution is completed.
*/
params [
	["_ret",[],[[]]],
	["_jailSpawn","jail_marker2",[""]],
	["_jailRelease","jail_release2",[""]]
];

_ret params [
	["_name","",[""]],
	["_PID","",[""]],
	["_crimes",[],[[]]],
	["_bounty",0,[0]],
	["_time",0,[0]]
];

private _cannibal = ((_crimes findIf {_x select 0 isEqualTo "Cannabalism"}) >- 1);
if (_cannibal) then {_jailSpawn = "jail_marker_asylum";};

private _jailSpawnPos =  getPosATL (missionNamespace getVariable format["%1_notepad",_jailSpawn]);
private _jailReleasePos = getMarkerPos _jailRelease;

player setPosATL _jailSpawnPos;

closeDialog 0;
life_is_arrested = true;
life_bail_paid = false;
life_breakout = false;
[false] call life_fnc_seizePlayerIllegalAction;
[] call life_fnc_civFetchGear;
player setVariable ["parole", nil, true];
player setVariable ["paroleViolated", nil, true];
player setVariable ["prisoner", true, true];
player setVariable ["blindfolded", nil, true];
player setVariable ["copLevel", 0];
removeVest player;
removeHeadgear player;
removeBackpack player;
player setDamage 0;

player forceAddUniform "U_C_Scientist";
[] call life_fnc_equipGear;

player setVariable["can_revive", nil, true];
player setDamage 0;
[0] call life_fnc_setPain;
[false] call life_fnc_brokenLeg;

life_bail_amount = _bounty;
life_jail_time = _time;

//if (life_jail_time > 3600) then { life_jail_time = 3600; }; // Set to 60 mins for Skiptracer Talents - not needed because of below
private _jailFx = switch (life_configuration select 12) do {
	case 1:{.9};
	case 2:{.8};
	case 3:{.7};
	case 4:{.5};
	default {1};
};
if (life_jail_time <= 2700) then {
	life_jail_time = selectMin[life_jail_time,(_jailFx * 2700)]; //apply jailFX to max jail time.
} else {
	life_jail_time = selectMin[life_jail_time,(_jailFx * 3600)];
};
if(!isNil "was_interrogated") then {life_jail_time = round(life_jail_time * 1.33); was_interrogated = nil};
//_esc = false;
private _bail = false;

life_canpay_bail = nil;

[] call life_fnc_sessionUpdate;

private _endTime = round (time + life_jail_time);
while {life_is_arrested} do
{
	//life_maxWeight = 96;
	if !(life_laser_inprogress) then {removeAllWeapons player};

	life_jail_time = round (_endTime - time);
	life_can_trial = ((life_jail_time > 900) && !life_requested_trial && (life_wanted < 999999));

	if(life_jail_time > 0) then
	{
		_countDown = if(life_jail_time > 60) then {format["%1 minute(s)",round(life_jail_time / 60)]} else {format["%1 second(s)",life_jail_time]};
		if (life_bail_amount >= life_executionThreshold && (life_configuration select 9)) then { _countDown = format["ON DEATH ROW\nTrial required for survival.\n\n%1", _countDown]; };
		hintSilent format["Time Remaining:\n %1\n\nCan pay bail: %3\nBail Price: $%2",_countDown,[life_bail_amount] call life_fnc_numberText,if(isNil "life_canpay_bail") then {"Yes"} else {"No"}];
		//_jailed = true;
	};

	if(life_bail_paid) exitWith
	{
		_bail = true;
		//_jailed = false;
	};

	if (life_prison_inProgress && player distance2D prison_teleport < 25 && prison_gate_1 animationPhase "Door_1_rot" >= 0.5) exitWith {life_breakout=true};
	
	if !(isNull objectParent player) then {player action ["Eject", vehicle player]};
	
	if(player distance2D (getMarkerPos "jail_marker2") > 90 && !(player getVariable ["defendant",false]) && !life_laser_inprogress) then // exitWith
	{
		systemChat "Get away from the walls!";
		player setPosATL _jailSpawnPos;
		//_esc = true;
	};
	if(life_jail_time < 1) exitWith {hint ""};
	if(!alive player && (life_jail_time > 0)) exitWith
	{
		//_jailed = false;
	};

	life_thirst = 100;
	life_hunger = 100;
	[] call life_fnc_hudUpdate;
};

waitUntil { !life_isdowned };

player setVariable ["arrested", nil, true];
player setVariable ["prisoner", nil, true];
life_abort_enabled = true;
life_can_trial = false;
life_requested_trial = false;
life_jail_time = 0;
life_inv_shank = 0;
profileNamespace setVariable["asylum",false];

switch (true) do
{
	case (_bail) :
	{
		life_is_arrested = false;
		life_bail_paid = false;
		life_breakout = false;
		hint "You have been released from prison.";
		[player] remoteExec ["life_fnc_removeWanted", 2];
		player setPosATL _jailReleasePos;
		[] call life_fnc_civLoadGear;
		[] call life_fnc_sessionUpdate;
		[] call life_fnc_equipGear;
		//_jailed = false;
	};

	case (life_breakout) :
	{
		life_is_arrested = false;
		life_breakout = false;
		hint "You have escaped from prison, you still retain your previous crimes and now have a count of escaping prison.";
		[0,format["%1 has escaped from prison!",name player]] remoteExecCall ["life_fnc_broadcast",west];
		[player] remoteExec ["life_fnc_removeWanted", 2];
		sleep 2;
		[player,"901"] remoteExec ["life_fnc_addWanted", 2];
	};

	case (alive player && !life_breakout && !_bail) :
	{
		life_is_arrested = false;
		life_breakout = false;
		hint "You have served your time in jail and have been released.";
		[player] remoteExec ["life_fnc_removeWanted", 2];
		[] call life_fnc_civLoadGear;
		[] call life_fnc_sessionUpdate;
		[] call life_fnc_equipGear;
		if (life_bail_amount >= life_executionThreshold && (life_configuration select 9)) then
		{
			playSound "handcuffs";
			cutText["Your head is covered while sitting on the chair.","BLACK FADED"];
			0 cutFadeOut 999999;
			if (isWeaponDeployed player) then { player playMove ""; };
			player setPos (getMarkerPos "respawn_civilian");
			sleep 1;
			playSound "elechair";
			sleep 9;
			player setDamage 1;
			["999999",4000,"add",player] remoteExecCall ["ASY_fnc_updateGangBank",2];
			life_respawned = true;
			cutText ["", "BLACK IN", 0.75];
			[] call life_fnc_spawnMenu;
		}
		else
		{
			if (isWeaponDeployed player) then { player playMove ""; };
			player setPosATL _jailReleasePos;
			[] call life_fnc_equipGear;
		};
	};
};
