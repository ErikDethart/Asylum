/*
	File: fn_gangChanged.sqf
	Author: Gnashes
	
	Description:
	Removes player from their existing gangID and adds them to their new gangID
*/

params [
	["_gang","",[""]],
	["_newGang","",[""]]
];

{ if (_x == _gang) then {life_gang_wars set[_forEachIndex,_newGang]};} forEach life_gang_wars;

if (_gang == life_gang) then {
	closeDialog 0;
	_index = life_houses findIf {(str(_x) find life_gang) != -1};
	
	if !((life_gangHouse select 0) in life_ownHouses) then {
		if (_index != -1) then {
			deleteMarkerLocal format["phouse_%1", life_gang];
			life_houses deleteAt _index;
		};
	};
	
	life_gang = _newGang;
	player setVariable ["gang", life_gang, true];
	player setVariable ["gangGroup", nil, true];
	
	_id = (parseNumber life_gang);
	_newHouse = (getPos player nearestObject _id);
	life_gangHouse_pos = (getPos _newHouse);
	life_gangHouse set[0, _newHouse];
	if !((life_gangHouse select 0) in life_ownHouses) then {
		_marker = createMarkerLocal [format["phouse_%1", _id], getPos _newHouse];
		_marker setMarkerTextLocal getText(configFile >> "CfgVehicles" >> (typeOf _newHouse) >> "displayName");
		_marker setMarkerShapeLocal "ICON"; 
		_marker setMarkerColorLocal "ColorBlue";
		_marker setMarkerTypeLocal "mil_end";
		life_houses pushBack (life_gangHouse select 0);
	};
	[[0,1], "Your gang has moved to a new house!"] call life_fnc_broadcast;
	[] call life_fnc_sessionUpdate;
};