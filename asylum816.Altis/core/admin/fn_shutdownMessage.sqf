private["_shell","_bootTime","_bootString","_callUser"];
_callUser = [_this,0,objNull,[objNull]] call BIS_fnc_param;
if (life_isRebooting) exitWith{
[1,"The server is already running a shut down sequence and will ignore your request."] remoteExecCall ["life_fnc_broadcast",_callUser];
["The server is already running a shut down sequence and will ignore your request."] remoteExecCall ["systemChat",_callUser];
};
life_isRebooting = true;
_bootStringSysChat = "The server will shut down for a patch in %1 minute(s)! We recommend that you press Y and click ""SYNC DATA"" now.  The server will only be down for a few minutes. You can find patch notes on the forums at www.gaming-asylum.com.";

[format[_bootStringSysChat, 15]] remoteExecCall ["systemChat",-2];
sleep 300;
[format[_bootStringSysChat, 10]] remoteExecCall ["systemChat",-2];
sleep 300;
[format[_bootStringSysChat, 5]] remoteExecCall ["systemChat",-2];
sleep 240;
[format[_bootStringSysChat, 1]] remoteExecCall ["systemChat",-2];
sleep 60;

[] call DB_fnc_saveVehicles;
