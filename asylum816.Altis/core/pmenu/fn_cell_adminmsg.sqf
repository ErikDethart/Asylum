if(life_adminlevel < 2) exitWith {hint "You are not an admin!";};
private["_msg","_to"];
_msg = ctrlText 3003;
_to = call compile format["%1",(lbData[3004,(lbCurSel 3004)])];
if(isNull _to) exitWith {};
if(_msg == "") exitWith {hint "You must enter a message to send!";};

[_msg,name player,3] remoteExecCall ["life_fnc_clientMessage",_to];
[] call life_fnc_cellphone;
hint format["Admin Message Sent To: %1 - Message: %2",[name _to] call life_fnc_cleanName,_msg];
[810, _to, format["Admin Messaged by %1(%2) - %3", [name player] call life_fnc_cleanName, getPlayerUID player, _msg]] remoteExecCall ["ASY_fnc_logIt",2];
