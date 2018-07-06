/*
	File: fn_gangHousePointSelected.sqf
	Author: Gnashes
	
	Description:
	Sorts out the gang house selected and does a map zoom.
*/
disableSerialization;
private["_selector"];
_selector = [_this,0,-1,[0]] call BIS_fnc_param;
if(_selector == -1) exitWith {};


_spCfg = [];
{
	_id = [_x] call life_fnc_getBuildID;
	_spCfg pushBack [format["phouse_%1",_id],format["House %1",(_forEachIndex + 1)]];
} forEach life_ownHouses;

_sp = _spCfg select _selector;
[((findDisplay 48500) displayCtrl 48502),1,0.1,getMarkerPos (_sp select 0)] call life_fnc_setMapPosition;
life_gang_newHouse = _sp;
ctrlSetText[48501,format["New Gang House: %1",_sp select 1]];	