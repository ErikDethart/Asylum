/*
	File: fn_spikeStrip.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Creates a spike strip and preps it.
*/
if (vehicle player isKindOf "Air") exitWith {hint "That's a touch dangerous to try, don't you think?"};
private _spikeStrip = "Land_Razorwire_F" createVehicle [0,0,0];
sleep 1;
_spikeStrip setDamage 1;
_spikestrip hideObjectGlobal true;
private _dir = getDir (vehicle player);

if (isNull objectParent player) then { _spikeStrip attachTo[player,[0,5.5,0]]; } else { _spikeStrip attachTo[vehicle player,[0,-5,0]]; };
detach _spikeStrip;
_spikeStrip setPos [(getPos _spikeStrip select 0),(getPos _spikeStrip select 1),0];
if (isNull objectParent player) then { _spikeStrip setDir (_dir + 90); } else { _spikeStrip setDir (_dir); };
_spikeStrip setVariable["item","spikeDeployed",true];


_spikestrip hideObjectGlobal false;
_spikeStrip setDamage 1;
//_spikeStrip addEventHandler["GetOut", {_this call life_fnc_vehicleExit;}];
_spikeStrip setVariable ["owner", player, true];
[_spikeStrip] remoteExec ["ASY_fnc_spikeStrip",2]; //Send it to the server for monitoring.
_spikeStrip remoteExecCall ["ASY_fnc_setIdleTime",2];