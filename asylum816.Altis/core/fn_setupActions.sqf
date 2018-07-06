/*
	File: fn_setupActions.sqf

	Description:
	Populates player-bound actions.
*/
switch (playerSide) do
{
	case west:
	{
		//Restrain Action
		life_actions = [player addAction["Restrain",life_fnc_restrain,cursorTarget,-1,false,false,"",' if (isPlayer cursorTarget) then { ((side cursorTarget != west) && alive cursorTarget && cursorTarget distance player < 5 && !(cursorTarget getVariable ["restrained",false]) && speed cursorTarget < 1) }; ']];
		//House Registration
		if(life_adminlevel > 1) then {
			life_actions pushBack (player addAction["<t color='#00FF00'>House Registration</t>",{
				if(cursorObject getVariable["house_owner",""] == "") exitWith {hint parseText format["<t color='#FF0000'><t size='2'>House ID:"+"</t></t><br/>%1",[cursorObject] call life_fnc_getBuildID]};
				hint parseText format["<t color='#FF0000'><t size='2'>House Owner/ID:"+"</t></t><br/>%1 / %2",cursorObject getVariable "house_owner",[cursorObject] call life_fnc_getBuildID];
			}
			,cursorObject,-1,false,false,"",'!isNull cursorObject && (player distance cursorObject) < 20 && cursorObject isKindOf "House" && ([typeOf cursorObject] call life_fnc_housePrice) > -1']);
		};
		//Disarming
		life_actions pushBack (player addAction["<t color='#FF0000'>Disarm</t>",life_fnc_disarmAction,cursorTarget,-1,false,false,"",'!isNull cursorTarget && !(alive cursorTarget) && !(cursorTarget getVariable ["disarmed", false]) && cursorTarget isKindOf "Man" && player distance cursorTarget < 2']);
		//Unrest Action
		life_actions pushBack (player addAction["Unrestrain",life_fnc_unrestrain,cursorTarget,0,false,false,"",' if (!isNull cursorTarget) then { if (isPlayer cursorTarget) then { (cursorTarget isKindOf "Man" && player distance cursorTarget < 3.5 && (cursorTarget getVariable ["restrained",false]) && !(cursorTarget getVariable ["Escorting",false])) }; }; ']);
		//Ticket Action
		life_actions pushBack (player addAction["Give Ticket",life_fnc_ticketAction,"",0,false,false,"",'
		if (!isNull cursorTarget) then { if (isPlayer cursorTarget) then { ((side cursorTarget != west) && alive cursorTarget && cursorTarget distance player < 3.5 && !(cursorTarget getVariable ["Escorting",false]) && (cursorTarget getVariable ["restrained",false])) }; }; ']);
		//Parole
		life_actions pushBack (player addAction["Issue Parole",life_fnc_paroleAction,"",0,false,false,"",'
		if (!isNull cursorTarget) then { if (isPlayer cursorTarget) then { ((life_coplevel > 1) && (side cursorTarget != west) && alive cursorTarget && cursorTarget distance player < 3.5 && !(cursorTarget getVariable ["Escorting",false]) && (cursorTarget getVariable ["restrained",false])) }; }; ']);
		//Pull out of car
		life_actions pushBack (player addAction["<t color='#FFF000'>Pull out of vehicle</t>",life_fnc_pulloutAction,cursorTarget,0,false,false,"",' !isNull cursorTarget && (player distance cursorTarget) < 4 && (count crew cursorTarget) > 0 && (cursorTarget isKindOF "Car" || cursorTarget isKindOf "Ship" || cursorTarget isKindOf "Air") && {alive _x} count crew cursorTarget > 0 && (isNull objectParent player)']);
		//Escort
		life_actions pushBack (player addAction["Escort",{[cursorTarget] call life_fnc_escortAction},"",0,false,false,"",'!isNull cursorTarget && cursorTarget isKindOf "Man" && (isPlayer cursorTarget) && alive cursorTarget && cursorTarget distance player < 3.5 && (cursorTarget getVariable ["restrained",false]) && attachedTo cursorTarget != player']);
		life_actions pushBack (player addAction["Stop Escorting",life_fnc_stopEscorting,"",0,false,false,"",' !isNull life_escort']);
		life_actions pushBack (player addAction["<t color='#FFF000'>Put in Vehicle</t>",life_fnc_putInCar,cursorTarget,-1,false,false,"",' !isNull cursorTarget && (player distance cursorTarget) < 6 && speed cursorTarget < 2 && (cursorTarget isKindOf "Car" || cursorTarget isKindOf "Air" || cursorTarget isKindOf "Ship") && !isNull (player getVariable ["currentlyEscorting",objNull]) && isPlayer (player getVariable ["currentlyEscorting",objNull]) && alive (player getVariable ["currentlyEscorting",objNull])']);

		life_actions pushBack (player addAction["Cop Enter as Driver",life_fnc_copEnter,"driver",200,false,false,"",'!isNull cursorTarget && ((cursorTarget isKindOf "Car")||(cursorTarget isKindOf "Air")||(cursorTarget isKindOf "Ship")) && (locked cursorTarget) != 0 && cursorTarget distance player < 5']);
		life_actions pushBack (player addAction["Cop Enter as Passenger",life_fnc_copEnter,"passenger",100,false,false,"",'!isNull cursorTarget && ((cursorTarget isKindOf "Car")||(cursorTarget isKindOf "Air")||(cursorTarget isKindOf "Ship")) && (locked cursorTarget) != 0 && cursorTarget distance player < 5 && (!(cursorTarget isKindOf "B_Heli_Attack_01_F"))']);
		life_actions pushBack (player addAction["Cop Enter as Commander",life_fnc_copEnter,"commander",100,false,false,"",'!isNull cursorTarget && ((cursorTarget isKindOf "Car")||(cursorTarget isKindOf "Air")||(cursorTarget isKindOf "Ship")) && (locked cursorTarget) != 0 && cursorTarget distance player < 5 && ((cursorTarget isKindOf "B_Heli_Attack_01_F")||(cursorTarget isKindOf "B_Heli_Transport_01_F")||(cursorTarget isKindOf "B_MRAP_01_hmg_F") || cursorTarget isKindOf "I_MRAP_03_F")']);
		life_actions pushBack (player addAction["Cop Enter as Gunner",life_fnc_copEnter,"gunner",100,false,false,"",'!isNull cursorTarget && ((cursorTarget isKindOf "Car")||(cursorTarget isKindOf "Air")||(cursorTarget isKindOf "Ship")) && (locked cursorTarget) != 0 && cursorTarget distance player < 5 && (count (allTurrets [cursorTarget,true]) > 0) && !(cursorTarget isKindOf "O_Heli_Light_02_unarmed_F")']);

		life_actions pushBack (player addAction["Exit",life_fnc_copEnter,"exit",100,false,false,"",'(vehicle player != player) && (locked(vehicle player)==2)']);

		//UAV
		if("B_UavTerminal" in (assignedItems player)) then {
			life_actions pushBack (player addAction["<t color='#0000FF'>Connect to UAV</t>",{createVehicleCrew cursorTarget; player connectTerminalToUAV cursorTarget; [cursorTarget] remoteExecCall ["ASY_fnc_setIdleTime",2];},false,90,false,false,"",'!isNull cursorTarget && alive cursorTarget && (player distance cursorTarget) < 6 && (typeOf cursorTarget == "B_UAV_01_F") && (!isUAVConnected cursorTarget)' ]);
			life_actions pushBack (player addAction["Show UAV Feed",{showUAVFeed true},false,90,false,false,"",' !isNull (getConnectedUAV player) && !shownUAVFeed ' ]);
			life_actions pushBack (player addAction["Hide UAV Feed",{showUAVFeed false},false,90,false,false,"",' shownUAVFeed ' ]);
		};
		//Impound Vehicle
		life_actions pushBack (player addAction["Impound Vehicle",life_fnc_impoundAction,false,90,false,false,"",'!isNull cursorTarget && alive cursorTarget && (player distance cursorTarget) < 6 && speed cursorTarget < 2 && (cursorTarget isKindOf "Car" || cursorTarget isKindOf "Air" || cursorTarget isKindOf "Ship" ) && !(typeOf cursorTarget in ["O_MRAP_02_F", "B_G_Offroad_01_armed_F","O_LSV_02_armed_F","I_C_Offroad_02_LMG_F"] || (cursorTarget getVariable["illegalVehicle",false]))' ]);
		//Seize Vehicle
		life_actions pushBack (player addAction["<t color='#FF0000'>Seize Vehicle</t>",life_fnc_impoundAction,true,0,false,false,"",'!isNull cursorTarget && alive cursorTarget && (player distance cursorTarget) < 6 && speed cursorTarget < 2 && (cursorTarget isKindOf "Car" || cursorTarget isKindOf "Air" || cursorTarget isKindOf "Ship" ) && (typeOf cursorTarget in ["O_MRAP_02_F", "B_G_Offroad_01_armed_F","O_LSV_02_armed_F","I_C_Offroad_02_LMG_F"] || (cursorTarget getVariable["illegalVehicle",false]))']);
		
		//Access Criminal Records
		life_actions pushBack (player addAction["<t color='#0000FF'>Criminal Records</t>",life_fnc_crimeRecord,true,0,false,false,"",'vehicle player != player && driver (vehicle player) == player' ]);

		//Send to jail
		life_actions pushBack (player addAction["Send to Jail",life_fnc_arrestAction,"",0,false,false,"",'!isNull cursorTarget && isPlayer cursorTarget && (side cursorTarget != west) && (cursorTarget getVariable ["restrained",false]) && alive cursorTarget && (player distance cursorTarget < 3.5) && ({player distance (getMarkerPos _x) < 30} count ["police_hq_1","police_hq_2","police_hq_3","police_hq_4","police_hq_5","jail_release2"] > 0) && !(cursorTarget getVariable ["Escorting",false]) ']);
		life_actions pushBack (player addAction["Send Combat Logger to Jail",{[cursorObject] spawn life_fnc_jailCL},"",0,false,false,"",'!isNull cursorObject && !(isPlayer cursorObject) && (player distance cursorObject < 3.5) && !((cursorObject getVariable ["clData",[]]) isEqualTo []) && ((typeOf cursorObject) isEqualTo "Land_Bodybag_01_black_F")']);
		//Release Action
		
		//Search Action
		life_actions pushBack (player addAction["Search",life_fnc_searchAction,cursorTarget,0,false,false,"",' !isNull cursorTarget && cursorTarget isKindOf "Man" && (isPlayer cursorTarget) && (cursorTarget getVariable["restrained",false] || cursorTarget getVariable["isCivRestrained",false]) && (side cursorTarget != west) && player distance cursorTarget < 3.5 && !(cursorTarget getVariable["Escorting",false]) ']);

		//Search Vehicle
		life_actions pushBack (player addAction["Check Registration",{[cursorTarget] spawn life_fnc_searchVehAction},"",0,false,false,"",
		' !isNull cursorTarget && (player distance cursorTarget) < 5 && speed cursorTarget < 2 && (cursorTarget isKindOf "Car" || cursorTarget isKindOf "Air" || cursorTarget isKindOf "Ship")']);
		life_actions pushBack (player addAction["Search Trunk",life_fnc_vehInvSearch,cursorTarget,0,false,false,"",
		' !isNull cursorTarget && (player distance cursorTarget) < 6 && speed cursorTarget < 2 && alive cursorTarget && (cursorTarget isKindOf "Car" || cursorTarget isKindOf "Air" || cursorTarget isKindOf "Ship")']);
		life_actions pushBack (player addAction["Search Storage",life_fnc_vehInvSearch,cursorObject,0,false,false,"",
		' !isNull cursorObject && (player distance cursorObject) < 8 && ((cursorObject getVariable["containerId", -1] > -1) || ((typeOf cursorObject) in ["Land_TentA_F","Land_TentDome_F"])) ']);
		life_actions pushBack (player addAction["Seize Trunk",life_fnc_vehInvSeize,cursorTarget,0,false,false,"",
		' !isNull cursorTarget && (player distance cursorTarget) < 6 && speed cursorTarget < 2 && alive cursorTarget && (cursorTarget isKindOf "Car" || cursorTarget isKindOf "Air" || cursorTarget isKindOf "Ship")']);
		life_actions pushBack (player addAction["Seize Storage",life_fnc_vehInvSeize,cursorObject,0,false,false,"",
		' !isNull cursorObject && (player distance cursorObject) < 8 && ((cursorObject getVariable["containerId", -1] > -1) || ((typeOf cursorObject) in ["Land_TentA_F","Land_TentDome_F"])) ']);

		life_actions pushBack (player addAction ["<t color='#FF0000'>Track APB Target</t>", life_fnc_trackBounty, 9999, 0, false, true, "", ' player distance (getMarkerPos "bounty_9999") < life_track_radius ']);

		//Pickup Deployed Spike strip
		life_actions pushBack (player addAction["Pack up Spike Strip",life_fnc_packupSpikes,"",0,false,false,"",
		' _spikes = nearestObjects[getPos player,["Land_Razorwire_F"],8] select 0; !isNil "_spikes" && !isNil {(_spikes getVariable "item")}']);

		// Pick up placed object
		life_actions pushBack (player addAction["Pick Up Object",life_fnc_pickupObject,cursorObject,0,false,false,"",
		' !isNull cursorObject && !isNull (cursorObject getVariable["owner", objNull]) && (player distance cursorObject) < 5 ']);

		//Lights?
		life_actions pushBack (player addAction["Emergency Lights ON",{[vehicle player] remoteExec ["life_fnc_copLights",-2];},"",0,false,false,"",' vehicle player != player && ((typeOf vehicle player) in ["I_Quadbike_01_F","C_Offroad_01_F","B_G_Offroad_01_armed_F","C_SUV_01_F","B_MRAP_01_F","C_Hatchback_01_sport_F","I_MRAP_03_F","B_Heli_Light_01_F","B_Heli_Transport_03_unarmed_F","I_Heli_light_03_unarmed_F","O_Heli_Light_02_unarmed_F","B_Heli_Transport_01_F","C_Offroad_02_unarmed_F","C_Van_02_transport_F","B_T_LSV_01_unarmed_F"]) && !isNil {vehicle player getVariable "lights"} && ((driver vehicle player) == player) && !(vehicle player getVariable ["lights", false])']);

		life_actions pushBack (player addAction["Emergency Lights OFF",{vehicle player setVariable["lights",false,true];},"",0,false,false,"", ' !(isNull objectParent player) && (vehicle player getVariable ["lights", false]) ']);

		life_actions pushBack (player addAction["Seize Illegal Items into Evidence",{[cursorTarget,"HQ"] spawn life_fnc_seizePlayerIllegal},"",0,false,false,"",'!isNull cursorTarget && (player distance cursorTarget) < 6 && speed cursorTarget < 2 && ((cursorTarget isKindOf "Man" && (isPlayer cursorTarget) && (side cursorTarget != west) && (cursorTarget getVariable ["restrained",false]) || ((cursorTarget isKindOf "Car" || cursorTarget isKindOf "Air") && alive cursorTarget))) && life_coplevel >= 1 && ({player distance2D getMarkerPos format["police_hq_%1",_x] < 50} count [1,2,3,4,5] > 0)']);
		life_actions pushBack (player addAction["Seize Illegal Items into Vehicle",{[cursorTarget,"Field"] spawn life_fnc_seizePlayerIllegal},"",0,false,false,"",'!isNull cursorTarget && (player distance cursorTarget) < 6 && speed cursorTarget < 2 && cursorTarget isKindOf "Man" && (isPlayer cursorTarget) && (side cursorTarget != west) && (cursorTarget getVariable ["restrained",false]) && life_coplevel >= 2 && (count(nearestObjects [player, ["Car","Air"], 20]) > 0) && ({player distance2D getMarkerPos format["police_hq_%1",_x] < 50} count [1,2,3,4,5] == 0)']);
		life_actions pushBack (player addAction["Seize Objects",life_fnc_seizeObjects,cursorTarget,0,false,false,"",'((cursorTarget isKindOf "GroundWeaponHolder") OR (cursorTarget isKindOf "WeaponHolderSimulated") OR (cursorTarget isKindOf "WeaponHolder"))']);

		//Cops open locked doors.
		if(life_coplevel >= 5 || life_swatlevel == 3) then {
			life_actions pushBack (player addAction["<t color='#FF0000'>Toggle All House Locks</t>",life_fnc_lockHouse,cursorTarget,-1,false,false,"",'!isNull cursorTarget && (player distance cursorTarget) < 20 && [(typeOf cursorTarget)] call life_fnc_housePrice > 0 && (life_coplevel >= 5 || life_swatlevel == 3) && (cursorObject getVariable["house_owner",""] != "")']);
		};
		// Apply charge
		life_actions pushBack (player addAction["<t color='#990000'>Charge with Crime</t>",life_fnc_charge,cursorTarget,-1,false,false,"",'!isNull cursorTarget && (player distance cursorTarget) < 5 && cursorTarget isKindOf "Man" && (isPlayer cursorTarget) && (side cursorTarget != west) && (cursorTarget getVariable ["restrained",false]) && life_coplevel > 1']);

		//Revoke licence
		life_actions pushBack (player addAction["Revoke Drivers Licence",life_fnc_revokeLicence,"drivers",0,false,false,"",'(isPlayer cursorTarget) && (side cursorTarget == civilian) && alive cursorTarget && cursorTarget distance player < 5 && (cursorTarget getVariable ["restrained",false]) && speed cursorTarget < 1 && life_coplevel >= 2']);

		//Revoke BH licence
		life_actions pushBack (player addAction["Revoke Bounty Hunter Licence",life_fnc_revokeLicence,"bounty",0,false,false,"",'(isPlayer cursorTarget) && (side cursorTarget == civilian) && alive cursorTarget && cursorTarget distance player < 5 && (cursorTarget getVariable ["restrained",false]) && speed cursorTarget < 1 && life_coplevel >= 2']);

		if (str(player) == "Swat_med") then
		{
			life_actions pushBack (player addAction["Heal",life_fnc_swatHeal,0,0,false,false,"",'(isPlayer cursorTarget) && player distance cursorTarget < 3.5 && alive cursorTarget && (damage cursorTarget) > 0']);
			life_actions pushBack (player addAction["Heal Self",life_fnc_swatHeal,1,0,false,false,"",'(damage player) > 0']);
		};

		// Defibrillator
		life_actions pushBack (player addAction["<t color='#FF0000'>Use Defibrillator</t>",life_fnc_revivePlayer,cursorTarget,-1,false,false,"",'!isNull cursorTarget && cursorTarget isKindOf "Man" && !(alive cursorTarget) && !(cursorTarget getVariable ["Revive",false]) && life_inv_defib > 0 && (94 in life_talents) && (player distance cursorTarget) < 3.5']);
		// Splint
		life_actions pushBack (player addAction["<t color='#FF0000'>Apply Splint to Self</t>",life_fnc_splint,player,-1,false,false,"",'vehicle player == player && life_brokenLeg && (93 in life_talents) && (life_inv_splint > 0) && (life_inv_splint > 0)']);
		life_actions pushBack (player addAction["<t color='#FF0000'>Apply Splint</t>",life_fnc_splint,cursorTarget,-1,false,false,"",'vehicle player == player && player distance cursorTarget < 3.5 && !isNull cursorTarget && isPlayer cursorTarget && alive cursorTarget && (cursorTarget getVariable ["broken",false]) && (93 in life_talents) && (life_inv_splint > 0)']);

		// Bank
		//life_actions pushBack (player addAction ["Unlock Reserve Gate", life_fnc_openGate, "",0,false,false,"",' ((typeOf cursorTarget) == "Land_BarGate_F" && (cursorTarget getVariable ["gate_max", 0]) == 0 && (player distance cursorTarget) < 7 && cursorTarget in life_bank_gates)']);

		if (worldName == "Altis") then {
			// Remote opening of gates (not bank gates)
			life_actions pushBack (player addAction ["Open Police Gate", {_gate = objNull;if(vehicle player == player) then {_gate = (nearestObjects [player, ["Land_BarGate_F"], 7]) select 0;} else {_gate = (nearestObjects [player, ["Land_BarGate_F"], 15]) select 0;};if(!isNull _gate && !(_gate in life_bank_gates)) then {_gate animate ["Door_1_rot", 1];};},"",10,false,false,"",'_gate = objNull;if(vehicle player == player) then {_gate = (nearestObjects [player, ["Land_BarGate_F"], 7]) select 0;} else {_gate = (nearestObjects [player, ["Land_BarGate_F"], 15]) select 0;};_showCommand = false;
			if(!isNull _gate && !(_gate in life_bank_gates) && _gate animationPhase "Door_1_rot" == 0) then {
					_showCommand = true;
			};_showCommand']);
	
			// Remote closing of gates (not bank gates)
			life_actions pushBack (player addAction ["Close Police Gate", {_gate = objNull;if(vehicle player == player) then {_gate = (nearestObjects [player, ["Land_BarGate_F"], 7]) select 0;} else {_gate = (nearestObjects [player, ["Land_BarGate_F"], 15]) select 0;}; if(!isNull _gate && !(_gate in life_bank_gates)) then {_gate animate ["Door_1_rot", 0];};},"",10,false,false,"",'_gate = objNull;
				if(vehicle player == player) then {_gate = (nearestObjects [player, ["Land_BarGate_F"], 7]) select 0;} else {_gate = (nearestObjects [player, ["Land_BarGate_F"], 15]) select 0;};_showCommand = false;
					if(!isNull _gate && !(_gate in life_bank_gates) && _gate animationPhase "Door_1_rot" == 1) then {
						_showCommand = true;
					};_showCommand']);
		} else {
					// Remote opening of gates (not bank gates)
			life_actions pushBack (player addAction ["Open Police Gate", {_gate = objNull;if(vehicle player == player) then {_gate = (nearestObjects [player, ["Land_BarGate_F","Land_Concretewall_01_L_Gate_F"], 7]) select 0;} else {_gate = (nearestObjects [player, ["Land_BarGate_F","Land_Concretewall_01_L_Gate_F"], 15]) select 0;}; _move = (animationNames _gate) select 0;if(!isNull _gate && !(_gate in life_bank_gates)) then {_gate animate [_move, 1];};},"",10,false,false,"",'_gate = objNull;if(vehicle player == player) then {_gate = (nearestObjects [player, ["Land_BarGate_F","Land_Concretewall_01_L_Gate_F"], 7]) select 0;} else {_gate = (nearestObjects [player, ["Land_BarGate_F","Land_Concretewall_01_L_Gate_F"], 15]) select 0;};_showCommand = false;
			if(!isNull _gate && !(_gate in life_bank_gates) && _gate animationPhase _move == 0) then {
			_showCommand = true;
			};_showCommand']);
	
			// Remote closing of gates (not bank gates)
			life_actions pushBack (player addAction ["Close Police Gate", {_gate = objNull;if(vehicle player == player) then {_gate = (nearestObjects [player, ["Land_BarGate_F","Land_Concretewall_01_L_Gate_F"], 7]) select 0;} else {_gate = (nearestObjects [player, ["Land_BarGate_F","Land_Concretewall_01_L_Gate_F"], 15]) select 0;};_move = (animationNames _gate) select 0; if(!isNull _gate && !(_gate in life_bank_gates)) then {_gate animate [_move, 0];};},"",10,false,false,"",'_gate = objNull;
				if(vehicle player == player) then {_gate = (nearestObjects [player, ["Land_BarGate_F","Land_Concretewall_01_L_Gate_F"], 7]) select 0;} else {_gate = (nearestObjects [player, ["Land_BarGate_F","Land_Concretewall_01_L_Gate_F"], 15]) select 0;};_showCommand = false;
					if(!isNull _gate && !(_gate in life_bank_gates) && _gate animationPhase _move == 1) then {
						_showCommand = true;
					};_showCommand']);
		};

		// Blindfold
		life_actions pushBack (player addAction["Remove Blindfold",life_fnc_blindfoldRemove,cursorTarget,-1,false,false,"",' cursorTarget getVariable ["blindfolded",false] && cursorTarget isKindOf "Man" && (isPlayer cursorTarget) && alive cursorTarget && cursorTarget distance player < 5 && speed cursorTarget < 1 ']);

		// Detective
		if(life_coprole in ["detective","all"]) then {
			life_actions pushBack (player addAction["Show Rank Identity",{ player setVariable["copLevel", life_coplevel, true]; if(!isNull objectParent player) then {[] call life_fnc_equipGear; }; },cursorTarget,-2,false,false,"",' (player getVariable ["copLevel",0]) == 0']);
			life_actions pushBack (player addAction["Hide Rank Identity",{ player setVariable["copLevel", nil, true]; if(!isNull objectParent player) then {[] call life_fnc_equipGear; }; },cursorTarget,-2,false,false,"",' (player getVariable ["copLevel",0]) > 0 ']);
			//life_actions pushBack (player addAction["Feign Picking",{if((time - life_action_delay) < 1) then {hint "You can't rapidly use action keys!"} else { player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon"; waitUntil{animationState player != "ainvpercmstpsnonwnondnon_putdown_amovpercmstpsnonwnondnon"}; life_action_delay = time;};},cursorTarget,-2,false,false,"",' (player getVariable ["copLevel",0]) == 0 && (isNull objectParent player)']);
		};
		//IR Laser
		if (life_coplevel > 4) then {
			life_actions pushBack (player addAction["Add IR Laser (Lethal)",life_fnc_nonLethal,"add",0,false,false,"",'"acc_pointer_IR" in (items player) && !("acc_pointer_IR" in (primaryWeaponItems player))']);
			life_actions pushBack (player addAction["Remove IR Laser (Non-Lethal)",life_fnc_nonLethal,"rem",0,false,false,"",'!("acc_pointer_IR" in (items player)) && ("acc_pointer_IR" in (primaryWeaponItems player)) ']);
		};
		// SWAT
		if (life_activeSWAT) then {
			life_actions pushBack (player addAction["Terminate SWAT",life_fnc_swatTerminate,"",10,false,false,"",' if (life_activeSWAT) then {(life_roleSWAT == 2)} ']);
		};
		// helicopter EMP drop
		//life_actions pushBack (player addAction ["Drop EMP", {_pos = position (vehicle player);_pos set [2, (_pos select 2) - 1.5];_emp = createVehicle ["GrenadeHand_stone", _pos, [], 0, "NONE"];[_emp] spawn life_fnc_fireEMP;}, "",0,false,false,"",'if(isNil "life_empLogic") then {life_empLogic = objNull;}; vehicle player isKindOf "Helicopter" && life_coplevel >= 5 && isNull life_empLogic']);

		// Bank
		life_actions pushBack (player addAction ["Disable Drill", life_fnc_stopBankVault,false,4,true,true,"",' player distance (getMarkerPos "life_bank_door") < 4 && life_bank_drilling ']);
	};

	case independent:
	{
		// Defibrillator
		life_actions = [player addAction["<t color='#FF0000'>Use Defibrillator</t>",life_fnc_revivePlayer,cursorTarget,-1,false,true,"",'!isNull cursorTarget && cursorTarget isKindOf "Man" && !(alive cursorTarget) && !(cursorTarget getVariable ["Revive",false]) && life_inv_defib > 0 && (player distance cursorTarget) < 3.5']];
		// Splint
		life_actions pushBack (player addAction["<t color='#FF0000'>Apply Splint to Self</t>",life_fnc_splint,player,-1,false,false,"",'life_brokenLeg && (life_inv_splint > 0)']);
		life_actions pushBack (player addAction["<t color='#FF0000'>Apply Splint</t>",life_fnc_splint,cursorTarget,-1,false,false,"",'!isNull cursorTarget && player distance cursorTarget < 3.5 && isPlayer cursorTarget && alive cursorTarget && (cursorTarget getVariable ["broken",false]) && (life_inv_splint > 0)']);
		//Lights?
		life_actions pushBack (player addAction["Emergency Lights ON",{[vehicle player,0.22] remoteExec ["life_fnc_medicLights",-2]; vehicle player setVariable["lights",true,true];},"",0,false,false,"",' vehicle player != player && ((typeOf vehicle player) == "C_Offroad_01_F" || (typeOf vehicle player) == "C_SUV_01_F") && !isNil {vehicle player getVariable "lights"} && ((driver vehicle player) == player) && !(vehicle player getVariable "lights")']);
		life_actions pushBack (player addAction["Emergency Lights OFF",{vehicle player setVariable["lights",false,true];},"",0,false,false,"", ' vehicle player != player && ((typeOf vehicle player) == "C_Offroad_01_F" || (typeOf vehicle player) == "C_SUV_01_F") && !isNil {vehicle player getVariable "lights"} && ((driver vehicle player) == player) && (vehicle player getVariable "lights") ']);
	};

	case civilian:
	{
		//Restrain Action
		life_actions = [player addAction["Restrain",life_fnc_restrain,cursorTarget,-1,false,true,"",'(cursorTarget getVariable ["playerSurrender",false] || cursorTarget getVariable "downed") && cursorTarget isKindOf "Man" && (isPlayer cursorTarget) && alive cursorTarget && cursorTarget distance player < 5 && !(cursorTarget getVariable ["Escorting",false]) && !(cursorTarget getVariable ["restrained",false]) && speed cursorTarget < 1 && life_inv_ziptie > 0']];
		if (cursorTarget getVariable ["restrained",false]) then {
			life_actions pushBack (player addAction["Unrestrain",life_fnc_unrestrain,cursorTarget,-1,false,true,"",' !isNull cursorTarget && cursorTarget isKindOf "Man" && (isPlayer cursorTarget) && player distance cursorTarget < 3.5 && (cursorTarget getVariable ["restrained",false]) && (cursorTarget getVariable ["isCivRestrained",false]) && !(cursorTarget getVariable ["Escorting",false]) && !(cursorTarget getVariable["downed",false]) && (group player == (cursorTarget getVariable["restrainedBy",grpNull]) || !(currentWeapon player in ["","Binocular","hgun_Pistol_Signal_F"]))']);
			life_actions pushBack (player addAction["Lockpick Handcuffs",life_fnc_lockpick,cursorTarget,-1,false,true,"",' life_inv_lockpick > 1 && !isNull cursorTarget && cursorTarget isKindOf "Man" && (isPlayer cursorTarget) && player distance cursorTarget < 3.5 && (cursorTarget getVariable ["restrained",false]) && !(cursorTarget getVariable ["isCivRestrained",false]) && !(cursorTarget getVariable ["Escorting",false]) && !(cursorTarget getVariable["downed",false]) && (group player == (cursorTarget getVariable["restrainedBy",grpNull]) || !(currentWeapon player in ["","Binocular","hgun_Pistol_Signal_F"]))']);
			life_actions pushBack (player addAction["Apply Blindfold",life_fnc_blindfold,cursorTarget,-1,false,true,"",' cursorTarget getVariable ["restrained",false] && !(cursorTarget getVariable ["blindfolded",false]) && life_inv_blindfold > 0 && cursorTarget isKindOf "Man" && (isPlayer cursorTarget) && alive cursorTarget && cursorTarget distance player < 5 && speed cursorTarget < 1 ']);
		};
		life_actions pushBack (player addAction["Remove Blindfold",life_fnc_blindfoldRemove,cursorTarget,-1,false,true,"",' cursorTarget getVariable ["blindfolded",false] && cursorTarget isKindOf "Man" && (isPlayer cursorTarget) && alive cursorTarget && cursorTarget distance player < 5 && speed cursorTarget < 1 ']);

		// Gathering
		life_actions pushBack (player addAction["<t color='#0099FF'>Pick Barley</t>",life_fnc_gatherObject,["barley",1,"neriumo2d"],1,true,true,"""",'player distance cursorObject < 3 && {[str cursorObject,"neriumo2d"] call KRON_StrInStr} && (!((cursorTarget isKindOf "Car") || (cursorTarget isKindOf "Air") || (cursorTarget isKindOf "Ship"))) ']);
		life_actions pushBack (player addAction["<t color='#0099FF'>Pick Berries</t>",life_fnc_gatherObject,["berry",3,"neriumo"],1,true,true,"""",'player distance cursorObject < 3 && {[str cursorObject,"neriumo"] call KRON_StrInStr} && (!((cursorTarget isKindOf "Car") || (cursorTarget isKindOf "Air") || (cursorTarget isKindOf "Ship"))) ']);
		life_actions pushBack (player addAction["<t color='#0099FF'>Pick Berries</t>",life_fnc_gatherObject,["berry",3,"colored"],1,true,true,"""",'player distance cursorObject < 3 && {[str cursorObject,"b_colored"] call KRON_StrInStr} && (!((cursorTarget isKindOf "Car") || (cursorTarget isKindOf "Air") || (cursorTarget isKindOf "Ship"))) ']);
		//life_actions pushBack (player addAction["<t color='#0099FF'>Pick Sugarcane</t>",life_fnc_gatherObject,["sugarcane",1,"sugarcane_mat"],1,true,true,"""",'player distance cursorObject < 3 && {[str cursorObject,"sugarcane_mat"] call KRON_StrInStr} && (!((cursorTarget isKindOf "Car") || (cursorTarget isKindOf "Air") || (cursorTarget isKindOf "Ship"))) ']);
		life_actions pushBack (player addAction["<t color='#0099FF'>Pick Rye</t>",life_fnc_gatherObject,["rye",1,"arundod2s"],1,true,true,"""",'player distance cursorObject < 5 && {[str cursorObject,"arundod2s"] call KRON_StrInStr} && (!((cursorTarget isKindOf "Car") || (cursorTarget isKindOf "Air") || (cursorTarget isKindOf "Ship"))) ']);
		life_actions pushBack (player addAction["<t color='#0099FF'>Pick Corn</t>",life_fnc_gatherObject,["corn",1,"arundod3s"],1,true,true,"""",'player distance cursorObject < 5 && {[str cursorObject,"arundod3s"] call KRON_StrInStr} && (!((cursorTarget isKindOf "Car") || (cursorTarget isKindOf "Air") || (cursorTarget isKindOf "Ship"))) ']);
		//life_actions pushBack (player addAction["<t color='#0099FF'>Pick Banana</t>",life_fnc_gatherObject,["banana",3,"banana"],1,true,true,"""",'player distance cursorObject < 3 && {[str cursorObject,"banana"] call KRON_StrInStr} && (!((cursorTarget isKindOf "Car") || (cursorTarget isKindOf "Air") || (cursorTarget isKindOf "Ship"))) ']);
		//life_actions pushBack (player addAction["<t color='#0099FF'>Pick Ginger</t>",life_fnc_gatherObject,["ginger",1,"ginger"],1,true,true,"""",'player distance cursorObject < 3 && {[str cursorObject,"ginger"] call KRON_StrInStr} && (!((cursorTarget isKindOf "Car") || (cursorTarget isKindOf "Air") || (cursorTarget isKindOf "Ship"))) ']);
		//life_actions pushBack (player addAction["<t color='#0099FF'>Pick Coca Leaf</t>",life_fnc_gatherObject,["cocaleaf",1,"cacao"],1,true,true,"""",'player distance cursorObject < 3 && {[str cursorObject,"cacao"] call KRON_StrInStr} && (!((cursorTarget isKindOf "Car") || (cursorTarget isKindOf "Air") || (cursorTarget isKindOf "Ship"))) ']);

		//Execution
		life_actions pushBack (player addAction["<t color='#FF0000'>Execute!</t>",life_fnc_execute,false,-1,false,true,"",'!isNull cursorObject && !(alive cursorTarget) && cursorObject isKindOf "CAManBase" && !(typeOf cursorTarget in ["Goat_random_F", "Cock_random_F", "Hen_random_F", "Sheep_random_F","Alsatian_Random_F"]) && !(currentWeapon player in life_disallowedThreatWeapons) && player distance cursorTarget < 2 ']);
		life_actions pushBack (player addAction["<t color='#FF2200'>Execute and Harvest!</t>",life_fnc_execute,true,-1,false,true,"",'life_inv_skinningknife > 0 && {!isNull cursorObject && !(alive cursorTarget) && cursorObject isKindOf "CAManBase" && !(typeOf cursorTarget in ["Goat_random_F", "Cock_random_F", "Hen_random_F", "Sheep_random_F","Alsatian_Random_F"]) && player distance cursorTarget < 2} ']);

		//Oil Barrels
		//life_actions pushBack (player addAction["Pickup Barrel",life_fnc_pickupOil,cursorTarget,-1,false,true,"",'!isNull cursorTarget && isNull life_holding_barrel && ((typeOf cursorTarget == "Land_MetalBarrel_F" && isNull (attachedTo cursorTarget)) || (typeOf cursorTarget in IL_Supported_Vehicles_BOAT && !isNull (cursorTarget getVariable ["oil_barrel", objNull]) && locked cursorTarget < 2)) && cursorTarget distance player < 4']);
		if(!isNull life_holding_barrel) then {
			life_actions pushBack (player addAction["Drop Barrel",life_fnc_dropOil,cursorTarget,-1,false,true,"",' !isNull life_holding_barrel && speed player < 2 ']);
			life_actions pushBack (player addAction["Place Barrel in Boat",life_fnc_placeOil,cursorTarget,-1,false,true,"",'!isNull cursorTarget && !isNull life_holding_barrel && (typeOf cursorTarget) in IL_Supported_Vehicles_BOAT && cursorTarget distance player < 5 && speed cursorTarget < 4']);
		};
		//Escort
		life_actions pushBack (player addAction["Escort",{[cursorTarget] call life_fnc_escortAction},"",-1,false,true,"",'!isNull cursorTarget && cursorTarget isKindOf "Man" && (isPlayer cursorTarget) && !(currentWeapon player in life_disallowedThreatWeapons) && alive cursorTarget && cursorTarget distance player < 3.5 && (cursorTarget getVariable ["restrained",false]) && !(cursorTarget getVariable ["Escorting",false])']);
		life_actions pushBack (player addAction["Stop Escorting",life_fnc_stopEscorting,"",-1,false,true,"",'!isNull (player getVariable["currentlyEscorting",objNull]) && ((player getVariable["currentlyEscorting",objNull]) getVariable ["Escorting",false])']);

		life_actions pushBack (player addAction["<t color='#FFF000'>Put in Vehicle</t>",life_fnc_putInCar,cursorTarget,-1,false,false,"",' !isNull cursorTarget && (player distance cursorTarget) < 6 && speed cursorTarget < 2 && (cursorTarget isKindOf "Car" || cursorTarget isKindOf "Air" || cursorTarget isKindOf "Ship") && !isNull (player getVariable ["currentlyEscorting",objNull]) && isPlayer (player getVariable ["currentlyEscorting",objNull]) && alive (player getVariable ["currentlyEscorting",objNull])']);
		life_actions pushBack (player addAction["<t color='#FFF000'>Pull out of vehicle</t>",life_fnc_pulloutAction,cursorTarget,-1,false,true,"",'!isNull cursorTarget && (player distance cursorTarget) < 4 && !(currentWeapon player in life_disallowedThreatWeapons) && (side player == civilian) && (locked cursorTarget == 0) && (count crew cursorTarget) > 0 && speed cursorTarget < 2 && (cursorTarget isKindOf "Car" || cursorTarget isKindOf "Air" || cursorTarget isKindOf "Ship") && {alive _x} count crew cursorTarget > 0 && (isNull objectParent player)']);

		//Lockpicking
		life_actions pushBack (player addAction["Pick Vehicle Lock",life_fnc_lockpick,cursorTarget,-1,false,true,"",'!isNull cursorTarget && alive cursorTarget && (player distance cursorTarget) < 4 && life_inv_lockpick > 0 && (locked cursorTarget != 0) && speed cursorTarget < 2 && (cursorTarget isKindOf "Car" || cursorTarget isKindOf "Air" || cursorTarget isKindOf "Ship") && !(cursorTarget in life_vehicles)']);
		life_actions pushBack (player addAction["Disable Building Security",life_fnc_prisonBreak,2,0,false,false,"",' playerSide == civilian && (player distance2d (getMarkerPos "prison_door_1") < 5 || player distance2d (getmarkerPos "prison_door_2") < 5) ']);

		//Hunting
		if(player distance (getMarkerPos "hunting") < 700) then {
			life_actions pushBack (player addAction["Track Animals",life_fnc_trackAnimal,"",-1,false,false,"",'player distance (getMarkerPos "hunting") < 600']);
			life_actions pushBack (player addAction["Skin Animal",life_fnc_skinAnimal,cursorTarget,-1,false,false,"",'!isNull cursorTarget && (player distance cursorTarget) < 4 && life_inv_skinningknife > 0 && (typeOf cursorTarget) in ["Cock_random_F","Goat_random_F","Hen_random_F","Sheep_random_F","Alsatian_Random_F","Rabbit_F","Snake_random_F"] && !alive cursorTarget ']);
			life_actions pushBack (player addAction["Hide Animal Corpse",{deleteVehicle cursorTarget},cursorTarget,-1,false,false,"",'!isNull cursorTarget && (player distance cursorTarget) < 4 &&(typeOf cursorTarget) in ["Cock_random_F","Goat_random_F","Hen_random_F","Sheep_random_F","Alsatian_Random_F","Rabbit_F","Snake_random_F"] && !alive cursorTarget ']);
		};
		//life_actions pushBack (player addAction["Cook Raw Meat",life_fnc_cookMeat,cursorObject,-1,false,false,"",'!isNull cursorObject && (player distance cursorObject) < 4 && (typeOf cursorObject) == "Campfire_burning_F" && (life_inv_chicken > 0 || life_inv_dog > 0 || life_inv_sheep > 0 || life_inv_goat > 0) ']);
		life_actions pushBack (player addAction["Clean Up Campfire",{deleteVehicle cursorObject},cursorObject,-1,false,false,"",'!isNull cursorObject && (player distance cursorObject) < 4 && (typeOf cursorObject) == "Campfire_burning_F" ']);

		// Defibrillator
		life_actions pushBack (player addAction["<t color='#FF0000'>Use Defibrillator</t>",life_fnc_revivePlayer,cursorTarget,-1,false,true,"",'!isNull cursorObject && cursorObject isKindOf "CAManBase" && !(alive cursorTarget) && !(cursorTarget getVariable ["Revive",false]) && life_inv_defib > 0 && (14 in life_talents) && (player distance cursorTarget) < 3.5']);
		// Splint
		life_actions pushBack (player addAction["<t color='#FF0000'>Apply Splint to Self</t>",life_fnc_splint,player,-1,false,true,"",'life_brokenLeg && (13 in life_talents) && (life_inv_splint > 0)']);
		life_actions pushBack (player addAction["<t color='#FF0000'>Apply Splint</t>",life_fnc_splint,cursorTarget,-1,false,true,"",'!isNull cursorTarget && player distance cursorTarget < 3.5 && isPlayer cursorTarget && alive cursorTarget && (cursorTarget getVariable ["broken",false]) && (13 in life_talents) && (life_inv_splint > 0)']);

		//Drop fishing net
		if(surfaceisWater (getPos vehicle player)) then {
			life_actions pushBack (player addAction["Drop Fishing Net",life_fnc_dropFishingNet,"",0,false,true,"",'
			(surfaceisWater (getPos vehicle player)) && (vehicle player isKindOf "Ship") && life_carryWeight < life_maxWeight && speed (vehicle player) < 2 && speed (vehicle player) > -1 && !life_net_dropped ']);
			//Catch fish
			life_actions pushBack (player addAction["Catch Fish",life_fnc_catchFish,"",0,false,false,"",'
			(surfaceIsWater (getPos player)) && count(nearestObjects[getPos player, ["Fish_Base_F"], 3]) > 0 ']);
		};
		//Gather Heroin
		if(player distance (getMarkerPos "illegal_marker_1_0") < 175) then {
			life_actions pushBack (player addAction["Gather Opium",life_fnc_gatherAction,["heroinu",1],3,false,true,"",'
			!life_action_in_use && (player distance (getMarkerPos "illegal_marker_1_0") < 150) && (vehicle player == player) && (life_carryWeight + (["heroinu"] call life_fnc_itemWeight)) <= life_maxWeight ']);
		};

		//Gather Cocaine
		life_actions = life_actions + [player addAction["Gather Cocaine",life_fnc_gatherAction,["cocaine",1],0,false,false,"",'
		!life_action_in_use && (player distance (getMarkerPos "illegal_marker_2_0") < 150) && (vehicle player == player) && (life_carryWeight + (["cocaine"] call life_fnc_itemWeight)) <= life_maxWeight ']];
		
		if (life_delivery_type > 0) then
		{
				life_actions pushBack (player addAction ["Attach sling to cargo", {_r = ropeCreate [vehicle player, "slingload0", life_delivery_object, [0,0,0], 7];}, "", 2, true, true, "", ' vehicle player != player && driver (vehicle player) == player && (vehicle player) isKindOf "AIR" && !(life_delivery_object in (ropeAttachedObjects (vehicle player))) && ((getPos (vehicle player)) distance (getPos life_delivery_object)) < 14 && (getPos (vehicle player)) select 2 < 12 ']);
				life_actions pushBack (player addAction ["Detach all cargo", {{ropeDestroy _x} forEach (ropes (vehicle player));}, "", 2, true, true, "", ' vehicle player != player && (vehicle player) isKindOf "AIR" && life_delivery_object in (ropeAttachedObjects (vehicle player)) ']);
		};

		//Pick Apples, fields 1 and 2
		if({player distance getMarkerPos format["apple_%1",_x] < 75} count [1,2,3,4,5] > 0) then {
			life_actions pushBack (player addAction["Pick Apples",life_fnc_gatherAction,["apple",3],0,false,false,"",'
			!life_action_in_use && {player distance getMarkerPos format["apple_%1",_x] < 50} count [1,2,3,4,5] > 0 && (vehicle player == player) ']);
		};
		//life_actions pushBack (player addAction["Pick Peaches",life_fnc_gatherAction,["peach",3],0,false,false,"",'
		//!life_action_in_use && ((player distance (getMarkerPos "peaches_1") < 50) OR (player distance (getMarkerPos "peaches_2") < 50)) && (vehicle player == player) ']);
		if({player distance getMarkerPos format["peaches_%1",_x] < 75} count [1,2,3,4] > 0) then {
			life_actions pushBack (player addAction["Pick Peaches",life_fnc_gatherAction,["peach",3],0,false,false,"",'
			!life_action_in_use && {player distance getMarkerPos format["peaches_%1",_x] < 50} count [1,2,3,4] > 0 && (vehicle player == player) ']);
		};
		//Pick Apples, fields 3 and 4
		//life_actions pushBack (player addAction["Pick Apples",life_fnc_gatherAction,["apple",3],0,false,false,"",'
		//!life_action_in_use && ((player distance (getMarkerPos "apple_3") < 50) OR (player distance (getMarkerPos "apple_4") < 50)) && (vehicle player == player) ']);

		//Grab turtle
		if({player distance getMarkerPos format["turtle_%1",_x] < 250} count [1,2,3] > 0) then {
			life_actions pushBack (player addAction["Grab Turtle",life_fnc_catchTurtle,"",0,false,false,"",'
			((player distance (getMarkerPos "turtle_1") < 200) OR (player distance (getMarkerPos "turtle_2") < 200) OR (player distance (getMarkerPos "turtle_3") < 200)) && {count (nearestObjects[getPos player,["Turtle_F"],4])  > 0} && {(life_carryWeight + (["turtle"] call life_fnc_itemWeight)) <= life_maxWeight}']);
		};
		//Gather Cannabis
		if({player distance getMarkerPos format["weed_%1",_x] < 75} count [1,2] > 0) then {
			life_actions pushBack (player addAction["Gather Cannabis",life_fnc_gatherAction,["cannabis",1],3,false,true,"",'
			!life_action_in_use && ((player distance (getMarkerPos "weed_1") < 60) OR (player distance (getMarkerPos "weed_2") < 60)) && (vehicle player == player) && (life_carryWeight + (["cannabis"] call life_fnc_itemWeight)) <= life_maxWeight ']);
		};
		//Gathering Meth
		if(player distance (getMarkerPos "illegal_marker_3_0") < 175) then {
			life_actions pushBack (player addAction["Gather Ephedra",life_fnc_gatherAction,["ephedrau",1],0,false,false,"",'
			!life_action_in_use && (player distance (getMarkerPos "illegal_marker_3_0") < 150) && (vehicle player == player) && (life_carryWeight + (["ephedrau"] call life_fnc_itemWeight)) <= life_maxWeight ']);
		};

		//Suicide alahsnackbar
		if(vest player == "V_HarnessOGL_brn") then {
			life_actions pushBack (player addAction["<t color='#FF0000'>Activate Suicide Vest</t>",{["self"] spawn life_fnc_suicideBomb},"",0,false,false,"",' vest player == "V_HarnessOGL_brn" && alive player && playerSide == civilian && !life_istazed && !(player getVariable ["restrained",false]) && !(player getVariable ["Escorting",false]) && !(player getVariable ["transporting",false])']);
		};
		//Mining
		if({player distance getMarkerPos format["mine_%1",_x] < 125} count [1,2,3,4,5,6,7] > 0) then {
			life_actions pushBack (player addAction["Mine Quarry",life_fnc_mining,1,0,false,false,"",'
			!life_action_in_use && ({player distance getMarkerPos format["mine_%1",_x] < 100} count [1,2,3,4,5,6,7] > 0) && (vehicle player == player) && (life_carryWeight + (["diamond"] call life_fnc_itemWeight)) <= life_maxWeight ']);
		};
		/*life_actions pushBack (player addAction["Mine Low Yield",life_fnc_mining,0.7,0,false,false,"",'
		!life_action_in_use && ((player distance (getMarkerPos "mine_2") < 100)) && (vehicle player == player) && (life_carryWeight + (["diamond"] call life_fnc_itemWeight)) <= life_maxWeight ']);

		life_actions pushBack (player addAction["Mine High Yield",life_fnc_mining,2,0,false,false,"",'
		!life_action_in_use && ((player distance (getMarkerPos "mine_6") < 100)) && (vehicle player == player) && (life_carryWeight + (["diamond"] call life_fnc_itemWeight)) <= life_maxWeight ']);*/

		//Gathers Salt
		if(({player distance getMarkerPos format["salt_%1",_x] < 175} count [1,2,3,4] > 0) || {surfaceType position player == "#GdtDead"}) then {
			life_actions pushBack (player addAction["Gather Salt",life_fnc_gatherAction,["salt",1],0,false,false,"",'
			!life_action_in_use && ((player distance (getMarkerPos "salt_1") < 150) OR (player distance (getMarkerPos "salt_2") < 150) OR (player distance (getMarkerPos "salt_3") < 150) OR (player distance (getMarkerPos "salt_4") < 150) OR (surfaceType position player == "#GdtDead")) && (vehicle player == player) && (life_carryWeight + (["salt"] call life_fnc_itemWeight)) <= life_maxWeight ']);
		};
		//Gathers Phos
		if({player distance getMarkerPos format["rock_%1",_x] < 175} count [1,2,3,4] > 0) then {
			life_actions pushBack (player addAction["Gather Phosphorus",life_fnc_gatherAction,["phos",1],0,false,false,"",'
			!life_action_in_use && ((player distance (getMarkerPos "rock_1") < 150) OR (player distance (getMarkerPos "rock_2") < 150) OR (player distance (getMarkerPos "rock_3") < 150) OR (player distance (getMarkerPos "rock_4") < 150)) && (vehicle player == player) && (life_carryWeight + (["phos"] call life_fnc_itemWeight)) <= life_maxWeight ']);
		};
		if(life_adminlevel > 1) then {
			life_actions pushBack (player addAction["Check Registration",{[cursorTarget] spawn life_fnc_searchVehAction},"",0,false,false,"",
			' !isNull cursorTarget && (player distance cursorTarget) < 5 && (cursorTarget isKindOf "Car" || cursorTarget isKindOf "Air" || cursorTarget isKindOf "Ship")']);
		};
		//Gather Oil
		life_actions pushBack (player addAction["Gather Oil",life_fnc_gatherAction,["oilu",1],0,false,false,"",'
		!life_action_in_use && ((player distance (getMarkerPos "oil_1") < 150) OR (player distance (getMarkerPos "oil_2") < 150) OR (player distance (getMarkerPos "oil_3") < 150) OR (player distance (getMarkerPos "oil_4") < 150)) && (vehicle player == player) && (life_inv_pickaxe > 0) && (life_carryWeight + (["oil"] call life_fnc_itemWeight)) <= life_maxWeight ']);

		//Gather Hydrogen Sulfate
		if({player distance getMarkerPos format["oil_%1",_x] < 200} count [1,2,3,4] > 0) then {
			life_actions pushBack (player addAction["Gather Hydrogen Sulfate",life_fnc_gatherAction,["hydro",1],0,false,false,"",'
			!life_action_in_use && ((player distance (getMarkerPos "oil_1") < 150) OR (player distance (getMarkerPos "oil_2") < 150) OR (player distance (getMarkerPos "oil_3") < 150) OR (player distance (getMarkerPos "oil_4") < 150)) && (vehicle player == player) && (life_carryWeight + (["hydro"] call life_fnc_itemWeight)) <= life_maxWeight ']);
		};
		
		//Gather Wood
		if (life_inv_woodaxe > 0) then {
			life_actions pushBack (player addAction ["Chop Tree",life_fnc_chopTree,cursorTarget,0,false,false,"",'player distance [(getPos cursorObject) select 0, (getPos cursorObject) select 1, 0] < 4 && {[str cursorObject," t_"] call KRON_StrInStr || [str cursorObject," palm_"] call KRON_StrInStr}']);
		};
		//Search Wreck
		//life_actions pushBack (player addAction["Search Wreck",life_fnc_searchWreck,"",0,false,false,"",'
		//!life_action_in_use && player distance Land_UWreck_FishingBoat_F < 15 && (vehicle player == player) ']);

		// Mobile Meth (Crank) Lab and Oil Drilling Trucks
		if (cursorTarget in life_vehicles) then {
			life_actions pushBack (player addAction["Get the lab ready",life_fnc_crankLab,cursorTarget,0,false,false,"",'((typeOf cursorTarget == "C_Van_01_box_F") && 	(toLower("mpmissions\__cur_mp.altis\images\Van_01_adds_crank.jpg") in (getObjectTextures cursorTarget)) && !isNull cursorTarget && (player distance cursorTarget) < 5 && !(cursorTarget getVariable["labMode",false]))']);
			life_actions pushBack (player addAction["Break down the lab",life_fnc_crankLab,cursorTarget,0,false,false,"",'((typeOf cursorTarget == "C_Van_01_box_F") && (toLower("mpmissions\__cur_mp.altis\images\Van_01_adds_crank.jpg") in (getObjectTextures cursorTarget)) && !isNull cursorTarget && (player distance cursorTarget) < 5 && (cursorTarget getVariable["labMode",false]))']);
			
			if ((typeOf cursorTarget == "C_Van_01_box_F") && (toLower("mpmissions\__cur_mp.altis\images\Van_01_adds_crank.jpg") in (getObjectTextures cursorTarget)) && !isNull cursorTarget && (player distance cursorTarget) < 5 && cursorTarget getVariable["labMode",false]) then {
				life_actions pushBack (player addAction["Mix Crank cocktail",life_fnc_processAction,"crank",0,false,false,"",' life_inv_ephedrau > 0 && life_inv_phos > 0 && life_inv_hydro > 0 && !life_is_processing']);
			};
			if ((typeOf cursorTarget == "C_Van_01_box_F") && (toLower("mpmissions\__cur_mp.altis\images\Van_01_adds_crank.jpg") in (getObjectTextures cursorTarget)) && !isNull cursorTarget && (player distance cursorTarget) < 5 && cursorTarget getVariable["labMode",false]) then {
				life_actions pushBack (player addAction["Cook Crank",life_fnc_processAction,"crankp",0,false,false,"",' life_inv_crank > 0 && !life_is_processing']);
			};
			
			if (license_civ_oil) then {
				life_actions pushBack (player addAction["Setup Oil Pump",life_fnc_oilPump,cursorTarget,0,false,false,"",'((typeOf cursorTarget in ["B_Truck_01_fuel_F","C_Truck_02_fuel_F","C_Van_01_fuel_F"]) && !isNull cursorTarget && (player distance cursorTarget) < 5 && !(cursorTarget getVariable["oilPump",false]))']);
				life_actions pushBack (player addAction["Break Down Oil Pump",life_fnc_oilPump,cursorTarget,0,false,false,"",'((typeOf cursorTarget in ["B_Truck_01_fuel_F","C_Truck_02_fuel_F","C_Van_01_fuel_F"]) && !isNull cursorTarget && (player distance cursorTarget) < 5 && (cursorTarget getVariable["oilPump",false]))']);
				
				if((typeOf cursorTarget in ["B_Truck_01_fuel_F","C_Truck_02_fuel_F","C_Van_01_fuel_F"]) && !isNull cursorTarget && (player distance cursorTarget) < 5 && (cursorTarget getVariable["oilPump",false])) then {
						life_actions pushBack (player addAction["Drill for Oil!",life_fnc_drillOil,cursorTarget,0,false,false,"",' license_civ_oil && !life_is_processing']);
				};
			};
		};
		
		//Houses
		life_actions pushBack (player addAction["<t color='#00FF00'>House Menu</t>",life_fnc_houseMenu,cursorObject,-1,false,false,"",'!isNull cursorObject && (player distance cursorObject) < 20 && (isNull objectParent player) && cursorObject isKindOf "House" && ([typeOf cursorObject] call life_fnc_housePrice) > -1 && !(cursorObject getVariable ["noSale", false]) && {!(([cursorObject] call life_fnc_getBuildID) in life_public_houses)}']);
		if(count life_houses > 0) then {
			life_actions pushBack (player addAction["<t color='#FF0000'>Toggle All House Locks</t>",life_fnc_lockHouse,cursorObject,-1,false,false,"",'!isNull cursorObject && (player distance cursorObject) < 20 && cursorObject isKindOf "House" && ((cursorObject in life_houses) || ((life_gang != "0") && ([cursorObject] call life_fnc_getBuildID) == life_gang))']);
			life_actions pushBack (player addAction["<t color='#FFFF00'>Show Storage</t>",{cursorObject setVariable ["storageToggled",time]; [true,cursorObject,player] remoteExecCall ["ASY_fnc_toggleStorage",2];},cursorObject,-1,false,true,"",'!isNull cursorObject && (player distance cursorObject) < 20 && cursorObject isKindOf "House" && ((cursorObject in life_houses) || ((life_gang != "0") && ([cursorObject] call life_fnc_getBuildID) == life_gang)) && time - (cursorObject getVariable ["storageToggled",0]) > 15 && !(cursorObject getVariable ["storageVisible",false])']);
			life_actions pushBack (player addAction["Vehicle Garage",life_fnc_vehicleGarage,"car",0,false,true,"",' !isNull cursorObject && (player distance cursorObject) < 20 && cursorObject isKindOf "House" && (typeOf cursorObject in ["Land_i_Garage_V1_F","Land_i_Garage_V2_F","Land_i_Garage_V1_dam_F","Land_i_Shed_Ind_F","Land_House_Big_02_F","Land_House_Big_03_F"]) && ((cursorObject in life_houses) || ((cursorObject getVariable["life_locked", 1]) == 0)) ']);
			life_actions pushBack (player addAction["Store Vehicle in Garage",life_fnc_storeVehicleGarage,"""",0,false,true,"""",' !life_garage_store && !isNull cursorObject && (player distance cursorObject) < 20 && cursorObject isKindOf "House" && (typeOf cursorObject in ["Land_i_Garage_V1_F","Land_i_Garage_V2_F","Land_i_Garage_V1_dam_F","Land_i_Shed_Ind_F","Land_House_Big_02_F","Land_House_Big_03_F"]) && ((cursorObject in life_houses) || (cursorObject getVariable["life_locked", 1]) == 0) ']);
		};
		// Tent
		life_actions pushBack (player addAction["Item Storage",life_fnc_openInventory,cursorObject,0,false,true,"",' !isNull cursorObject && (player distance cursorObject) < 9 && ((typeOf cursorObject) in ["Land_TentA_F","Land_TentDome_F"]) ']);

		//Rob vehicle for events
		//life_actions pushBack (player addAction["<t color='#FF0000'>Rob Vehicle</t>",life_fnc_robVehicle,"",-1,false,false,"",'alive cursorTarget && (player distance cursorTarget) < 10 && cursorTarget getVariable["canRob",false]']);

		//bounty hunter
		if(license_civ_bounty) then {
			life_actions pushBack (player addAction["Send to Jail",life_fnc_arrestAction,"",0,false,false,"",
			'!isNull cursorTarget && isPlayer cursorTarget && license_civ_bounty && (side cursorTarget == civilian) && (cursorTarget getVariable ["restrained",false]) && (cursorTarget getVariable ["isCivRestrained",false]) && alive cursorTarget && (player distance cursorTarget < 3.5) && (({player distance (getMarkerPos _x) < 30} count ["courthouse_1","courthouse_2","courthouse_3","courthouse_4","courthouse_5","courthouse_6","courthouse_7","jail_release2"] >0) || {player distance getMarkerPos _x < 15} count ["marker_609","marker_606","marker_607","marker_608"] > 0) && !(cursorTarget getVariable ["Escorting",false]) ']);
			life_actions pushBack (player addAction["Send Combat Logger to Jail",{[cursorObject] spawn life_fnc_jailCL},"",0,false,false,"",'!isNull cursorObject && !(isPlayer cursorObject) && license_civ_bounty && (player distance cursorObject < 3.5) && !((cursorObject getVariable ["clData",[]]) isEqualTo []) && ((typeOf cursorObject) isEqualTo "Land_Bodybag_01_black_F")']);
			life_actions pushBack (player addAction["Bounty Hunter Enter as Driver",life_fnc_copEnter,"driver",200,false,false,"",'(cursorTarget in life_vehicles) && {!isNull cursorTarget && ((cursorTarget isKindOf "Car")||(cursorTarget isKindOf "Air")||(cursorTarget isKindOf "Ship")) && (locked cursorTarget) != 0 && cursorTarget distance player < 5} && !(isNil {cursorTarget getVariable["isTransporting",nil]})']);
			life_actions pushBack (player addAction["Bounty Hunter Enter as Passenger",life_fnc_copEnter,"passenger",100,false,false,"",'(cursorTarget in life_vehicles) && {!isNull cursorTarget && ((cursorTarget isKindOf "Car")||(cursorTarget isKindOf "Air")||(cursorTarget isKindOf "Ship")) && (locked cursorTarget) != 0 && cursorTarget distance player < 5} && !(isNil {cursorTarget getVariable["isTransporting",nil]})']);
			
			if(player getVariable ["activeBounty", false] || count life_bounty_contract > 0) then {
				life_actions pushBack (player addAction ["<t color='#FF00FF'>Hide Badge</t>", { player setVariable ["activeBounty", nil, true]; }, 3, 0, false, true, "", ' (player getVariable ["activeBounty", false]) ']);
				life_actions pushBack (player addAction ["<t color='#FF00FF'>Show Badge</t>", { player setVariable ["activeBounty", true, true]; }, 3, 0, false, true, "", ' !(player getVariable ["activeBounty", false]) && count life_bounty_contract > 0 ']);
			};
		};
		//Rob person
		life_actions pushBack (player addAction["Rob Person",life_fnc_robAction,"",0,false,false,"",'
		!isNull cursorTarget && !(currentWeapon player in life_disallowedThreatWeapons) && ((cursorTarget getVariable ["playerSurrender",false]) || (cursorTarget getVariable["restrained",false] && 16 in life_honortalents && 126 in life_talents && cursorTarget getVariable ["isCivRestrained",false])) && cursorTarget isKindOf "Man" && (isPlayer cursorTarget) && alive cursorTarget && cursorTarget distance player < 5 && !(cursorTarget getVariable ["Escorting",false]) && speed cursorTarget < 1 ']);

		// Bank
		if(player distance getMarkerPos "fed_reserve" < 400) then {
			life_actions pushBack (player addAction ["Hack Vault Doors", life_fnc_openVault, "",0,false,false,"",' (typeOf cursorTarget) in ["Land_Dome_Big_F","Land_Dome_Small_F"] && (player distance (getMarkerPos "vault_1") < 6 || player distance (getMarkerPos "vault_2") < 6 || player distance (getMarkerPos "vault_3") < 6 || player distance (getMarkerPos "vault_4") < 6 || player distance (getMarkerPos "vault_5") < 6 || player distance (getMarkerPos "vault_6") < 6 || player distance (getMarkerPos "vault_hack_1") < 1 || player distance (getMarkerPos "vault_hack_2") < 1 || player distance (getMarkerPos "vault_hack_3") < 1 || player distance (getMarkerPos "vault_hack_4") < 1 || player distance (getMarkerPos "vault_hack_5") < 1 || player distance (getMarkerPos "vault_hack_6") < 1 || player distance (getMarkerPos "vault_hack_7") < 1 || player distance (getMarkerPos "vault_hack_8") < 1) && life_inv_drill > 0 ']);
			life_actions pushBack (player addAction ["Crack Safe", life_fnc_openSafe,false,0,false,false,"",' _inRange = false; { if ((player distance _x) < 1) then { _inRange = true; }; } forEach life_bank_safe_pos; ((typeOf cursorTarget) in ["Land_Research_house_V1_F","Land_Research_HQ_F"] && _inRange && life_inv_drill > 0) ']);
			life_actions pushBack (player addAction ["Plant Demo Charge", life_fnc_openSafe,true,0,false,false,"",' _inRange = false; { if ((player distance _x) < 1) then { _inRange = true; }; } forEach life_bank_safe_pos; ((typeOf cursorTarget) in ["Land_Research_house_V1_F","Land_Research_HQ_F"] && _inRange && life_inv_demoCharge > 0 && (116 in life_talents)) ']);
			life_actions pushBack (player addAction ["Bolt Cut Gate", life_fnc_openGate, "",0,false,false,"",' ((typeOf cursorTarget) == "Land_BarGate_F" && (cursorTarget getVariable ["gate_max", 0]) == 0 && (player distance cursorTarget) < 7 && life_inv_boltCutter > 0) ']);
		};
		life_actions pushBack (player addAction ["Begin Drilling Vault", life_fnc_openBankVault,false,4,true,true,"",' player distance (getMarkerPos "life_bank_door") < 4 && life_inv_drill > 0 && !life_bank_drilling && life_bank_last < serverTime - 1200 ']);
		if({player distance getMarkerPos format["race_%1_start",_x] < 25} count [1,2,3,4,5] > 0) then {
			life_actions pushBack (player addAction ["Join Race", life_fnc_joinRace,1,0,false,false,"",' {player distance getMarkerPos format["race_%1_start",_x] < 15} count [1,2,3,4,5] > 0 && vehicle player != player && driver (vehicle player) == player ']);
		};
		life_actions pushBack (player addAction ["Open Treasure Chest",{[nil,nil,nil,cursorTarget] call life_fnc_openInventory},"",0,false,false,"",' (player distance cursorTarget) < 4 && typeOf cursorTarget == "Box_East_Support_F" && (cursorTarget getVariable ["Treasure",false]) ']);
		//life_actions pushBack (player addAction ["Join Race Two", life_fnc_joinRace,2,0,false,false,"",' (player distance (getMarkerPos "race_2_start")) < 15 && vehicle player != player && driver (vehicle player) == player ']);
		//life_actions pushBack (player addAction ["Join Race Three", life_fnc_joinRace,3,0,false,false,"",' (player distance (getMarkerPos "race_3_start")) < 15 && vehicle player != player && driver (vehicle player) == player ']);
		//life_actions pushBack (player addAction ["Join Race Four", life_fnc_joinRace,4,0,false,false,"",' (player distance (getMarkerPos "race_4_start")) < 15 && vehicle player != player && driver (vehicle player) == player ']);
		//life_actions pushBack (player addAction ["Join Race Five", life_fnc_joinRace,5,0,false,false,"",' (player distance (getMarkerPos "race_5_start")) < 15 && vehicle player != player && driver (vehicle player) == player ']);
	};
};
//Vehicle Towing
//life_actions pushBack (player addAction["<t color='#0000FF'>Tow Vehicle</t>",life_fnc_towVehicle,"",999,false,false,"",'(vehicle player != player) && (count (nearestObjects [vehicle player, ["Car","Ship"], 8]) > 0)']);

//Pull out dead
life_actions pushBack (player addAction["Pull Out Unconscious",{
	_vehicle = cursorTarget;
	_locked = locked _vehicle;
	_vehicle lock 0;
	player moveInDriver _vehicle;
	{
		moveOut player;
		player moveInCargo [_vehicle,_vehicle getCargoIndex _x];
	} forEach (crew cursorTarget - [driver cursorTarget]);
	[_vehicle,_locked] spawn {
		sleep 1.5;
		player action["Eject",vehicle player];
		moveOut player;
		if ((_this select 1) == 2) then {(_this select 0) lock 2};
	};
},cursorTarget,0,false,false,"",' !isNull cursorTarget && (isNull objectParent player) && alive cursorTarget && (player distance cursorTarget) < 4 && (count crew cursorTarget) > 0 && {!alive _x} count crew cursorTarget > 0 && (cursorTarget isKindOF "Car" || cursorTarget isKindOf "Ship" || cursorTarget isKindOf "Air") && if(playerSide == civilian) then {15 in life_talents} else {true}']);
//Car controls
life_actions pushBack (player addAction ["<t color='#BBBB00'>Put Seatbelt On</t>", {life_seatbelt=true; playSound "seatbelt"}, "", 0, false, true, "", 'vehicle player isKindOf "Car" && !life_seatbelt']);
//life_actions pushBack (player addAction ["<t color='#BBBB00'>Take Seatbelt Off</t>", {life_seatbelt=false}, "", 3, false, true, "", 'vehicle player isKindOf "Car" && life_seatbelt']);
/*if(vehicle player != player) then {
	life_actions pushBack (player addAction ["<t color='#DDDD00'>Turn Signal OFF</t>",{[vehicle player,0] remoteExecCall ["life_fnc_turnSignal",2];(vehicle player) setVariable ["signal",0,true]},"",2,false,false,"",' vehicle player != player && ((typeOf vehicle player) in ["C_Offroad_01_F","B_G_Offroad_01_F","B_G_Offroad_01_armed_F","C_SUV_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Van_01_box_F","C_Van_01_transport_F"]) && ((driver vehicle player) == player) && ((vehicle player getVariable ["signal", 0]) != 0)']);
	life_actions pushBack (player addAction ["<t color='#DDDD00'>Turn Signal LEFT</t>",{[vehicle player,1] remoteExecCall ["life_fnc_turnSignal",2];(vehicle player) setVariable ["signal",1,true]},"",2,false,false,"",' vehicle player != player && ((typeOf vehicle player) in ["C_Offroad_01_F","B_G_Offroad_01_F","B_G_Offroad_01_armed_F","C_SUV_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Van_01_box_F","C_Van_01_transport_F"]) && ((driver vehicle player) == player) && ((vehicle player getVariable ["signal", 0]) != 1)']);
	life_actions pushBack (player addAction ["<t color='#DDDD00'>Turn Signal RIGHT</t>",{[vehicle player,2] remoteExecCall ["life_fnc_turnSignal",2];(vehicle player) setVariable ["signal",2,true]},"",2,false,false,"",' vehicle player != player && ((typeOf vehicle player) in ["C_Offroad_01_F","B_G_Offroad_01_F","B_G_Offroad_01_armed_F","C_SUV_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Van_01_box_F","C_Van_01_transport_F"]) && ((driver vehicle player) == player) && ((vehicle player getVariable ["signal", 0]) != 2)']);
};*/
//Unflip action
life_actions pushBack (player addAction["Unflip Vehicle",life_fnc_flip,"",-1,false,false,"",'(cursorTarget isKindOf "Car" || cursorTarget isKindOf "Air") && (vehicle player == player) && (player distance cursorTarget < 8) && (local cursorTarget || cursorTarget in life_vehicles || vectorUp cursorTarget select 2 < 0.6 || vectorUp cursorTarget select 1 > 0.2 || vectorUp cursorTarget select 1 < -0.2) && (speed cursorTarget < 1)']);

// helicopter eject action (engine still running)
if(vehicle player isKindOf "Air" && driver vehicle player == player) then {
	life_actions pushBack (player addAction ["Eject", {_veh = vehicle player; if(_veh != player) then {_engineOn = isEngineOn _veh; player action ["GetOut", _veh]; sleep 1;};}, "", 6, false, false, "", 'vehicle player isKindOf "Air" && driver vehicle player == player;']);
};
//life_actions pushBack (player addAction["Repair Vehicle ($50)",life_fnc_pumpRepair,"",999,false,false,"",
//' vehicle player != player && (typeOf cursorObject == "Land_fs_feed_F") && (vehicle player) distance cursorObject < 6 ']);
//life_actions pushBack (player addAction["Place Spike Strip",{if(!isNull life_spikestrip) then {detach life_spikeStrip; life_spikeStrip = ObjNull;};},"",999,false,false,"",'!isNull life_spikestrip']);
//Use Chemlights in hand
/*life_actions pushBack (player addAction["Chemlight (RED) in Hand",life_fnc_chemlightUse,"red",-1,false,false,"",
' isNil "life_chemlight" && "Chemlight_red" in (magazines player) && vehicle player == player ']);
life_actions pushBack (player addAction["Chemlight (YELLOW) in Hand",life_fnc_chemlightUse,"yellow",-1,false,false,"",
' isNil "life_chemlight" && "Chemlight_yellow" in (magazines player) && vehicle player == player ']);
life_actions pushBack (player addAction["Chemlight (GREEN) in Hand",life_fnc_chemlightUse,"green",-1,false,false,"",
' isNil "life_chemlight" && "Chemlight_green" in (magazines player) && vehicle player == player ']);
life_actions pushBack (player addAction["Chemlight (BLUE) in Hand",life_fnc_chemlightUse,"blue",-1,false,false,"",
' isNil "life_chemlight" && "Chemlight_blue" in (magazines player) && vehicle player == player ']);
//Drop Chemlight
life_actions pushBack (player addAction["Drop Chemlight",{if(isNil "life_chemlight") exitWith {};if(isNull life_chemlight) exitWith {};detach life_chemlight; life_chemlight = nil;},"",-1,false,false,"",'!isNil "life_chemlight" && !isNull life_chemlight && vehicle player == player ']);
//Custom Heal*/
//life_actions pushBack (player addAction["<t color='#FF0000'>Heal Self</t>",life_fnc_heal,"",99,false,false,"",' vehicle player == player && (damage player) > 0.25 && ("FirstAidKit" in (items player)) && (currentWeapon player == "")']);
//Custom Repair
life_actions pushBack (player addAction["<t color='#FF0000'>Repair Vehicle</t>",life_fnc_repairTruck,"",0,false,false,"", ' vehicle player == player && !isNull cursorTarget && alive cursorTarget && ((cursorTarget isKindOf "Car") OR (cursorTarget isKindOf "Air") OR (cursorTarget isKindOf "Ship")) && (player distance cursorTarget < 4.5) ']);
//Service Truck Stuff
life_actions pushBack (player addAction["<t color='#0000FF'>Service Nearest Car</t>",life_fnc_serviceTruck,"",99,false,false,"",' (typeOf (vehicle player) == "C_Offroad_01_F") && ((vehicle player animationPhase "HideServices") == 0) && ((vehicle player) in life_vehicles) && (speed vehicle player) < 1 ']);
life_actions pushBack (player addAction["Push",life_fnc_pushVehicle,"",0,false,false,"",'!isNull cursorTarget && player distance cursorTarget < 4.5 && cursorTarget isKindOf "Ship"']);

//Pickup Item
life_actions pushBack (player addAction["Pickup Item(s)",{createDialog "life_pickup_items"},"",0,false,false,"",
' !isNull cursorObject && count (cursorObject getVariable ["item",[]]) > 0 && player distance cursorObject < 5 ']);

life_actions pushBack (player addAction["<t color='#00FF00'>Activate Nitro</t>",life_fnc_activateNitro,false,2,false,false,"",
' (vehicle player != player) && (driver vehicle player == player) && (((vehicle player) getVariable["nitro", 0]) > 0) ']);

life_actions pushBack (player addAction["<t color='#FF0000'>Use Pain Killers</t>",life_fnc_painkillers,player,-1,false,false,"",'(life_pain > 0) && (life_inv_painkillers > 0)']);
life_actions pushBack (player addAction["<t color='#FF0000'>Give Pain Killers</t>",life_fnc_painkillers,cursorTarget,-1,false,false,"",'vehicle player == player && !isNull cursorTarget && player distance cursorTarget < 3.5 && (isPlayer cursorTarget) && (alive cursorTarget) && ((cursorTarget getVariable ["pain",0]) > 0) && ((life_inv_painkillers > 0) || (26 in life_coptalents))']);

life_actions pushBack (player addAction["<t color='#FF0000'>Blood Transfusion Self</t>",life_fnc_bloodbag,player,-1,false,false,"",'vehicle player == player && ((playerSide == independent && damage player > 0) || ((10 in life_talents || 90 in life_talents) && damage player > 0.2) || ((11 in life_talents || 91 in life_talents) && damage player > 0.1) || ((12 in life_talents || 92 in life_talents) && damage player > 0)) && (life_inv_bloodbag > 0)']);
life_actions pushBack (player addAction["<t color='#FF0000'>Give Blood Transfusion</t>",life_fnc_bloodbag,cursorTarget,-1,false,false,"",'vehicle player == player && !isNull cursorTarget && isPlayer cursorTarget && alive cursorTarget && player distance cursorTarget < 3.5 && ((playerSide == independent && damage cursorTarget > 0) || ((10 in life_talents || 90 in life_talents) && damage cursorTarget > 0.2) || ((11 in life_talents || 91 in life_talents) && damage cursorTarget > 0.1) || ((12 in life_talents || 92 in life_talents) && damage cursorTarget > 0)) && (life_inv_bloodbag > 0)']);
if(player getVariable ["blindfolded",false]) then {
	life_actions pushBack (player addAction["Remove Own Blindfold",life_fnc_blindfoldRemove,player,-1,false,false,"",' player getVariable ["blindfolded",false] && !(player getVariable ["restrained",false]) && alive player ']);
};
/*if(("ItemRadio" in (assignedItems player))) then {
	life_actions pushBack (player addAction["<t color='#AAAAAA'>Turn Radio On</t>",life_fnc_useRadio,0,-1,false,false,"",' (life_radio_chan < 0) && ("ItemRadio" in (assignedItems player)) ']);
	life_actions pushBack (player addAction["<t color='#AAAAAA'>Turn Radio Off</t>",life_fnc_useRadio,-1,-1,false,false,"",' (life_radio_chan > -1) && ("ItemRadio" in (assignedItems player)) ']);
	life_actions pushBack (player addAction["<t color='#AAAAAA'>Tune Radio Chan 1</t>",life_fnc_useRadio,0,-1,false,false,"",' (life_radio_chan > -1) && (life_radio_chan != 0) && ("ItemRadio" in (assignedItems player)) ']);
	life_actions pushBack (player addAction["<t color='#AAAAAA'>Tune Radio Chan 2</t>",life_fnc_useRadio,1,-1,false,false,"",' (life_radio_chan > -1) && (life_radio_chan != 1) && ("ItemRadio" in (assignedItems player)) ']);
};*/
//life_actions pushBack (player addAction["Increase Rope Length",life_fnc_ropeLength,true,-1,true,true,"",' (vehicle player) != player && driver (vehicle player) == player && count (ropes (vehicle player)) > 0 && ropeUnwound ((ropes (vehicle player)) select 0)']);
//life_actions pushBack (player addAction["Decrease Rope Length",life_fnc_ropeLength,false,-1,true,true,"",' (vehicle player) != player && driver (vehicle player) == player && count (ropes (vehicle player)) > 0 && ropeUnwound ((ropes (vehicle player)) select 0)']);

//life_actions pushBack (player addAction["Attach Tow Rope From",{ life_target_towRope = cursorTarget; [] spawn { sleep 8; if (!isNull life_target_towRope) then { life_target_towRope = objNull } } },"",-1,true,true,"",' (cursorTarget isKindOf "Air" || cursorTarget isKindOf "Car") && (vehicle player) == player && life_inv_towRope > 0 && locked cursorTarget < 2 && isNull life_target_towRope ']);
//life_actions pushBack (player addAction["Connect Tow Rope To",life_fnc_ropeTow,cursorTarget,-1,true,true,"",' !isNull life_target_towRope && cursorTarget != life_target_towRope && (player distance life_target_towRope) < 15 && (cursorTarget isKindOf "Air" || cursorTarget isKindOf "Car") && (vehicle player) == player && life_inv_towRope > 0 ']);
if(life_is_arrested) then {
	life_actions pushBack (player addAction["<t color='#FF0000'>Shank!</t>",{[cursorTarget] call life_fnc_useShank},3,-1,false,false,"",' !isNull cursorTarget && cursorTarget isKindOf "Man" && isPlayer cursorTarget && alive cursorTarget && life_inv_shank > 0  && vehicle player == player && player distance cursorTarget < 2 ']);
};
if({player distance getMarkerPos format["bounty_%1",_x] < (life_track_radius + 100)} count [0,1,2,3] > 0) then {
	life_actions pushBack (player addAction ["<t color='#FF0000'>Track Fugitive 1</t>", life_fnc_trackBounty, 0, 0, false, true, "", ' player distance (getMarkerPos "bounty_0") < life_track_radius ']);
	life_actions pushBack (player addAction ["<t color='#FF0000'>Track Fugitive 2</t>", life_fnc_trackBounty, 1, 0, false, true, "", ' player distance (getMarkerPos "bounty_1") < life_track_radius ']);
	life_actions pushBack (player addAction ["<t color='#FF0000'>Track Fugitive 3</t>", life_fnc_trackBounty, 2, 0, false, true, "", ' player distance (getMarkerPos "bounty_2") < life_track_radius ']);
	life_actions pushBack (player addAction ["<t color='#FF0000'>Track Fugitive 4</t>", life_fnc_trackBounty, 3, 0, false, true, "", ' player distance (getMarkerPos "bounty_3") < life_track_radius ']);
	life_actions pushBack (player addAction ["<t color='#FF0000'>Track APB Target</t>", life_fnc_trackBounty, 9999, 0, false, true, "", ' player distance (getMarkerPos "bounty_9999") < life_track_radius ']);
};
// Environmental
life_actions pushBack (player addAction["<t color='#0099FF'>Sit Down</t>",{[cursorObject,player] execVM "Chair\sitdown.sqf"},true,1,true,true,"""",'player distance cursorObject < 3 && {([str cursorObject,"bench"] call KRON_StrInStr || [str cursorObject,"chair"] call KRON_StrInStr)} ']);

if(surfaceIsWater position player) then {
	life_actions pushBack (player addAction["<t color='#0099FF'>Collect Water</t>",life_fnc_gatherAction,["saltwater",2],1,false,true,"""",'surfaceIsWater position player && vehicle player == player && (getPosASL player) select 2 < 1']);
};
life_actions pushBack (player addAction["<t color='#ADFF2F'>ATM</t>",life_fnc_atmMenu,false,1,true,true,"""",'((player distance cursorObject < 3 && {typeOf cursorObject in ["Land_Mattaust_ATM","Land_atm"] || [str cursorObject,"atm_0"] call KRON_StrInStr}))']);
life_actions pushBack (player addAction["<t color='#FFFF2F'>Gang Account</t>",life_fnc_atmMenu,true,1,true,true,"""",'(life_gang != "0") && (player distance cursorObject < 3 && {typeOf cursorObject in ["Land_Mattaust_ATM","Land_atm"] || [str cursorObject,"atm_0"] call KRON_StrInStr})']);

// Bicycle
//life_actions pushBack (player addAction["<t color='#0099FF'>Upright Bicycle</t>",{cursorTarget setVectorUp [0,0,1]},false,1,true,true,"""",'player distance cursorTarget < 3 && cursorTarget isKindOf "Bicycle" && (vectorUp cursorTarget) select 2 < 0.5 ']);

// Place Object
life_actions pushBack (player addAction["Place Object",life_fnc_placedObject,player,0,false,false,"",'!isNull life_placing']);

/*if(vehicle player isKindOf "Air") then {
	life_actions pushBack (player addAction["<t color='#ffff00'>Toss Ropes</t>", zlt_fnc_createropes, [], -1, false, false, '','[] call zlt_fnc_ropes_cond and player == driver vehicle player']);
	life_actions pushBack (player addAction["<t color='#ff0000'>Cut Ropes</t>", zlt_fnc_removeropes, [], -1, false, false, '','not zlt_mutexAction and count ((vehicle player) getvariable ["zlt_ropes", []]) != 0 and player == driver vehicle player']);
	life_actions pushBack (player addAction["<t color='#00ff00'>Fast Rope</t>", zlt_fnc_fastrope, [], 15, false, false, '','not zlt_mutexAction and count ((vehicle player) getvariable ["zlt_ropes", []]) != 0 and player != driver vehicle player and !(player getVariable["restrained",false]) && !(player in[vehicle player turretUnit [0]])']);
};*/

//Parking
/*if (worldName == "Tanoa") then {
life_actions pushBack (player addAction["Inspect Parking Meter",{_time = (cursorObject getVariable ["parkTime", time]) - time; if (_time > 1) then { hint format["This parking meter expires in %1 minute(s).", floor (_time / 60 )]} else { hint "There is no valid time on this parking meter." }; },nil,1,true,true,"""",'player distance cursorObject < 3 && {[str cursorObject,"parkingmeter"] call KRON_StrInStr} ']);
life_actions pushBack (player addAction["Add 5 minutes ($10)",{if ([10] call life_fnc_debitCard) then { _time = (cursorObject getVariable ["parkTime", time]); if (_time < time) then { _time = time }; _time = _time + 300; cursorObject setVariable ["parkTime", _time, true]; hint "You added 5 minute(s) to this parking meter." } else { hint "You do not have $10 with which to add time to this meter." }; },nil,1,true,true,"""",'player distance cursorObject < 3 && {[str cursorObject,"parkingmeter"] call KRON_StrInStr} ']);
};*/
