/*
	File: fn_filterChat.sqf
	Author: John "Paratus" VanderZwet & Animusx
	
	Description:
	Intercept chat command from client
*/

_unit = _this select 0; 
_msg = _this select 1; 

if (_unit != player) exitWith {};
if ((_msg call aniChatEvents_strlen) > 3) then
{
	_trigger = [_msg, 0, 2] call aniChatEvents_substr;
	_trigger = tolower(_trigger);
	if ((_trigger == "#9") && (([_msg, 0, 4] call aniChatEvents_substr) == "#911")) then {_trigger = "#911"};
	if (_trigger != "#t" && _trigger != "#r" && _trigger != "#911") exitWith{};
	switch (_trigger) do
	{
		case ("#t"):
		{
			_filtered = [_msg, 3] call aniChatEvents_substr;
			_nameEnd = -1;
			_filteredArray = toArray _filtered;
			{
				if (_x == 32) exitWith { _nameEnd = _forEachIndex; };
			} forEach _filteredArray;
			if (_nameEnd < 0) exitwith {};
			_recipient = [_filtered, 0, _nameEnd] call aniChatEvents_substr;
			_message = [_filtered, _nameEnd + 1] call aniChatEvents_substr;
			if ((_message call aniChatEvents_strlen) > 0) then
			{
				_to = objNull;
				_recipientLow = ([_recipient] call KRON_StrLower);
				{
					if (([(name _x)] call KRON_StrLower) == _recipientLow) then { _to = _x; };
				} forEach allPlayers;
				if (isNull _to) exitWith {};
[_message,name player,0] remoteExecCall ["life_fnc_clientMessage",_to];
				systemChat format["You sent %1 a message: %2",name _to,_message];
			};
		};
		case ("#r"):
		{
			if (!isNil "life_last_message") then
			{
				_message = [_msg, 3] call aniChatEvents_substr; 
				if ((_message call aniChatEvents_strlen) > 0) then
				{
					_to = objNull;
					_recipientLow = ([life_last_message] call KRON_StrLower);
					{
						if (([(name _x)] call KRON_StrLower) == _recipientLow) then { _to = _x; };
					} forEach allPlayers;
					if (isNull _to) exitWith {systemChat format["%1's cell phone is turned off.", life_last_message]};
[_message,name player,0] remoteExecCall ["life_fnc_clientMessage",_to];
					systemChat format["You sent %1 a message: %2",name _to,_message];
				};
			}
			else
			{
				systemChat "You can't reply when nobody has texted you yet.  Are you lonely?";
			};
		};
		case ("#911"):
		{
			_filtered = [_msg, 4] call aniChatEvents_substr;
			_message = [_filtered, 1] call aniChatEvents_substr;
			if ((_message call aniChatEvents_strlen) > 0) then
			{
[_message,name player,1] remoteExecCall ["life_fnc_clientMessage",west];
[[name player] call life_fnc_cleanName, position player] remoteExec ["life_fnc_createMarker",west];
[ceil (random 5000), format["%1 911: %2", [name player] call life_fnc_cleanName, _msg], 1500, 8, 2, position player, getPlayerUID player] remoteExecCall ["life_fnc_createDispatch",2];
				systemChat format["You sent the Police a message: %1",_message];
			};
		};
	};
};
