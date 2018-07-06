/*
	File: fn_playerTags.sqf
	Author: John "Paratus" VanderZwet & Bryan "Tonic" Boardwine
	Description:
	Adds the tags above other players heads when close and have visible range.
*/

private["_ui","_units","_masks","_text"];

disableSerialization;

if(visibleMap OR {!alive player} OR {dialog}) exitWith {
	500 cutText["","PLAIN"];
};

if ((life_adminxray == 1) && {life_adminLevel > 1}) then {
	{
		if (isPlayer _x) then {
			 _pos = visiblePosition _x;
			 _pos set[2,(getPosATL _x select 2) + 2.2];
			 _name = _x getVariable['life_name', [name _x] call life_fnc_cleanName];
			drawIcon3D ["",[1,1,1,1],_pos,0,0,0,_name,0,0.04];
		};
	} forEach allUnits;
} else {

	_ui = uiNamespace getVariable ["Life_HUD_nameTags",displayNull];
	if(isNull _ui) then {
		500 cutRsc["Life_HUD_nameTags","PLAIN"];
		_ui = uiNamespace getVariable ["Life_HUD_nameTags",displayNull];
	};

	if (life_targetTag) then
	{
		if (!isNull cursorTarget && {cursorTarget isKindOf "Man" || cursorTarget isKindOf "Car" || cursorTarget isKindOf "Air" || cursorTarget isKindOf "Ship"} && {!(cursorTarget in life_tag_units)}) then
		{
			life_tag_units pushBack cursorTarget;
		};
	};

	{
		_idc = _ui displayCtrl (78000 + _forEachIndex);

		if (!(lineIntersects [eyePos player, eyePos _x, player, _x]) && alive _x) then
		{
			_pos = [visiblePosition _x select 0, visiblePosition _x select 1, ((_x modelToWorld (_x selectionPosition "head")) select 2)+.5];
			_sPos = worldToScreen _pos;
			_distance = _pos distance player;
			_maxDistance = if (goggles _x in life_masks) then { 5 } else { 20 };
			_hidden = ((goggles _x in life_masks) && (_distance > _maxDistance));

			if (count _sPos > 1 && !(_x getVariable["isInvisible",false]) && {(_distance <= _maxDistance) || {life_targetTag && _x == cursorTarget}}) then
			{
				if !(!(_x isKindOf "Man") && count (crew _x) == 0) then
				{
					_icon = switch (true) do
					{
						case !(_x isKindOf "Man"): { format["<img image='%1' size='1'></img>  ", getText (configFile >> "CfgVehicles" >> typeOf _x >> "picture")] };
						case (side _x == independent): { "<img image='a3\ui_f\data\map\MapControl\hospital_ca.paa' color='#FF0000' size='1'></img>  " };
						case (side _x == west):
						{
							switch (_x getVariable["copLevel", 0]) do
							{
								case (1) : {format["<img image='%1' size='1'></img>  ", [0,"texture"] call BIS_fnc_rankParams]};
								case (2) : {format["<img image='%1' size='1'></img>  ", MISSION_ROOT + "icons\pfc_gs.paa"]};
								case (3) : {format["<img image='%1' size='1'></img>  ", [1,"texture"] call BIS_fnc_rankParams]};
								case (4) : {format["<img image='%1' size='1'></img>  ", [2,"texture"] call BIS_fnc_rankParams]};
								case (5) : {format["<img image='%1' size='1'></img>  ", [3,"texture"] call BIS_fnc_rankParams]};
								case (6) : {format["<img image='%1' size='1'></img>  ", [4,"texture"] call BIS_fnc_rankParams]};
								default { "" };
							};
						};
						case (_x getVariable["activeBounty", false]): { format["<img image='%1icons\police.paa' size='1'></img>  ", MISSION_ROOT] };
						case (getPlayerUID _x == (life_configuration select 0)): { format["<img image='%1icons\govern.paa' color='#FF0000' size='1'></img>  ", MISSION_ROOT] };
						default { "" };
					};

					_text = switch (true) do
					{
						case !(_x isKindOf "Man"):
						{
							_text = [];
							{
								_extra = if (_forEachIndex > 0) then {", "} else {""};
								if ((goggles _x in life_masks) && (_distance > _maxDistance)) then {
									if ((currentWeapon player == "binocular" && {cameraView == "Gunner"}) || (_x in (units group player))) then {
										_text pushBack (format["%1%2",_extra,(_x getVariable['life_name', [name _x] call life_fnc_cleanName])])
										} else {
										_text pushBack (format["%1Unknown",_extra]);
									};
								} else {
									_text pushBack (format["%1%2",_extra,(_x getVariable['life_name', [name _x] call life_fnc_cleanName])])
								};
							} forEach (crew _x);
							_text
						};
						case (_hidden):
						{
							if ((_x in (units group player)) || (currentWeapon player == "binocular" && {cameraView == "Gunner"})) then {_x getVariable['life_name', [name _x] call life_fnc_cleanName]} else {"Unknown"};
						};
						case (side _x == west):
						{
							switch (_x getVariable["copLevel", 0]) do
							{
								case (1) : {format["Police Cadet %1", _x getVariable['life_name', [name _x] call life_fnc_cleanName]]};
								case (2) : {format["Police Constable %1", _x getVariable['life_name', [name _x] call life_fnc_cleanName]]};
								case (3) : {format["Police Corporal %1", _x getVariable['life_name', [name _x] call life_fnc_cleanName]]};
								case (4) : {format["Police Sergeant %1", _x getVariable['life_name', [name _x] call life_fnc_cleanName]]};
								case (5) : {format["Police Lieutenant %1", _x getVariable['life_name', [name _x] call life_fnc_cleanName]]};
								case (6) : {format["Police Captain %1", _x getVariable['life_name', [name _x] call life_fnc_cleanName]]};
								default {_x getVariable['life_name', _x getVariable['life_name', [name _x] call life_fnc_cleanName]] };
							};
						};
						default {_x getVariable['life_name', [name _x] call life_fnc_cleanName]};
					};
					if !(_hidden) then {
						if (_x getVariable ["life_title",""] != "") then { _text = format[_x getVariable "life_title", _text]; };
						if(!isNil {_x getVariable "gangName"}) then { _text = format["%1<br/><t size='0.8' align='center' color='#B6B6B6'>%2</t>", _text, _x getVariable "gangName"]; };
					};
					
					_color = switch (true) do
					{
						case !(_x isKindOf "Man"):
						{
							_color = [];
							{
								_vcolor = switch (true) do {
									case((_x getVariable ["gang","0"]) in life_gang_wars || (_x getVariable ["aggressive",-300]) > (time - 300)):{"FF0000"};
									case(_x in (units group player) && playerSide == civilian):{"00FF00"};
									default {"FFFFFF"};
								};
								_color pushBack _vcolor;
							} forEach crew _x;
							_color
						};
						case (_x in (units group player) && playerSide == civilian): {"00FF00"};
						case (!isPlayer _x && {_x isKindOf "Man"}): {"CCCCCC"};
						case ((_x isKindOf "Man") && {(_x getVariable ["gang","0"]) in life_gang_wars || (_x getVariable ["aggressive",-300]) > (time - 300)}): { "FF0000" };
						default {
							switch (_x getVariable ["life_title",""]) do
							{
								case "The Prominent %1": { "999900" };
								case "Tycoon %1": { "CCCC00" };
								case "The Eminent %1": { "FFFF00" };
								case "%1 the Punisher": { "9E8080" };
								case "Gang Wars V Winner %1": {"B000FF"};
								default { "FFFFFF" };
							};
						};
					};

					_nameTag = switch (true) do {
						case !(_x isKindOf "Man"):
						{
							_xNameTag = format["<t align='center'>%1",_icon];
							{
								_xNameTag = _xNameTag + format["<t color='#%2'>%1</t>",_x ,_color select _forEachIndex];
							} forEach _text;
							format["%1</t>",_xNameTag];
						};
						default {format["<t align='center'>%3<t color='#%2'>%1</t></t>", _text, _color, _icon]}
					};

					_idc ctrlSetStructuredText parseText _nameTag;
					_idc ctrlSetPosition [(_sPos select 0) - 0.27, _sPos select 1];
					_idc ctrlSetScale 0.9;
					_idc ctrlSetFade 0;
					_idc ctrlCommit 0;
					_idc ctrlShow true;
				}
				else
				{
					_idc ctrlShow false;
				};
			}
			else
			{
				_idc ctrlShow false;
			};
		}
		else
		{
			_idc ctrlShow false;
		};
	} foreach life_tag_units;

	if (count life_tag_cache > count life_tag_units) then
	{
		for "_i" from (count life_tag_units) to (count life_tag_cache)-1 do
		{
			_idc = _ui displayCtrl (78000 + _i);
			_idc ctrlShow false;
		};
	};
};