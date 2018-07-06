/*
	File: fn_robPerson.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Getting tired of adding descriptions...
*/
private["_robber","_robbed"];
_robber = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_yMenu = param[1,false,[false]];
_pistol = param[2,false,[false]];
if(isNull _robber) exitWith {}; //No one to return it to?

_robbed = life_money;

_isPred = false;
if (_yMenu || _pistol) then {_isPred = true};

hint format["%1 has just robbed you of $%2!", name _robber, [_robbed] call life_fnc_numberText];

if(_robbed > 0) then
{
	["cash","set",0] call life_fnc_updateMoney;
};
[_robbed,player,_isPred] remoteExecCall ["life_fnc_robReceive",_robber];
[129, player, format["Was robbed by %1(%2) for $%3", name _robber, getPlayerUID _robber, [_robbed] call life_fnc_numberText]] remoteExecCall ["ASY_fnc_logIt",2];

if(_yMenu) then {[player,true,life_in_vehicle] call life_fnc_dropItems};
if(_pistol) then {
	_items = [handgunWeapon player];
	player removeWeapon handgunWeapon player;
	{if(["grenade",_x] call BIS_fnc_inString) then {_items pushBack _x; player removeMagazine _x}} forEach magazines player;
	_weaponHolder = createVehicle["WeaponHolderSimulated",getPosATL player,[],0,"CAN_COLLIDE"];
	{_weaponHolder addItemCargoGlobal [_x,1]} forEach _items;
};
