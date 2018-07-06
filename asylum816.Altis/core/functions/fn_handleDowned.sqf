/*
	File: fn_handleDowned.sqf
	Author: John "Paratus" VanderZwet
	
	Description: Downed state for rubber bullets
*/
private["_obj","_inVehicle","_time","_downed","_hndlBlur","_hndlBlack","_eff1","_eff2","_effects","_dead","_source","_vehSource"];
player setDamage 0;
_vehSource = false;
_source = [_this,0,objNull,[objNull]] call BIS_fnc_param;
if(isNull _source) exitWith {player allowDamage true; life_isdowned = false;};


if (!life_isdowned && alive player && isNull (findDisplay 7300) && {_source isKindOf "Man"}) then 
{	
	if(vehicle _source isKindOf "LandVehicle" && {driver (vehicle _source) == _source}) then
	{
		_vehSource = true;
		[format["%1 has been run over by %2.",[name player] call life_fnc_cleanName, [name _source] call life_fnc_cleanName]] remoteExecCall ["systemChat",-2];
		if(alive _source && side _source != west) then
		{
			[_source,"187V"] remoteExec ["life_fnc_addWanted", 2];
		};
	}
	else
	{
	//This is pretty ugly with the _message piece... But I'm entirely too lazy to rewrite the entire thing. ~Gnash
		_firstLetterA = "";
		if(group player getVariable["gangTag",""] != "") then {_firstLetterA = group player getVariable "gangTag"} else {
			_index = [group player,life_group_list] call life_fnc_index;
			_gang = if(_index > -1) then {(life_group_list select _index) select 0} else {""};
			if(_gang == "") then {
				_gang = player getVariable["gangName",""];
			};
			_length = [_gang] call KRON_StrLen;
			_select = false;
			_firstLetterA = _gang select [0,1];
			for "_i" from 1 to (_length-1) do {
				_character = _gang select [_i,1];
				if(_select) then {_firstLetterA = _firstLetterA + _character; _select = false} else {
					if(_character == " ") then {_select = true};
				};
			};
			_tagLength = [_firstLetterA] call KRON_StrLen;
			if(_tagLength == 1) then {_firstLetterA = _firstLetterA + (_gang select[_length - 1,1])};
			if(_firstLetterA == "APD") then {_firstLetterA = ""};
		};
		if(_firstLetterA != "") then {_firstLetterA = format["[%1] ",_firstLetterA]};
		_message = format["%2%1 was downed",name player,_firstLetterA];
		if(isPlayer _source && _source != player) then {
			switch(true) do {
				case(side _source == west): {
					if(_source getVariable["copLevel",0] == 0) exitWith {_message = _message + format[" by %1",name _source];};
					_message = _message + format[" by APD %2 %1",name _source,
						switch (_source getVariable["copLevel", 0]) do {
							case 1: {"Cadet"};
							case 2: {"Constable"};
							case 3: {"Corporal"};
							case 4: {"Sergeant"};
							case 5: {"Lieutenant"};
							case 6: {"Captain"};
						}
					];
		
				};
				case (side _source == civilian && (_source getVariable["gangName",""] != "" || [group _source,life_group_list] call life_fnc_index > -1)): {
					_firstLetter = "";
					_index = [group _source,life_group_list] call life_fnc_index;
					_gang = if(_index > -1) then {(life_group_list select _index) select 0} else {_source getVariable["gangName",""]};
					_setTag = group _source getVariable["gangTag",""];
					_gangTag = if(_gang == "" && _setTag == "") then {""} else {
						if(_setTag != "") exitWith {_setTag};
						_length = [_gang] call KRON_StrLen;
						_select = false;
						_firstLetter = _gang select [0,1];
						for "_i" from 1 to (_length-1) do {
							_character = _gang select [_i,1];
							if(_select) then {_firstLetter = _firstLetter + _character; _select = false} else {
								if(_character == " ") then {_select = true};
							};
						};
						_tagLength = [_firstLetter] call KRON_StrLen;
						if(_tagLength == 1) then {_firstLetter = _firstLetter + (_gang select[_length - 1,1])};
						if(_firstLetter == "APD") then {_firstLetter = ""};
						_firstLetter;
					};
					_message = _message + format[" by [%1] %2",_gangTag,name _source];
				};
				default {
					_message = _message + format[" by %1",name _source];
				};
			};
		};
[0,_message] remoteExecCall ["life_fnc_broadcast",-2];
[2, player, format["Downed by %1 (%2)", name _source, getPlayerUID _source]] remoteExecCall ["ASY_fnc_logIt",2];
	};

	if(!isNull (player getVariable ["currentlyEscorting", objNull])) then {[] call life_fnc_stopEscorting;};
	
	if(player getVariable ["Escorting",false]) then 
	{
		_escort = (player getVariable ["escorted_by",[objNull,false]]) select 0;
[] remoteExecCall ["life_fnc_stopEscorting",_escort];
	};

	life_isdowned = true;
	player setVariable["downed",true,true];
	player setVariable["receiveFirstAid",false,false];
	
	/*if (vehicle player == player) then {
		_inVehicle = false;
	} else {
		player allowdamage false; player action ["Eject",vehicle player]; [] spawn {sleep 3; player allowDamage true};
		_inVehicle = true;
	};*/
	player setUnconscious true;
	
	disableUserInput true;
	[] spawn { sleep 2; if (userInputDisabled) then { disableUserInput false; sleep 0.1; disableUserInput true; } };
	_hndlBlur = ppEffectCreate ["DynamicBlur", 501];
	_hndlBlur ppEffectEnable true;
	_hndlBlur ppEffectAdjust [5];
	_hndlBlur ppEffectCommit 0;

	_hndlBlack = ppEffectCreate ["colorCorrections", 1501];
	_hndlBlack ppEffectEnable true;
	_hndlBlack ppEffectAdjust [1.0, 1.0, 0.0, [0, 0, 0, 0.9], [1.0, 1.0, 1.0, 1.0],[1.0, 1.0, 1.0, 0.0]];
	_hndlBlack ppEffectCommit 0;
	_effects = true;
	_eff1 = 5;
	_eff2 = 0.9;
	_time = 0;
	_downed = true;
	_dead = false;

	
	while {_downed} do {
		if (player getVariable["receiveFirstAid",false]) exitWith {_downed = false;player setVariable["receiveFirstAid",nil,true];};
		//if(vehicle player == player) then {_inVehicle = false} else {_inVehicle = true};
		if (alive player) then 
		{
			/*if ((vehicle player == player) && {player getVariable["restrained",false]} && {animationState player != "AmovPercMstpSnonWnonDnon_Ease"}) then {
			player playMove "AmovPercMstpSnonWnonDnon_Ease"};*/ //Was a potential fix for moving while downed and restrained, didn't work. ~Gnash
			if ((_vehSource && _time == 5) || (!_vehSource && _time == 60) || player getVariable["adrenaline",false]) exitWith {_downed = false; player setVariable["adrenaline",false]};
		} else 
		{
			_downed = false;
			_dead = true;
		};
		_time = _time + 1;
		sleep 1;
	};
	
	// The below kills pre-downed user input, which would resume on its own if only re-enabled once. ~Gnash
	disableUserInput false;
	disableUserInput true;
	disableUserInput false;
	[_hndlBlur,_hndlBlack,_eff1,_eff2,_effects] spawn {
		_hndlBlur = _this select 0;
		_hndlBlack = _this select 1;
		_eff1 = _this select 2;
		_eff2 = _this select 3;
		_effects = _this select 4;
		while {_effects} do {
			_eff1 = _eff1 - 0.025;
			_eff2 = _eff2 - 0.0045;

			_hndlBlur ppEffectAdjust [_eff1];
			_hndlBlur ppEffectCommit 0;

			_hndlBlack ppEffectAdjust [1.0, 1.0, 0.0, [0, 0, 0, _eff2], [1.0, 1.0, 1.0, 1.0],[1.0, 1.0, 1.0, 0.0]];
			_hndlBlack ppEffectCommit 0;

			sleep 0.01;
			if (_eff2 <= 0) then {_effects = false;};
		};
		ppEffectDestroy _hndlBlur;
		ppEffectDestroy _hndlBlack;
	};
	
	player setUnconscious false;
	if (stance player == "STAND") then {[player,"AidlPercMstpSnonWnonDnon_G01","playNow"] remoteExecCall ["life_fnc_animSync",-2]; }
	else {[player,"AmovPpneMstpSnonWnonDnon","playNow"] remoteExecCall ["life_fnc_animSync",-2]; };
	
	life_isdowned = false;
	player setVariable["downed",false,true];
	disableUserInput false;
	sleep 1;
	disableUserInput false;
};
