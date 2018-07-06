/*
	File: fn_keyUpHandler.sqf
	Author: Skalicon & Paratus

	Description:
	Main key handler for event 'keyDown'
*/
private ["_handled","_shift","_alt","_code","_ctrl","_alt","_ctrlKey","_veh","_locked","_owners","_index","_weapon","_items","_primary","_ammo"];
_ctrl = _this select 0;
_code = _this select 1;
_shift = _this select 2;
_ctrlKey = _this select 3;
_alt = _this select 4;
_speed = speed cursorTarget;
_handled = false;

if(life_action_in_use && _code != 1) exitWith {_handled};

switch (_code) do
{

	//Escape
	case 1:
	{
		if (!isNull life_sitting) then { [] execVM "Chair\standup.sqf"; _handled = true; };
		if (life_targetTag) then { life_targetTag = false };
	};
	//1 Key
	case 2:
    {
		//Is the police light switchbox open
        if ((findDisplay 96000) isEqualTo displayNull) then {
			//No, the light switchbox isn't open
			//Do the check and then open wanted list
			if (playerSide == independent && (life_adminlevel < 2)) exitWith {};
			if (playerSide == civilian && (life_adminlevel < 2) && (count life_bounty_uid) == 0 && (getPlayerUID player != (life_configuration select 0))) exitWith {};
			[] call life_fnc_p_openMenu;
            [] call life_fnc_wantedMenu;
            }
            else {
                if((vehicle player) getVariable ["lights", false]) then {
                    (vehicle player) setVariable["lights",false,true];
                }
            else {
				(vehicle player) remoteExec ["life_fnc_copLights",-2];
                };
                closeDialog 0;
            }
        };

	//Driving
	/* case 17:
	case 30:
	case 31: */
	case 32:
	{
		if (life_alcohol_level > 0 && (vehicle player) != player && (driver (vehicle player)) == player) then
		{
			_chance = ((1 - life_alcohol_level) * 100) * 0.5;
			if (floor (random _chance) == 0) then { _handled = true; };
		};
	};

	//3/TAB Key
	//case 4;
	case 15:
	{
            if(!_alt && !_ctrlKey && !dialog && vehicle player != player && (driver (vehicle player)) == player) then
            {
                if (playerSide != west) exitWith {};
                [] call life_fnc_p_openLightSwitchBox;
            }
            else {
                if (!_alt && !_ctrlKey && dialog && !((findDisplay 96000) isEqualTo displayNull)) then {
                    closeDialog 0;
                }
                else {
                    if(!_alt && !_ctrlKey && !life_isdowned && isNull life_sitting) then {
                        if(player getVariable ["playerSurrender",false]) then {
                            player setVariable ["playerSurrender",false,true];
                        } else {
                            [] spawn life_fnc_surrender;
                        };
                    };
                };
            };
        };

	//6 Nitro
	case 7:
	{
		if(!_alt && !_ctrlKey) then {
			[] spawn life_fnc_activateNitro;
		};
	};

	//5 Cellphone
	case 6:
	{
		if (life_alive) then
		{
			if (player getVariable["restrained",false] && life_adminlevel < 2) then
			{
				hint "You cannot open your cell phone when you're restrained!";
			}
			else
			{
				createDialog "Life_cell_phone";
			};
		};
	};

	//8 Medic response
	case 9:
	{
		if (!isNil "last_medic_call") then
		{
			if ((time - last_medic_time) < 20) then
			{
				if (!isNull (last_medic_call select 1) && !alive (last_medic_call select 1)) then
				{
					[(last_medic_call select 0)] call life_fnc_medicRespond;
[player] remoteExecCall ["life_fnc_medicEnroute",(last_medic_call select 1)];
				}
				else
				{
					hint "The last player to send a medic request is no longer in need of assistance.";
				};
			};
		};

		if (life_phone_status == 1) then
		{
			life_phone_status = 0;
			_handled = true;
		}
	};

	//9 Accept invite
	case 10:
	{
		if(!_alt && !_ctrlKey) then {
			if (life_phone_status == 1) then
			{
				life_phone_status = 3;
				_handled = true;
			}
			else { [] spawn life_fnc_inviteAcceptGang; };
		};
	};

	//T Key (Trunk)
	case 20:
	{
		if(!_alt && !_ctrlKey) then
		{
			if((player getVariable ["playerSurrender",false]) || (player getVariable ["restrained",false])) exitWith {hint "How could you possibly access the trunk of this vehicle right now?"};
			if(vehicle player == player) then
			{
				if((cursorTarget isKindOf "Car" OR cursorTarget isKindOf "Air" OR cursorTarget isKindOf "Ship") && player distance cursorTarget < 10 && vehicle player == player && alive cursorTarget) then
				{
					if (!(cursorTarget getVariable ["vLoaded", false])) then
					{
						_index = -1;
						_owners = cursorTarget getVariable ["vehicle_info_owners",[]];
						for "_i" from 0 to ((count _owners) - 1) do {
							if((_owners select _i) select 0 == getPlayerUID player) then {_index = _i;};
						};
						if(_index > -1) then
						{
							[cursorTarget] call life_fnc_openInventory;
cursorTarget remoteExecCall ["ASY_fnc_setIdleTime",2];
						};
					};
				};
				if((cursorTarget getVariable["containerId", -1] > -1) && (player distance cursorTarget) < 4 && (((cursorTarget getVariable["house", objNull]) getVariable["life_locked", 1]) == 0 || (cursorTarget getVariable["house", objNull] in life_houses || [cursorTarget getVariable["house", objNull]] call life_fnc_getBuildID == life_gang))) then
				{
				[cursorTarget] call life_fnc_openInventory
				}; 
			} else {
				if(vehicle player isKindOf "Ship") then {
					if (!(vehicle player getVariable ["vLoaded", false])) then {
						_index = -1;
						_owners = vehicle player getVariable ["vehicle_info_owners",[]];
						for "_i" from 0 to ((count _owners) - 1) do {
						if((_owners select _i) select 0 == getPlayerUID player) then {_index = _i;};
						};
						if(_index > -1) then {
							[vehicle player] call life_fnc_openInventory;
vehicle player remoteExecCall ["ASY_fnc_setIdleTime",2];
						};
					};
				};
			};
		};
	};

	//L Key?
	case 38: { if(!_alt && !_ctrlKey) then { [] call life_fnc_radar; }; };

	//Y Player Menu
	case 21:
	{
		if(!_alt && !_ctrlKey && !dialog) then
		{
			[] call life_fnc_p_openMenu;
		};
	};
	//H/4 Holster
	//case 5;
	case 35:
	{
		if(!_alt && !_ctrlKey && !dialog && vehicle player == player) then
		{
			if ((currentWeapon player) != "") then
			{
				[true,true,true,true] spawn life_fnc_holsterWeapon;  //To make sure that the script is asking for _this select 3 since this is run by action as well. Stupid, but it works.
			} else {
				[false,false,false,false] spawn life_fnc_holsterWeapon;
			};
		};
	};
	//F Key
	case 33:
	{
		_veh = vehicle player;
		// if it's a cop or medic, and the player is the driver of a vehicle, then we'll start a siren
		if(playerSide in [west,independent] && _veh != player && (driver _veh) == player) then {
			switch (playerSide) do
			{
				case (west): { // new fancy new siren for cops
					[_veh, false, false, true] call life_fnc_copSiren;
				};
				case (independent): {  // medic siren for medics
					if(isNull (missionNamespace getVariable["life_sirenLogic",ObjNull])) then {
						life_sirenLogic = "Land_ClutterCutter_small_F" createVehicle ([0,0,0]);
						life_sirenLogic attachTo [vehicle player,[0,1,0]];
						titleText ["Sirens On","PLAIN"];
						[_veh,life_sirenLogic] remoteExec ["life_fnc_medicSiren",-2];
					} else {
						deleteVehicle life_sirenLogic;
						titleText ["Sirens Off","PLAIN"];
					};
				};
			};
			_handled = true;
		};
	};
	//U Key
	case 22:
	{
		if(!_alt && !_ctrlKey) then
		{
			if ((player getVariable ["restrained", false]) || (player getVariable ["downed", false])) then {hint "How could you possibly reach your keys right now?"} else 
				{
				if(vehicle player == player) then
				{
					_veh = cursorTarget;
				}
					else
				{
					_veh = vehicle player;
				};
				if(_veh isKindOf "House_F") exitWith {
					_door = _veh call {
						_house = _this;
						_door = 0;
						_doors = getNumber(configFile >> "CfgVehicles" >> (typeOf _house) >> "numberOfDoors");
						for "_i" from 1 to _doors do {
							_selectionPos = _house selectionPosition format["Door_%1_trigger",_i];
							_worldSpace = _house modelToWorld _selectionPos;
							if(player distance _worldSpace < 2.4) exitWith {_door = _i; };
						};
						_door;
					};
					_locked = _veh getVariable [format["bis_disabled_Door_%1",_door],0];
					if(_door == 0) exitWith {hint "You are not near a door."};
					if((_veh in life_houses) && (playerSide == civilian)) then {
						if(_locked == 0) then {
							_veh setVariable[format["bis_disabled_Door_%1",_door],1,true];
							_veh animate [format["door_%1_rot",_door],0];
							systemChat "Door locked.";
						} else {
							_veh setVariable[format["bis_disabled_Door_%1",_door],0,true];
							_veh animate [format["door_%1_rot",_door],1];
							systemChat "Door unlocked.";
						};
					} else {
						if(_locked == 0) then {
							if(_veh animationPhase format["door_%1_rot",_door] == 1) then {
							_veh animate [format["door_%1_rot",_door],0];
							systemChat "Door closed.";
							} else {
							_veh animate [format["door_%1_rot",_door],1];
							systemChat "Door opened.";
							};
						} else {
						titleText ["This door is locked!","PLAIN"];
						};
					};
				};
				_locked = locked _veh;
	
				_index = -1;
				_owners = _veh getVariable ["vehicle_info_owners",[]];
				for "_i" from 0 to ((count _owners) - 1) do {
					if((_owners select _i) select 0 == getPlayerUID player) then {_index = _i;};
				};
	
				if(((_index > -1 )||(_veh in life_vehicles)) && player distance _veh < 10 && !(playerSide == civilian && typeOf _veh == "B_Heli_Light_01_F" && _veh getVariable["Life_VEH_color",0] == 14)) then
				{
					if(_locked == 2) then
					{
						_veh lock 0;
						[_veh,0] remoteExecCall ["life_fnc_lockVehicle",_veh];
						[_veh, "unlock",10] remoteExecCall ["life_fnc_playSound",-2];
						systemChat "You have unlocked your vehicle.";
					}
					else
					{
						_veh lock 2;
						[_veh,2] remoteExecCall ["life_fnc_lockVehicle",_veh];
						[_veh, "car_lock",15] remoteExecCall ["life_fnc_playSound",-2];
						systemChat "You have locked your vehicle.";
					};
				};
			};
		};
	};
	//Numpad minus
	case 74:
	{
		if (_shift) then
		{
			_handled = true;
		};
	};
};

