/*
	File: fn_gatherAction.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Master gathering script, to replace all inferior scripts!
*/

private["_sum","_stones","_originalPos"];

_item = [_this select 3,0,"",[""]] call BIS_fnc_param;
_count = [_this select 3,1,1,[1]] call BIS_fnc_param;
_delayFx = switch (life_configuration select 12) do {
    case 1:{.95};
    case 2:{.9};
    case 3:{.85};
    case 4:{.8};
    default {1};
};
_delay = (5 * _delayFx);
_nBuilding = nearestBuilding player; 
if (_item in ["cannabis"]) exitWith { (_this select 3) spawn life_fnc_zoneGather; };

if (life_action_in_use) exitWith {hint "You're too busy to gather right now."};
if (life_last_gather > time - 10) exitWith { hint "You just finished gathering; wait a few seconds before gathering again." };

_stones = ["diamond","copperore","ironore","rock"];

if (life_inv_pickaxe < 1 && _item in _stones) exitWith { hint "You must have a pickaxe in order to gather this resource."; };

if ((_item == "copperore") && (49 in life_talents)) then { _count = _count + 1; };
if ((_item == "ironore") && !(51 in life_talents)) exitWith { hint "You must have the talent Iron Miner to mine iron ore."; };
if ((_item == "diamond") && !(52 in life_talents)) exitWith { hint "You must have the talent Diamond Miner to mine diamonds."; };
//if ((_item == "oil") && !(105 in life_talents)) exitWith { hint "You must have the talent Oil Runner to gather oil."; };

_itemName = [([_item,0] call life_fnc_varHandle)] call life_fnc_varToStr;

titleText[format["Gathering %1...",_itemName],"PLAIN"];
_originalPos = getPos player;
life_action_in_use = true;

if (_item in _stones) then
{
	[] spawn
	{
		private ["_i"];
		_i = 0;
		while {life_action_in_use} do
		{
			if (_i == 0) then {[player, "pickaxe",10] remoteExecCall ["life_fnc_playSound",-2]; _i = 1; }
			else { _i = 0; };
			player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
			waitUntil{animationState player != "ainvpercmstpsnonwnondnon_putdown_amovpercmstpsnonwnondnon";};
			//sleep 2.5;
		};
	};
};

while {life_carryWeight < life_maxWeight} do
{
	life_last_gather = time;
	if (!(alive player)) exitWith {};
	if (speed player > 1 || player distance2D _originalPos > 2 || !life_action_in_use || (vehicle player != player)) exitWith { titleText["Gathering aborted. You must remain still while gathering.","PLAIN"]; };
	if (player distance _nBuilding <= 10) exitWith { hint "You can't gather items so close to a building."};
	if (life_carryWeight >= life_maxWeight) exitWith { titleText [format["Gathering done. You can't hold more %1.", _itemName],"PLAIN"]; };
	if (_item == "ephedrau" && 9 in life_gangtalents) then { if (random 3 < 1) then { _count = 2} else {_count = 1}; };
	_sum = [_item,_count,life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
	if(_sum > 0) then
	{
		sleep _delay;
		life_last_gather = time;
		if (!life_action_in_use) exitWith {};
		if (isWeaponDeployed player) exitWith { hint "You can't possibly gather while your bipod is deployed." };
		if(!([true,_item,_count] call life_fnc_handleInv)) exitWith
		{
			titleText [format["Gathering done. You can't hold more %1.", _itemName],"PLAIN"];
		};
		titleText [format["Gathered %1 %2. [%3/%4]",_count,_itemName,life_carryWeight,life_maxWeight],"PLAIN"];
		if (random 120 < 1) then { _type = ["lootcrate1","lootcrate2","lootcrate3"] call BIS_fnc_selectRandom; [true,_type,1] call life_fnc_handleInv; titleText ["You found a loot crate!","PLAIN"]; };
		titleFadeOut 1;
		if (([] call life_fnc_calTalents) < 6) then { life_experience = life_experience + 1; };
//[6, player, format["Picked %1 %2", _sum, _itemName]] remoteExecCall ["ASY_fnc_logIt",2];
	};
};

life_action_in_use = false;
life_last_gather = time;
