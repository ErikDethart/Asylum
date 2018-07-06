/*
	File: fn_crankSmoke.sqf
	Author: Bamf
	
	Description:
	Toggles a mobile meth (crank) lab on and off
*/

_vehicle = _this;
while {_vehicle getVariable["labMode", false] && alive _vehicle} do {
 if (isNull _vehicle) exitWith {};
 if (vehicle player == _vehicle) then
 {
  player action ["Eject", vehicle player];
  player action ["GetOut", vehicle player];
 };
 _smoke = "test_EmptyObjectForSmoke" createVehicleLocal [0,0,100000];
 _smoke attachTo [_vehicle,[0,0,100000]];
 _smoke attachTo [_vehicle,[0,0,2]];
 _vehicle setHit [getText (configfile >> "CfgVehicles" >> typeOf _vehicle >> "HitPoints" >> "HitEngine" >> "name"), 1];
 sleep 1; 
 deleteVehicle _smoke;
 sleep 4;
 _vehicle setHit [getText (configfile >> "CfgVehicles" >> typeOf _vehicle >> "HitPoints" >> "HitEngine" >> "name"), 0];
};