/*
    File: fn_getInVehicle.sqf
    Author: Gnashes
    
    Description:
    Function to run on getInMan EVH to initiate threads related to special vehicle restrictions
*/

params [
    "",
    "",
    ["_vehicle",objNull,[objNull]]
];

life_in_vehicle = true;

if (!isNull life_holding_barrel) then {[true,true,dropOilAction,_barrel] call life_fnc_dropOil;};

if (_vehicle isKindOf "Car") exitWith {
	if (life_seatbelt) then {life_seatbelt = false};
	if (typeOf _vehicle in ["B_G_Offroad_01_armed_F","I_C_Offroad_02_LMG_F","O_LSV_02_armed_F"] && gunner _vehicle isEqualTo player) then {
		_vehicle enableRopeAttach false;
	} else {
		//_vehicle enableRopeAttach true;
	};
};

if (_vehicle isKindOf "Air") then {
	/*if ((life_configuration select 12) < 4 && {typeOf _vehicle == "O_Heli_Transport_04_F"}) then {
		[] spawn {
			while {!isNull objectParent player} do {
				if !((difficultyEnabledRTD) && (isStressDamageEnabled)) then {
					if ((assignedVehicleRole player isEqualTo ["driver"]) || (assignedVehicleRole player isEqualTo ["Turret",[0]])) exitWith {
						player action ["Eject", vehicle player];
						player action ["GetOut", vehicle player];
						hint "You cannot pilot this vehicle without Advanced Flight Mode on and stress damage enabled!"
					};
				};
				sleep 1;  
			};
		};
	};*/
	if (driver _vehicle isEqualTo player) then {
		//if (difficultyEnabledRTD && uniform player == "U_B_HeliPilotCoveralls" && headgear player isEqualTo "") then { player addHeadgear "H_PilotHelmetHeli_O"; };
		while {!isNull objectParent player && driver _vehicle isEqualTo player} do {
			private _ropes = ropes (vehicle player);
			if (!(isNull (gunner (getSlingLoad (vehicle player)))) && (count _ropes) > 0) then {
				{
					deleteVehicle _x;
				} forEach _ropes;
				hint "Your vehicle ropes snapped from someone in the gunner seat!";
			};
			sleep 4;
		};
	};
} else {
	if (headgear player == "H_PilotHelmetHeli_O") then {removeHeadgear player;};
};