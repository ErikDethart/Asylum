/*
	File: fn_copSplit.sqf
	Author: John "Paratus" VanderZwet, optimized by Gnashes

	Description:
	Distributes income among all online and active police.
*/

params [
	["_unit",objNull,[objNull]],
	["_amount",0,[0]]
];

private _cops = allPlayers select {(side _x == west && (_x distance (getMarkerPos "Respawn_west") > 300) && ((_x distance _unit) < 2000))};

_amount = floor (_amount / (count _cops));

["atm","add",_amount] remoteExecCall ["life_fnc_updateMoney",_cops];
[0,format["You have received $%1 for an action by %2.", [_amount] call life_fnc_numberText, name _unit]] remoteExecCall ["life_fnc_broadcast",_cops];