if (_code in (actionKeys "TacticalView")) then
{
	hint "Command mode disabled on Asylum servers." ;
	_handled = true;
};
if (_code in (actionKeys "Diary")) then
{
	_handled = true;
};
if (life_brokenLeg && (_code in (actionKeys "MoveUp") || _code in (actionKeys "MoveDown") || _code in (actionKeys "Stand") || _code in (actionKeys "Crouch"))) then
{
	systemChat "Your leg is broken!" ;
	_handled = true;
};
if ((player getVariable["blindfolded",false]) && (_code in (actionKeys "ShowMap") || _code in (actionKeys "MiniMap") || _code in (actionKeys "MiniMapToggle"))) then
{
	systemChat "You can't view maps while blindfolded!" ;
	_handled = true;
};
if ((player getVariable["restrained",false] || player getVariable ["downed", false]) && _code in (actionKeys "Throw")) then
{
	systemChat "You can't throw something with your hands bound!";
	_handled = true;
};
if (_code in (actionKeys "NextAction") || _code in (actionKeys "PrevAction")) then {
	if (!life_show_actions) then
	{
		[] spawn life_fnc_enableActions;
	};
};
if (_code in (actionKeys "User1")) then { if(!_alt && !_ctrlKey) then { closeDialog 0; [] call life_fnc_p_openMenu; _handled = true; }; };
if (_code in (actionKeys "User2")) then {
	if(!_alt && !_ctrlKey) then {
		if (isNull objectParent player) then {
			if !(player getVariable ["restrained", false]) then {
				if (life_alive) then {
					closeDialog 0;
					createDialog "life_pickup_items";
					_handled = true;
				};
			};
		};
	};
};

