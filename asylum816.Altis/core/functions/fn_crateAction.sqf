/*
	File: fn_crateAction.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Adds interaction to specified crate.
*/

_crate = [_this,0,objNull,[objNull]] call BIS_fnc_param;

if (isNull _crate) exitWith {};

if (_crate getVariable["containerId", -1] > -1) then
{
	removeAllActions _crate;
	_crate addAction["Item Storage",{[nil,nil,nil,_this select 0] call life_fnc_openInventory},"",0,false,false,"",' (_this distance _target) < 4 && (_target getVariable["containerId", -1] > -1) && (((_target getVariable["house", objNull]) getVariable["life_locked", 1]) == 0 || (_target getVariable["house", objNull] in life_houses || [_target getVariable["house", objNull]] call life_fnc_getBuildID == life_gang)) '];
	_crate addAction["<t color='#FF0000'>Destroy Container</t>",{ [(_this select 0)] call life_fnc_storageSell; },"",0,false,false,"",' (_this distance _target) < 4 && (_target getVariable["containerId", -1] > -1) && ((_target getVariable ["house",objNull]) in life_houses) '];
};

if (isServer) exitWith {};

if ((life_adminlevel > 1) && (playerSide == civilian)) then {
	if (_crate getVariable["house", objNull] in life_houses || [_crate getVariable["house", objNull]] call life_fnc_getBuildID == life_gang) then {
		removeAllActions _crate;
		_crate addAction["Item Storage",{[nil,nil,nil,_this select 0] call life_fnc_openInventory},"",0,false,false,"",' (_this distance _target) < 4 && (_target getVariable["containerId", -1] > -1) && (((_target getVariable["house", objNull]) getVariable["life_locked", 1]) == 0 || (_target getVariable["house", objNull] in life_houses || [_target getVariable["house", objNull]] call life_fnc_getBuildID == life_gang)) '];
		_crate addAction["<t color='#FF0000'>Destroy Container</t>",{ [(_this select 0)] call life_fnc_storageSell; },"",0,false,false,"",' (_this distance _target) < 4 && (_target getVariable["containerId", -1] > -1) && ((_target getVariable ["house",objNull]) in life_houses) '];
		_crate addAction["ATM",life_fnc_atmMenu];
		_crate addAction["EMT Item Shop",life_fnc_virt_menu,"hospital"];
		_crate addAction["Rebel Clothing Shop",life_fnc_clothingMenu,"reb",0,false,false,"",' license_civ_rebel && playerSide == civilian '];  
		_crate addAction["Rebel Weapon Shop",life_fnc_weaponShopMenu,"rebel",0,false,false,"",' license_civ_rebel && playerSide == civilian'];
		_crate addAction["Rebel Market",life_fnc_virt_menu,"rebel",0,false,false,"",' license_civ_rebel && playerSide == civilian'];
		_crate addAction["Bounty Hunter Shop",life_fnc_weaponShopMenu,"bounty",0,false,false,"",'license_civ_bounty && playerSide == civilian && !(126 in life_talents)'];
		_crate addAction["Bounty Hunter Item Shop",life_fnc_virt_menu,"vig",0,false,false,"",' license_civ_bounty && playerSide == civilian && !(126 in life_talents)'];
		_crate addAction["Skiptracer Clothing Shop",life_fnc_clothingMenu,"skip",0,false,false,"",' license_civ_bounty && playerSide == civilian && 126 in life_talents'];
		_crate addAction["Skiptracer Weapon Shop",life_fnc_weaponShopMenu,"skiptracer",0,false,false,"",'license_civ_bounty && playerSide == civilian && (126 in life_talents)'];
		_crate addAction["Skiptracer Item Shop",life_fnc_virt_menu,"skiptracer",0,false,false,"",' license_civ_bounty && playerSide == civilian && (126 in life_talents)'];
		_crate addAction ["Bounty Hunter Training ($6,500) (replace rebel)",life_fnc_buyLicense,"bounty",0,false,false,"",'!license_civ_bounty && playerSide == civilian && (1 in life_talents)'];
		_crate addAction["Rebel Training ($12,500) (replace bounty hunter)",life_fnc_buyLicense,"rebel",0,false,false,"",' !license_civ_rebel && playerSide == civilian && (29 in life_talents) '];
	};
};