enableSaving [false, false];

BIS_initRespawn_disconnect = -1; // Fix for broken respawn thing
ASY_UsingHeadless = !(isNil "HC1");
X_Server = false;
X_Client = false;
X_JIP = false;
StartProgress = false;

life_versionInfo = "Asylum v8.1.6";

//if (isServer) then { while { !ASY_UsingHeadless && time < 6 } do { ASY_UsingHeadless = !(isNil "HC1"); }; };

diag_log format["Initializing %1 (%2)", life_versionInfo, isServer];

/*if (isServer) then
{
	diag_log format["isServer %1", isServer];
	if (ASY_UsingHeadless) then { waitUntil { (owner HC1) > 0 }; };
	[] call compile PreprocessFileLineNumbers "\life_server\server_init.sqf";
};

if((isServer && !ASY_UsingHeadless) || (ASY_UsingHeadless && !isServer && !hasInterface)) then
{
	if(!X_Server) then
	{
		X_Server = true;
		[] call compile PreprocessFileLineNumbers "core\configuration.sqf";
		[] call compile PreprocessFileLineNumbers "\life_server\init.sqf";
	};
};
if(!isDedicated && hasInterface) then { X_Client = true;};

if(X_Client) then // Not HC
{
	if(isNull player) then
	{
		if(!X_JIP && !isServer) then
		{
			diag_log "Doing JIP stuff";
			[] spawn (compile PreprocessFileLineNumbers "core\jip.sqf");
		};
		X_JIP = true;
	};

	if(X_Client && !isServer) then
	{
		[] execVM "core\init.sqf";
		[] execVM "outlw_magRepack\MagRepack_init_sv.sqf";
	//	[] execVM "zlt_fastrope.sqf";
	};
};*/

if (isServer) then {
	[] call compile PreprocessFileLineNumbers "\life_server\server_init.sqf";
	[] call compile PreprocessFileLineNumbers "core\configuration.sqf";
	[] call compile PreprocessFileLineNumbers "\life_server\init.sqf";
} else {
	[] spawn (compile PreprocessFileLineNumbers "core\jip.sqf");
	[] execVM "core\init.sqf";
	[] execVM "outlw_magRepack\MagRepack_init_sv.sqf";
	[] execVM "briefing.sqf";
	[] spawn {
		waitUntil {!isNil "life_configuration"};  //Wait until life_configuration has populated
		life_groupCap = switch (life_configuration select 12) do {
			case 2:{16};
			case 3:{17};
			case 4:{18};
			default {15};
		};
		_arrestCapFx = switch (life_configuration select 12) do {
			case 1:{1.1};
			case 2:{1.3};
			case 3:{1.5};
			case 4:{2};
			default {1};
		};
		life_arrest_cap = (175000 * _arrestCapFx);
	};
};

enableSaving[false,false];

[] execVM "KRON_Strings.sqf";

//if(!StartProgress) then
//{
//	[3,false,false] execFSM "core\fsm\core_time.fsm";
//};
StartProgress = true;

MISSION_ROOT = format ["mpmissions\__CUR_MP.%1\", worldName];

/* VOIP channel permissions
0 enableChannel false;			// Global
1 enableChannel [true, false];	// Side
2 enableChannel false;			// Command
3 enableChannel true;			// Group
*/
/*
    https://feedback.bistudio.com/T117205 - disableChannels settings cease to work when leaving/rejoining mission
    Universal workaround for usage in a preInit function. - AgentRev
    Remove if Bohemia actually fixes the issue.
*/
{
    _x params [["_chan",-1,[0]], ["_noText","false",[""]], ["_noVoice","false",[""]]];

    _noText = [false,true] select ((["false","true"] find toLower _noText) max 0);
    _noVoice = [false,true] select ((["false","true"] find toLower _noVoice) max 0);

    _chan enableChannel [!_noText, !_noVoice];

} forEach getArray (missionConfigFile >> "disableChannels");