if(_code in (actionKeys "User4")) then
{
	if((isNull objectParent player) &&  cursorTarget isKindOf "Man" && (isPlayer cursorTarget) && speed player < 1 && speed cursorTarget < 1 && alive cursorTarget && alive player && cursorTarget distance player < 2 && !(cursorTarget getvariable["Escorting",false]) && !(cursorTarget getvariable["restrained",false])) then
	{
		if ((cursorTarget getVariable["downed",false]) || (cursorTarget getVariable["playerSurrender",false])) then
		{
			if !(player getVariable["restrained",false] || player getVariable["downed",false] || player getVariable["playerSurrender",false]) then
			{
				if ((playerSide == west) && {side cursorTarget == west}) exitWith {hint "Trying to be corrupt are we?"};
				if ((playerSide == civilian) && {life_inv_ziptie < 1}) exitWith {};
				if (playerSide == independent) exitWith {hint "You're a medic. Let's leave the fuzzy handcuffs at home."};
				if (time - life_last_restrained > 5) then
				{ [] spawn life_fnc_restrain; life_last_restrained = time; } else { hint "You cannot rapidly use the restrain action key!"};
			};
		};
	};
};
if (_code in (actionKeys "User8")) then { if(!_alt && !_ctrlKey) then { [] call life_fnc_radar; _handled = true; }; };
if (_code in (actionKeys "User9")) then { if(!_alt && !_ctrlKey) then { closeDialog 0; _handled = true;if(([false,"spikeStrip",1] call life_fnc_handleInv)) then { [] spawn life_fnc_spikeStrip; }; }; };
if (_code in (actionKeys "User10")) then {
	if (soundVolume < (life_volume + 0.01)) then { 0 fadeSound 1; }
	else { 0 fadeSound life_volume; };
	systemChat format["Sound volume changed to %1%2.", soundVolume * 100, "%"];
	_handled = true;
};
if (_code in (actionKeys "User11")) then {
	[] spawn life_fnc_redgull;
	_handled = true;
};
if (_code in (actionKeys "User5")) then {
	// this action is for changing the emergency lights mode

	_veh = vehicle player;

	// if it's a high-ranking cop and he's driving a vehicle, let him toggle the advanced lights
	 [] call life_fnc_toggleSwat;
};
if (_code in (actionKeys "User6")) then {
	// this action is for changing the siren type (wail, yelp, phaser)

	_veh = vehicle player;
	// only do it if it's a cop and he's the driver of a vehicle
	if(playerSide == west && _veh != player && (driver _veh) == player) then {
		[_veh, true, false, true] call life_fnc_copSiren;
		_handled = true;
	};
};
if (_code in (actionKeys "User7")) then {
	// this action is for changing the siren mode (mono, dual)

	_veh = vehicle player;

	// only do it if it's a cop and he's the driver of a vehicle
	if(playerSide == west && _veh != player && (driver _veh) == player) then {
		[_veh, false, true, true] call life_fnc_copSiren;
		_handled = true;
	};
};

