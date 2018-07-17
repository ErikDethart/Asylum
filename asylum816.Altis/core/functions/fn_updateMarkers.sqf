/*
	File: fn_updateMarkers.sqf
	Author: Gnashes
	
	Description:
	Changes settings of selected markers from the settings menu.
*/
params[
	["_color",[],[[]]],
	["_value",1,[0]]
];

{
	if ((getMarkerColor _x) in _color) then {
		if (_x find "_USER_DEFINED" == -1) then { //exclude user markers
			if (_x find "phouse_" == -1) then { //exclude house markers
				if (_x find "bounty_" == -1) then { //exclude bounty hunter markers
					_x setMarkerAlphaLocal _value;
				};
			};
		};
	};
} forEach allMapMarkers;