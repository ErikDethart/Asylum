/*
	File: fn_arrestAction.sqf
	
	Description:
	Arrests the targeted person.
*/
private["_unit","_id","_jail","_markers","_result"];

_unit = cursorTarget;
if(isNull _unit) exitWith {}; //Not valid
if(isNil "_unit") exitwith {}; //Not Valid
if(!(_unit isKindOf "Man")) exitWith {}; //Not a unit
if(!isPlayer _unit) exitWith {}; //Not a human
if(!(_unit getVariable ["restrained",false])) exitWith {systemChat "You cannot send this person to prison without their being restrained."}; //He's not restrained.
if(!((side _unit) in [civilian,independent])) exitWith {systemChat "Only civilians may be sent to prison."}; //Not a civ
if(playerSide == civilian && !(_unit getVariable ["isCivRestrained",false])) exitWith {systemChat "You cannot send players restrained by a cop to jail."};

_handle = [format["<t align='center'>Are you sure you want to send %1 to jail?</t>", [name _unit] call life_fnc_cleanName]] spawn life_fnc_confirmMenu;
waitUntil {scriptDone _handle};
if(!life_confirm_response) exitWith {};

if (life_action_in_use) exitWith { systemChat "You are already performing an action."; };
if (playerSide != west && (count life_bounty_contract) < 1) exitWith { hint "You do not have an active bounty hunting task."; };
if (playerSide != west && !((getPlayerUID _unit) in life_bounty_uid)) exitWith { hint "You cannot arrest this person as you are not tasked to their bounty."; };
_exit = false;
if(playerSide == civilian) then {_unit setVariable["arrest",player,true]};
_isInterrogate = ({player distance2D getMarkerPos _x < 15} count ["marker_606","marker_609"] > 0 && 22 in life_honortalents && 126 in life_talents);
_isSkiptracer = ({player distance2D getMarkerPos _x < 15} count ["marker_607","marker_608"] > 0 && 11 in life_honortalents && 126 in life_talents);
//life_action_in_use = true;
_success = false;
if(_isInterrogate || _isSkiptracer) then {
	"You are currently being processed by the skiptracer bounty hunter... Please wait" remoteExecCall ["hintC",_unit];
	disableSerialization;
	5 cutRsc ["life_progress","PLAIN"];
	_ui = uiNameSpace getVariable "life_progress";
	_progress = _ui displayCtrl 38201;
	_pgText = _ui displayCtrl 38202;
	_pgText ctrlSetText "Regearing, please wait.";
	_progress progressSetPosition 0.01;
	_cP = 0.01;
	_startPos = getPos player;
	titleText[format["You must stay within 100 meters while arresting %1",[name _unit] call life_fnc_cleanName],"PLAIN"];
	while{true} do {
		hintSilent format["Distance from facility: %1 meters",round (player distance _startPos)];
		sleep 0.9;
		_cP = _cP + 0.005;
		_progress progressSetPosition _cP;
		_pgText ctrlSetText format["%3 %4 (%1%2)",round(_cP * 100),"%",if(_isInterrogate) then {"Interrogating"} else {"Arresting"},[name _unit] call life_fnc_cleanName];
		if(_cP >= 1) exitWith {_success = true};
		if(player distance _startPos > 100 || isNull _unit || !alive _unit || !(_unit getVariable["restrained",false]) || player getVariable["restrained",false] || _unit distance _startPos > 30) exitWith {titletext["The arresting process has failed!","PLAIN"]};
	};
	5 cutText ["","PLAIN"];
} else {_success = true};
if(!_success) exitWith {};
if (playerSide == civilian) then
{
	life_experience = life_experience + 150;
	life_arrested_uid pushBackUnique (getPlayerUID _unit);
	[getPlayerUID _unit] spawn life_fnc_removeBounty;
	
	_friends = [units group player, {player distance _x < 100 && _x != player}] call BIS_fnc_conditionalSelect;
	_result = false;
	if (count _friends > 0) then
	{
		_result = ["We see you have a friend with you. Would you like to share the reward from this bounty with your friends?", "Share Bounty Reward", "Share It", "No, I'm Greedy!"] call BIS_fnc_guiMessage;
	};
	if(_unit getVariable["arrest",player] != player) exitWith {hint "Multiple arrest dupe/exploit attempt detected"; _exit = true};
[_unit,player,false,_result] remoteExecCall ["life_fnc_wantedBounty",2];
}
else
{
	life_experience = life_experience + 170;
[_unit,player,false] remoteExecCall ["life_fnc_wantedBounty",2];
};
_unit setVariable["arrest",nil,true];
if(_exit) exitWith {}:
detach _unit;
[false,_isSkiptracer,_isInterrogate,player] remoteExecCall ["life_fnc_jail",_unit];
[0,format["%1 was arrested by %2", name _unit, name player]] remoteExecCall ["life_fnc_broadcast",-2];
//[199, player, format["%1(%3) arrested %2(%4)", profileName, name _unit,playerSide,getPlayerUID _unit]] remoteExecCall ["ASY_fnc_logIt",2];

//life_action_in_use = false;

["BountyUpdate",[format["You have arrested %1. Good work.", [name _unit] call life_fnc_cleanName]]] call BIS_fnc_showNotification;