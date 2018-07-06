/*
	File: fn_crimeRecord.sqf
	Author: John "Paratus" VanderZwet

	Description:
	Populate list of online people for criminal history.
*/

private ["_display","_playerList"];

createDialog "crimerecord_menu";
disableSerialization;
waitUntil {!isNull (findDisplay 3900)};

_display = findDisplay 3900;
_playerList = _display displayCtrl 3901;

{
	//if (side _x != west) then
	//{
		_playerList lbAdd (name _x);
		_playerList lbSetdata [(lbSize _playerList)-1, getPlayerUID _x];
	//};
} forEach allPlayers;

lbSort _playerList;

/*if(((lbSize _playerList)-1) == -1) then
{
	_playerList lbAdd "No criminals";
};*/