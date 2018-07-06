/*
	File: fn_applyCharge.sqf
	Author: John "Paratus" VanderZwet
*/

disableSerialization;
if(lbCurSel 5521 == -1) exitWith {hint "You did not select a charge..."};
if (isNull life_charged || !isPlayer life_charged || !alive life_charged) exitWith {};

_label = lbText[5521,(lbCurSel 5521)];
_charge = lbData[5521,(lbCurSel 5521)];

[life_charged,_charge] remoteExec ["life_fnc_addWanted", 2];

_logCharges = ["can","207","pdm","261","terror","tur","1090","org"];
if (_charge in _logCharges) then {
[50, player, format["Issued charge of %1 to %2(%3)", _label, name life_charged, getPlayerUID life_charged]] remoteExecCall ["ASY_fnc_logIt",2];
};

[1, format["%3 has charged %1 with %2.", [name life_charged] call life_fnc_cleanName, _label, [name player] call life_fnc_cleanName]] remoteExecCall ["life_fnc_broadcast",west];
