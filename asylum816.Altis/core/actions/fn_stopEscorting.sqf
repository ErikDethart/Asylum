/*
	File: fn_stopEscorting.sqf

	Description:
	ASFSDFHAGFASF
*/
private["_escortee"];

_escortee = life_escort;

if(isNull _escortee) exitWith {}; //Not valid
if(!(_escortee getVariable ["Escorting",false])) exitWith {}; //He's not being Escorted.
_escortee setVariable["Escorting",nil,true];
detach _escortee;
player setVariable["currentlyEscorting",nil];
life_escort = objnull;
//[45, player, format["Stopped escorting %1", name _escortee]] remoteExecCall ["ASY_fnc_logIt",2];

/*if(playerSide == civilian) then 
{
[] remoteExecCall [life_fnc_escortCheck, _escortee];
};*/
