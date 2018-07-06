/*
	File: fn_adminConfirm.sqf
	Author: Gnashes
	
	Description:
	This needs a description about as much as Mitch needs glasses.
*/
_type = [_this,0,0,[0]] call BIS_fnc_param;

_text = switch (_type) do {
	case 0:{"patch"};
	case 1:{"hard restart"};
	case 2:{"soft restart"};
	default{""};
};
if (_text == "") exitWith {};

_handle = [format["Are you sure you want to %1 this server? ", _text]] spawn life_fnc_confirmMenu;
waitUntil {scriptDone _handle};
if(!life_confirm_response) exitWith {};


switch (_type) do {
	case 0:{[player] remoteExec ["ASY_fnc_patchServer",2];};
	case 1:{[player] remoteExec ["ASY_fnc_hardRestart",2];};
	case 2:{};
	default{};
};