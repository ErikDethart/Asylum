/*
	File: fn_mouseDownHandler.sqf
	Author: Chronic [MIT]

	Description:
	Main key handler for event 'mouseButtonDown'
*/
params["_ctrl","_code","_shift","_ctrlKey","_alt"];
_handled = false;
 
switch (_code) do {
    case 0:{
		if !(isNull objectParent player) then {
        // this action is for starting the airhorn sound on a vehicle when the left mouse button is clicked
   
            _vehicle = vehicle player;
   
            // only do it if it's a cop and he's the driver of a hunter or stryder
			if (playerSide == west && life_coplevel >= 5) then {
				if(!dialog && !visibleMap && _vehicle != player && (driver _vehicle) == player && (typeof _vehicle == "B_MRAP_01_F" || typeof _vehicle == "I_MRAP_03_F")) then {
	
					// if this player's life_hornLogic variable hasn't been initialized yet, do it now
					if(isNil "life_hornLogic") then {
						life_hornLogic = objNull;
					};
	
					// if it's not, then let's create our own horn sound
					if(isNull life_hornLogic) then {
	
						// start by tearing out this vehicle's built-in horn
						_vehicle removeWeaponGlobal "TruckHorn2"; // hunter
						_vehicle removeWeaponGlobal "TruckHorn"; // strider
						life_hornLogic = "Land_ClutterCutter_small_F" createVehicle ([0,0,0]);
						life_hornLogic attachTo [_vehicle, [0,1,0]];
						life_hornLogic setVariable ["startTime", time, false];
						[_vehicle, life_hornLogic] remoteExecCall ["life_fnc_airhorn",-2];
						_handled = true;
					};
				};
			};
			if (typeof _vehicle == "C_Hatchback_01_sport_F") then {
				if(!dialog && !visibleMap && _vehicle != player && (driver _vehicle) == player && ((toLower("mpmissions\__cur_mp.altis\images\lc3_lee_flag.jpg") in (getObjectTextures _vehicle)) || (toLower("mpmissions\__cur_mp.altis\images\lc3_lee_noflag.jpg") in (getObjectTextures _vehicle)))) then {
					if(time - life_last_sold > 4) then {
						_vehicle removeWeaponGlobal "CarHorn";
						[_vehicle, "dixiehorn", 650] remoteExecCall ["life_fnc_playSound",-2];
						_handled = true;
						life_last_sold = time;
					};
				};
			};
		};
	};
};
 
_handled
