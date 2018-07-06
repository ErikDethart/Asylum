/*
	File: fn_settingsInit.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Initializes key parts for the Settings menu for View distance and other stuff.
*/
tawvd_foot = (profileNamespace getVariable["AsylumSettings",[1200,1200,1200,true,false,0.2]]) select 0;
tawvd_car = (profileNamespace getVariable["AsylumSettings",[1200,1200,1200,true,false,0.2]]) select 1;
tawvd_air = (profileNamespace getVariable["AsylumSettings",[1200,1200,1600,true,false,0.2]]) select 2;
tawvd_addon_disable = true;

{
call compile format["%1 = (profileNamespace getVariable['AsylumSettings2',[1,1,1,1,1,1,1,1,1,1,1,1]]) select %2",_x,_forEachIndex];
} forEach ["Marker_Town","Marker_Cop","Marker_Race","Marker_Illegal","Marker_Reb","Marker_DMV","Marker_Gas","Marker_Legal","Marker_DPs","Marker_Turfs","Marker_Garage","Marker_Misc"];

[]spawn {
	{
		_alpha = switch (MarkerColor _x) do {
			case ("ColorGreen");
			case ("ColorWhite"):{Marker_Town};
			case ("ColorWEST"):{Marker_Cop};
			case ("ColorBrown"):{Marker_Race};
			case ("ColorRed"):{Marker_Illegal};
			case ("ColorEAST"):{Marker_Reb};
			case ("ColorBlue"):{Marker_DMV};
			case ("ColorGUER"):{Marker_Gas};
			case ("ColorYellow");
			case ("ColorCIV"):{Marker_Legal};
			case ("ColorKhaki"):{Marker_DPs};
			case ("ColorUNKNOWN"):{Marker_Turfs};
			case ("ColorOrange"):{Marker_Garage};
			case ("ColorBlack"):{Marker_Misc};
			default {0};
		};
		if (_x find "phouse_" == -1) then {_x setMarkerAlphaLocal _alpha};
	} forEach allMapMarkers;
};
//The hacky method... Apparently if you stall (sleep or waitUntil) with CfgFunctions you stall the mission initialization process... Good job BIS, why wouldn't you spawn it via preInit or postInit?
/*[] spawn
{
	private["_recorded"];
	while {true} do
	{
		_recorded = vehicle player;
		[] call life_fnc_updateViewDistance;
		waitUntil {sleep 5; (_recorded != vehicle player || !alive player)};
	};
};*/
