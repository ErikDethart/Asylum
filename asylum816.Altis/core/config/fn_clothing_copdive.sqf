/*
	File: fn_clothing_copdive.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master configuration file for Altis Diving Shop.
*/
private["_filter"];
_filter = [_this,0,0,[0]] call BIS_fnc_param;
//Classname, Custom Display name (use nil for Cfg->DisplayName, price

//Shop Title Name
ctrlSetText[3103,"Cop Diving Shop"];

_ret = [];
switch (_filter) do
{
	//Uniforms
	case 0:
	{
		_ret = 
		[
			["U_B_Wetsuit",nil,1000]
		];
		if ((life_donator >= 4) && (life_coprole in ["detective","all"])) then
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
			["G_Diving",nil,150]
		];
	};
	
	//Vest
	case 3:
	{
		_ret =
		[
			["V_RebreatherB",nil,1000]
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