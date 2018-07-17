/*

	Description: Update small bits of player data as they change, instead of 1 big update.

*/
private["_mode","_packet","_array","_flag","_inv","_select"];
_mode = param [0,0,[0]];

if (X_Server) exitWith {};
if (!life_session_completed) exitWith {};
if (life_activeSWAT)  exitWith {};//Don't sync if swat
if ((player distance (getMarkerPos "Respawn_west")) < 750) exitWith {};//Debug island
if ((player distance (getMarkerPos "courtroom")) < 50) exitWith {};//In the ocean
if ((player distance (getMarkerPos "lasertag")) < 35) exitWith {};//Don't save gear or position
if ((player distance (getMarkerPos "life_bank_door")) < 55) exitWith {};//Don't save position
if (typeName life_clothing_store == "STRING") exitWith {};//Can't sync gear

if (life_corruptData || (life_moneyCache != (life_money / 2) + 5) || (life_atmmoneyCache != (life_atmmoney / 2) + 3)) exitWith {
	[] spawn {
		life_corruptData = true;
		hint "YOUR CHARACTER DATA HAS BEEN CORRUPTED. Log out to the lobby and rejoin to fix this. None of your progress will be saved until this is done.";
		[911, player, "Money MEMORY HACK! Ban!"] remoteExecCall ["ASY_fnc_logIt",2];
	};
};

_packet = [steamid,playerSide,nil,_mode];
_array = [];
_flag = switch(playerSide) do {case west: {"cop"}; case civilian: {"civ"}; case independent: {"med"};};

switch(_mode) do {
	case 0: {//Sync cash on hand
		_packet set[2,life_cash];
	};

	case 1: {//Sync bank
		_packet set[2,life_atmcash];
	};
	
	case 2: {//Sync both cash and bank
		_packet set[2,life_cash];
		_packet set[4,life_atmcash];
	};

	case 3: {//Sync licenses
		_packet set[2,_array];
	};

	case 4: {//Sync Gear
		_inv = [];
		{
			_val = missionNameSpace getVariable _x;
			if(_val > 0 && _x != "life_inv_dirty_money") then
			{
				_inv set[count _inv, [_x,_val]];
			};
		} foreach life_inv_items;

		if(playerSide == west) then {
			_select = if(life_coprole == "detective") then {1} else {0};
			life_yItems set[_select,_inv];
		} else {life_yItems = _inv};
		_packet set[2, life_yItems];
	};

	case 5: {//Sync arrest status (jail time served, etc.)
		_packet set[2,life_is_arrested];
	};

	case 6: {
		
	};
};