if (_code in (actionKeys "MoveForward")) then
{
	if (!isNull life_sitting) then
	{
		[] execVM "Chair\standup.sqf";
		_handled = true;
	};
};

if (_code in (actionKeys "User3")) then {
 	if(!_alt && !_ctrlKey) then {
 		if(player getVariable ["restrained", false]) then {
 			hint "You cannot access your inventory while you're restrained!";
 		} else {
 			closeDialog 0;
 			createDialog "life_inventory_menu";
 			_handled = true;
 		};
 	};
 };
 
if (_code in (actionKeys "User15")) then {
	if (playerSide isEqualTo civilian) then {
		if (vest player == "V_HarnessOGL_brn") then {
			if !(life_clothing_store isEqualType "") then {
				if (alive player && {playerSide == civilian} && {!(player getVariable ["downed",false])} && {!(player getVariable ["restrained",false])} && {!(player getVariable ["Escorting",false])} && {!(player getVariable ["transporting",false])}) then {
					["self"] spawn life_fnc_suicideBomb;
				};
			};
		};
	};
	_handled = true;
};

if (_code in (actionKeys "Gear")) then
{
	if(player getVariable ["restrained", false]) then {
		hint "You cannot access your inventory while you're restrained!";
		_handled = true;
	};
};

/*if (_code in (actionKeys "LeanLeft") || _code in (actionKeys "LeanLeftToggle")) then
{
	if (vehicle player != player && ((typeOf vehicle player) in ["C_Offroad_01_F","B_G_Offroad_01_F","B_G_Offroad_01_armed_F","C_SUV_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Van_01_box_F","C_Van_01_transport_F"]) && ((driver vehicle player) == player)) then
	{
		_signal = 1;
		if ((vehicle player getVariable ["signal", 0]) == 1) then { _signal = 0; };
[vehicle player,_signal] remoteExecCall ["life_fnc_turnSignal",0];
		(vehicle player) setVariable ["signal",_signal,true];
	};
};
if (_code in (actionKeys "LeanRight") || _code in (actionKeys "LeanRightToggle")) then
{
	if (vehicle player != player && ((typeOf vehicle player) in ["C_Offroad_01_F","B_G_Offroad_01_F","B_G_Offroad_01_armed_F","C_SUV_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Van_01_box_F","C_Van_01_transport_F"]) && ((driver vehicle player) == player)) then
	{
		_signal = 2;
		if ((vehicle player getVariable ["signal", 0]) == 2) then { _signal = 0; };
[vehicle player,_signal] remoteExecCall ["life_fnc_turnSignal",0];
		(vehicle player) setVariable ["signal",_signal,true];
	};
};*/

/*if (_code==41 || _code in (actionKeys "SelectAll") || _code in (actionKeys "SwitchCommand")) then
{
	if (life_targetTag) then { life_targetTag = false };
	_handled = true;
};*/

if (_code in [14,57,28]) then // Backspace, Spacebar, Enter
{
	if (life_show_actions) then
	{
		life_show_actions = false;
		removeAllActions player;
		life_actions = [];
	};
};

_handled;
