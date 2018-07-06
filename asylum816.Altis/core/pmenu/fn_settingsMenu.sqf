/*
	File: fn_settingsMenu
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Setup the settings menu.
*/
private["_page"];
_page = param [0,1,[0]];

switch (_page) do {
	case (2):{
		if(isNull (findDisplay 29200)) then
		{
			if(!createDialog "ClientSettingsPg2") exitWith {hint "Something went wrong, the menu won't open?"};
		};
		[] spawn {
			waitUntil {isNull (findDisplay 29200)};
			profileNamespace setVariable["AsylumSettings2",[Marker_Town,Marker_Cop,Marker_Race,Marker_Illegal,Marker_Reb,Marker_DMV,Marker_Gas,Marker_Legal,Marker_DPs,Marker_Turfs,Marker_Garage,Marker_Misc]];
		};
		disableSerialization;
		//Setup Sliders range
		{ slidersetRange [_x,0,1];} foreach [29201,29202,29203,29204,29205,29206,29207,29208,29209,29210,29211,29212];
		//Setup Sliders speed
		{ ((findDisplay 2900) displayCtrl _x) sliderSetSpeed [0.01,0.01,0.01]; } foreach [29201,29202,29203,29204,29205,29206,29207,29208,29209,29210,29211,29212];
		//Setup Sliders position
		{
			sliderSetPosition[_x select 0, _x select 1];
		} foreach [[29201,Marker_Town],[29202,Marker_Cop],[29203,Marker_Race],[29204,Marker_Illegal],[29205,Marker_Reb],[29206,Marker_DMV],[29207,Marker_Gas],[29208,Marker_Legal],[29209,Marker_DPs],[29210,Marker_Turfs],[29211,Marker_Garage],[29212,Marker_Misc]];
	};
	default {
		if(isNull (findDisplay 2900)) then
		{
			if(!createDialog "ClientSettings") exitWith {hint "Something went wrong, the menu won't open?"};
		};
		[] spawn {
			waitUntil {isNull (findDisplay 2900)};
			profileNamespace setVariable["AsylumSettings",[tawvd_foot,tawvd_car,tawvd_air,life_ringer,life_adminReq,life_volume]];
		};
		disableSerialization;
		
		ctrlSetText[2902, format["%1", tawvd_foot]];
		ctrlSetText[2912, format["%1", tawvd_car]];
		ctrlSetText[2922, format["%1", tawvd_air]];
		ctrlSetText[2932, format["%1%2", round(life_volume * 100),"%"]];
		if(life_adminlevel < 3) then {ctrlShow[1337,false]};
		//Setup Sliders range
		{ slidersetRange [_x,100,12000];} foreach [2901,2911,2921];
		{ slidersetRange [_x,0.01,1];} foreach [2931];
		//Setup Sliders speed
		{ ((findDisplay 2900) displayCtrl _x) sliderSetSpeed [100,100,100]; } foreach [2901,2911,2921];
		{ ((findDisplay 2900) displayCtrl _x) sliderSetSpeed [0.01,0.01,0.01]; } foreach [2931];
		//Setup Sliders position
		{
			sliderSetPosition[_x select 0, _x select 1];
		} foreach [[2901,tawvd_foot],[2911,tawvd_car],[2921,tawvd_air],[2931,life_volume]];
		
		private["_display","_side","_tags"];
		_display = findDisplay 2900;
		_ringer = _display displayCtrl 2926;
		_admin = _display displayCtrl 1337;
		_side = _display displayCtrl 1338;
		_envSound = _display displayCtrl 1340;
		_tags = _display displayCtrl 2925;
		
		if(isNil "life_ringer") then 
		{
			(profileNamespace getVariable["AsylumSettings",[1200,1200,1600,true,false,0.2]]) select 3;
		};
		
		if(life_ringer) then
		{
			_ringer ctrlSetTextColor [0,1,0,1];
			_ringer ctrlSetText "Ringer ON";
		}
			else
		{
			_ringer ctrlSetTextColor [1,0,0,1];
			_ringer ctrlSetText "Ringer OFF";
		};
		
		if(life_sidechat) then
		{
			_side ctrlSetTextColor [0,1,0,1];
			_side ctrlSetText "Sidechat ON";
		}
			else
		{
			_side ctrlSetTextColor [1,0,0,1];
			_side ctrlSetText "Sidechat OFF";
		};
		
		if(environmentEnabled select 1) then
		{
			_envSound ctrlSetTextColor [0,1,0,1];
			_envSound ctrlSetText "Environment Sounds ON";
		}
			else
		{
			_envSound ctrlSetTextColor [1,0,0,1];
			_envSound ctrlSetText "Environment Sounds OFF";
		};
		
		if(life_adminReq) then {_admin ctrlSetTextColor [1,0,0,1]; _admin ctrlSetText "Admin Requests OFF"} else {_admin ctrlSetTextColor [0,1,0,1]; _admin ctrlSetText "Admin Requests ON"};
		//if(life_createVehicle) then {_vehicle ctrlSetTextColor [0,1,0,1]; _vehicle ctrlSetText "Drop Items ON"} else {_vehicle ctrlSetTextColor [1,0,0,1]; _vehicle ctrlSetText "Drop Items OFF"};
	};
};