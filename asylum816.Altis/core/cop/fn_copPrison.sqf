/*
	File: fn_copPrison.sqf
	Author: John "Paratus" VanderZwet

	Description:
	If possible, queries cop for going to prison defense
*/
if (player in (list prison_area)) exitWith {};
life_confirm_response = false;
private _startPos = getPosATL player;
private _start = time;

if !(isNull objectParent player) then {
	hint "A prison break is in progress. Exit your vehicle to be able to report for guard duty!";
};

waitUntil {(time - _start > 45) || (isNull objectParent player)};
if (time - _start > 45) exitWith {};

private _handle = ["<t align='center'>A prison break is in progress. Report for guard duty? You have 45 seconds.</t>"] spawn life_fnc_confirmMenu;
waitUntil {scriptDone _handle};
if(!life_confirm_response) exitWith {};

if (time - _start > 45) exitWith { hint "You took too long to respond for prison guard duty." };

_spawnId = ceil (random 4);
player setPosATL (getPosATL (call compile format["prison_cop_%1", _spawnId]));
[0,format["%1 reported for prison guard duty.", profileName]] remoteExecCall ["life_fnc_broadcast",west];

waitUntil { !alive player || !life_prison_inProgress };
if (alive player) then {
	private _handle = ["<t align='center'>The prison break has ended. Would you like to exit the area?</t>"] spawn life_fnc_confirmMenu;
	waitUntil {scriptDone _handle};
	if(life_confirm_response) then { player setPosATL (getPosATL prison_teleport); };
};
