/*
	File: fn_menuCheck.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Checks for known cheat menus and closes them then reports them to the server.
*/
//Wookie Menu V1-3 and other Copy-Pasted menu-based cheats.
[] spawn {
	waitUntil {!isNull (findDisplay 3030)};
[profileName,getPlayerUID player,"MenuBasedHack_DISPLAY_3030"] remoteExecCall ["SPY_fnc_cookieJar",2];
[profileName,"Menu Hack: DISPLAY 3030 (Wookie Menu etc)"] remoteExecCall ["SPY_fnc_notifyAdmins",-2];
	sleep 0.5;
	["SpyGlass",false,false] call BIS_fnc_endMission;
};

//Some other old copy-pasted menu/display
[] spawn {
	waitUntil {!isNull ((findDisplay 64) displayCtrl 101)};
[profileName,getPlayerUID player,"MenuBasedHack_DISPLAY_64_C_101"] remoteExecCall ["SPY_fnc_cookieJar",2];
[profileName,"Menu Hack: DISPLAY 64 CONTROL 101"] remoteExecCall ["SPY_fnc_notifyAdmins",-2];
	sleep 0.5;
	["SpyGlass",false,false] call BIS_fnc_endMission;
};

//Lystic's Unreleased menu & Bobby's Unreleased menu (Field Menu, if you are not using my client-side code to disable that button prepare for a lot of false-positives.).
[] spawn {
	waitUntil {!isNull (findDisplay 162)};
[profileName,getPlayerUID player,"MenuBasedHack_DISPLAY_162"] remoteExecCall ["SPY_fnc_cookieJar",2];
[profileName,"Menu Hack: DISPLAY 162 (Lystic & Bobby Menu Hack)"] remoteExecCall ["SPY_fnc_notifyAdmins",-2];
	sleep 0.5;
	["SpyGlass",false,false] call BIS_fnc_endMission;
};

//Another menu-based cheat by Wookie but it can cause false positives so we just close it.
[] spawn {
	while {true} do {
		waitUntil {!isNull (findDisplay 129)};
		closeDialog 0;
	};
};

//Wookie Menu V4-5 and all other copy-pasted ones from it.
[] spawn {
	waitUntil {!isNull (uiNamespace getVariable "RscDisplayRemoteMissions")};
[profileName,getPlayerUID player,"MenuBasedHack_RscDisplayRemoteMissions"] remoteExecCall ["SPY_fnc_cookieJar",2];
[profileName,"Menu Hack: RscDisplayRemoteMissions"] remoteExecCall ["SPY_fnc_notifyAdmins",-2];
	sleep 0.5;
	["SpyGlass",false,false] call BIS_fnc_endMission;
};

//Debug Menu
[] spawn {
	waitUntil {!isNull (uiNamespace getVariable "RscDisplayDebugPublic")};
	closeDialog 0;
[profileName,getPlayerUID player,"MenuBasedHack_RscDisplayDebugPublic"] remoteExecCall ["SPY_fnc_cookieJar",2];
[profileName,"Menu Hack: RscDisplayDebugPublic"] remoteExecCall ["SPY_fnc_notifyAdmins",-2];
	sleep 0.5;
	["SpyGlass",false,false] call BIS_fnc_endMission;
};

// JME
[] spawn {
	while {true} do {
		waitUntil {!isNull (findDisplay 148)};
		sleep 0.5;
		if((lbSize 104)-1 > 3) exitWith {
[profileName,getPlayerUID player,"MenuBasedHack_RscDisplayConfigureControllers"] remoteExecCall ["SPY_fnc_cookieJar",2];
[profileName,"Menu Hack: RscDisplayConfigureControllers (JME 313)"] remoteExecCall ["SPY_fnc_notifyAdmins",-2];
			sleep 0.5;
			["SpyGlass",false,false] call BIS_fnc_endMission;
		};
		closeDialog 0;
	};
};
