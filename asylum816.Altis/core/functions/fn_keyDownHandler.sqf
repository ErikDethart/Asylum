/*
	File: fn_keyDownHandler.sqf
	Author: Bryan "Tonic" Boardwine and Chronic [MIT]

	Description:
	Main key handler for event 'keyDown'
*/
params ["_ctrl", "_code", "_shift", "_ctrlKey", "_alt"];
private _handled = false;
if(visibleMap) then {
	if ((_ctrlKey || _code == 29) && currentChannel != 3) then {
		_handled = true
	};
};

switch (_code) do
{

    if (_code in actionKeys "tacticalView") then {
        hint "BABS sees (and logs) you! Don't use tactical view";
        _handled = true;
        //[911, player, "Was Removed from Tactical View"] remoteExecCall ["ASY_fnc_logIt",2];
		[] spawn {disableUserInput true; sleep 3; disableuserinput false; disableUserInput true; disableuserinput false;};
    };
	//Escape
	case 1:
	{
		if (life_action_in_use) then { life_action_in_use = false; _handled = true; };
		if (life_show_actions) then
		{
			life_show_actions = false;
			removeAllActions player;
			life_actions = [];
		};
		if (life_targetTag) then { life_targetTag = false };
	};

	//Driving
	/* case 30: */
	case 31;
	case 32:
	{
		if (life_alcohol_level > 0 && (vehicle player) != player && (driver (vehicle player)) == player) then
		{
			private _chance = ((1 - life_alcohol_level) * 100) * 0.5;
			if (floor (random _chance) == 0) then { _handled = true; };
		};
	};
	//F Key
	case 33:
	{
		private _veh = vehicle player;

		// if the vehicle's siren object hasn't been initialized, do it now
		if(isNil {_veh getVariable "sirenLogic"}) then {
			_veh setVariable ["sirenLogic", objNull, true];
		};

		// if the siren hasn't already been started, and the player meets the requirements, start it!
		if(playerSide == west && _veh != player && (driver _veh) == player) then {
			if(isNull(_veh getVariable "sirenLogic")) then {
				_veh setVariable ["forcedPhaser", false, false];
				[_veh, false, false, false] call life_fnc_copSiren;
			} else {
				if(_veh getVariable "keyReleased") then {
					[_veh, false, false, false] call life_fnc_copSiren;
				};
			};
			// ignore any other keybindings this key has
			_handled = true;
		};
	};
};
{if(_code in actionKeys format["CommandingMenu%1",_x]) exitWith {_handled = true}} forEach [0,1,2,3,4,5,6,7,8,9];
if(_code in actionKeys "NavigateMenu") then {_handled = true};
if ((_code==47)||(_code==19)||(_code==20)||(_code==34)) then{
	_handled = ((playerSide != west) && ((player getVariable ["restrained",false]) OR (player getVariable ["transporting",false])));
};
if (_code in (actionKeys "TacticalView")) then { _handled = true; };
if (life_brokenLeg && (_code in (actionKeys "MoveUp") || _code in (actionKeys "MoveDown") || _code in (actionKeys "Stand") || _code in (actionKeys "Crouch"))) then { _handled = true; };
if (_code in (actionKeys "GetOver") && speed player > 10) then
{
	[] spawn life_fnc_jump;
	_handled = true;
};
if (_code in (actionKeys "PushToTalk") || _code in (actionKeys "PushToTalkSide")) then
{
	if (currentChannel in [0,1,6]) then { systemChat format["The Asylum does not allow voice in this channel."]; _handled = true; };
};
if (_code==41 || _code in (actionKeys "SelectAll") || _code in (actionKeys "SwitchCommand")) then
{
	if (!life_targetTag) then { 
		[]spawn {
			life_targetTag = true;
			sleep 5;
			life_targetTag = false;	
		};
	};
	_handled = true;
};
if (_code in ((actionKeys "Diary") + (actionKeys "NetworkPlayers") + (actionKeys "forceCommandingMode") + (actionKeys "menuBack"))) then
{
	_handled = true;
};
if (_code in (actionKeys "Fire") && (getPosASL player) select 2 < 0 && primaryWeapon player != "arifle_sdar_F") then
{
	_handled = true;
};
if (_code in (actionKeys "SitDown") && player getVariable["restrained",false]) then
{
	_handled = true;
};

//Prevent people from using Alt+F4 or endMission
if(_shift && _code == 74) exitWith {
	if (life_adminlevel == 0) then {
		[] spawn {disableUserInput true; sleep 2; disableUserInput false; disableUserInput true; disableUserInput false;};
		titleText["The Asylum does not allow use of this command!","PLAIN"];
		if (time - life_last_broadcast > 3) then {[0,format["%1 attempted to endMission!", profileName]] remoteExecCall ["life_fnc_broadcast",-2];};
		life_last_broadcast = time;
		_handled = true;
	};
};
if(_alt && _code == 62) exitWith {
	if (life_adminlevel == 0) then {
		[] spawn {disableUserInput true; sleep 2; disableUserInput false; disableUserInput true; disableUserInput false;};
		titleText["The Asylum does not allow use of this command!","PLAIN"];
		if (time - life_last_broadcast > 3) then {[0,format["%1 attempted to Alt+F4!", profileName]] remoteExecCall ["life_fnc_broadcast",-2];};
		life_last_broadcast = time;
		_handled = true;
	};
};

_handled;
