/*
	File: fn_escortAction.sqf
*/

if (!isNull life_escort) exitWith { hint "You can only escort one person at a time." };

private _unit = param[0,objNull,[objNull]];
if((isNull _unit) || {!isPlayer _unit} || {!(_unit isKindOf "Man")}) exitWith {};
_unit attachTo [player,[0,1,0]];
_unit setVariable["transporting",nil,true];
_unit setVariable["Escorting",true,true];
_unit setVariable["escorted_by",[player,license_civ_bounty],true];
life_escort = _unit;
player setVariable["currentlyEscorting",_unit];
player reveal _unit;
if ((side player == civilian)&&(!(_unit getVariable ["isCivRestrained",false]))) then{[player,"141"] remoteExec ["life_fnc_addWanted", 2];};

[] spawn {
	waitUntil {!isNull objectParent player || attachedTo life_escort != player};
	if(!isNull objectParent player || isNull attachedTo life_escort) then {detach life_escort; life_escort setVariable["Escorting",false,true]};
	life_escort = objNull;
	player setVariable["currentlyEscorting",objnull];
};
