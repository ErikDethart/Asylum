/*
	Copyright © 2013 Bryan "Tonic" Boardwine, All rights reserved
	See http://armafiles.info/life/list.txt for servers that are permitted to use this code.
	File: fn_syncData.sqf
	Author: Bryan "Tonic" Boardwine"
	
	Description:
	Used for player manual sync to the server.
*/
_fnc_scriptName = "Player Synchronization";
private["_exit"];
if(isNil "life_session_time") then {life_session_time = false;};
if(life_session_time) exitWith {hint "You have already used the sync option, you can only use this feature once every 5 minutes.";};

[] call life_fnc_sessionUpdate;
hint "Player information synced to the server.";
[] spawn {
	life_session_time = true;
	sleep (5 * 60);
	life_session_time = false;
};
	
