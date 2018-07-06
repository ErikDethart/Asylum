/* 
	File: fn_useShank.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Shanked!
*/
private _unit = param [0,objNull,[objNull]];

if (player distance (getMarkerPos "jail_marker2") > 70) exitWith { hint "You can't use this outside of prison!" };
if (time - life_last_shank < (60 * 3)) exitWith { hint "You can only shank someone every 3 minutes!" };
if (isNull _unit) exitWith {};
if (player distance _unit > 2) exitWith {};
if (life_inv_shank < 1) exitWith {};
if (_unit getVariable ["downed",false]) exitWith {};

life_last_shank = time;
[player] remoteExec ["life_fnc_handleDowned",_unit];
[[0,1,2],format["You've been shanked by %1!", [profileName] call life_fnc_cleanName]] remoteExecCall ["life_fnc_broadcast",_unit];
