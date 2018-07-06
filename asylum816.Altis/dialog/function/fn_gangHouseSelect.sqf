/*
	File: fn_gangHouseSelect.sqf
	Author: Gnashes
	
	Description:
	Initializes the gang house selection menu.
*/
private["_spCfg","_sp","_menu","_from"];

disableSerialization;

if(!(createDialog "life_gangHouse_selection")) exitWith {};
(findDisplay 48500) displaySetEventHandler ["keyDown","_this call life_fnc_displayHandler"];

_spCfg = [];

{
	_id = [_x] call life_fnc_getBuildID;
	_spCfg pushBack [format["phouse_%1",_id],format["House %1",(_forEachIndex + 1)]];
} forEach life_ownHouses;

if (count _spCfg < 1) then
{
	ctrlShow[48520,false];
}
else
{
	_menu = (findDisplay 48500) displayCtrl 48520;
	lbClear _menu;
	_from = 0;
	(_menu) ctrlSetEventHandler ["LBSelChanged","[(lbCurSel 48520)] call life_fnc_gangHousePointSelected"];
	
	for "_i" from _from to (count _spCfg)-1 do
	{
		_menu lbAdd ((_spCfg select _i) select 1);
		_menu lbSetData [(lbSize _menu)-1,((_spCfg select _i) select 0)];
	};
};

/*for "_i" from 0 to (count _spCfg)-1 do
{
	_ctrl = ((findDisplay 48500) displayCtrl ((call compile format["4851%1",_i])));
	_ctrl ctrlSetText ((_spCfg select _i) select 1);
};*/

_sp = _spCfg select 0; //First option is set by default
ctrlSetFocus ((findDisplay 48500) displayCtrl 48520);

[((findDisplay 48500) displayCtrl 48502),1,0.1,getMarkerPos (_sp select 0)] call life_fnc_setMapPosition;
life_gang_newHouse = _sp;

ctrlSetText[48501,format["New Gang House: %1",_sp select 1]];
