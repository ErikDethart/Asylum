/*
	File: fn_colorVehicle.sqf
	Author: John "Paratus" VanderZwet, rewritten by Gnashes
	
	Description:
	Reskins the vehicle
*/
params [
	["_vehicle",Objnull,[Objnull]],
	["_index",-1,[0]]
];
if(isNull _vehicle || !alive _vehicle || _index isEqualTo -1) exitWith {};

//Fetch texture from our present array.
if ((typeOf _vehicle == "C_Van_01_box_F") && (_index == 2)) then {life_veh_shop = "civ_special";};
private _textureList = [(typeOf _vehicle)] call life_fnc_vehicleColorCfg;
private _textureDet = _textureList param[_index,[]];
if(_textureDet isEqualTo []) exitWith {};
_textureDet params [
	["_texture","",[""]],
	"",
	["_texture2","",[""]],
	["_texture3","",[""]],
	["_texture4","",[""]]
];

_vehicle setVariable["Life_VEH_color",_index,true];

{
	if (_x isEqualTo "CHROME") then {
		_vehicle setObjectMaterialGlobal [_forEachIndex,"\A3\data_f\chrome_enviro.rvmat"];
		_vehicle setObjectTextureGlobal [_forEachIndex,'#(argb,8,8,3)color(0,0.7,0.7,0.01)'];
	} else {
		if !(_x isEqualTo "") then {
			_vehicle setObjectTextureGlobal[_forEachIndex,_x];
		};
	};
} forEach [_texture,_texture2,_texture3,_texture4];