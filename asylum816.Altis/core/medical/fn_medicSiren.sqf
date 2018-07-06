/*
	File: fn_medicSiren.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Starts the paramedic siren sound for other players
*/
params [
	["_vehicle",objNull,[objNull]],
	"_logic"
];
if(isNull _vehicle) exitWith {};
hideObject _logic;

for "_i" from 0 to 1 step 0 do {
	if (count crew _vehicle isEqualTo 0) exitWith {};
	if (!alive _vehicle) exitWith {};
	if (isNull _vehicle || isNull _logic) exitWith {};
	_logic say3D ["SirenMedic",650]; 
	sleep 15;
};