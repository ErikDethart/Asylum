/*
	File: fn_clothing_dive.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master configuration file for Altis Diving Shop.
*/
private["_filter","_ret"];
_filter = [_this,0,0,[0]] call BIS_fnc_param;
//Classname, Custom Display name (use nil for Cfg->DisplayName, price

//Shop Title Name
ctrlSetText[3103,"Steve's Diving Shop"];

_ret = [];
switch (_filter) do
{
	//Uniforms
	case 0:
	{
		_ret = 
		[
			["U_B_Wetsuit",nil,200]
		];
	if(life_donator >= 4) then
		{
			_ret set[count _ret,["U_O_Wetsuit",nil,200]];
		};
	};
	
	//Hats
	case 1:
	{
		_ret =
		[
		];
	};
	
	//Glasses
	case 2:
	{
		_ret =
		[
			["G_Diving",nil,50]
		];
	};
	
	//Vest
	case 3:
	{
		_ret =
		[
			["V_RebreatherB",nil,500]
		];
	};
	
	//Backpacks
	case 4:
	{
		_ret =
		[
		];
	};
};
_ret;