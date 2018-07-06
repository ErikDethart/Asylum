/*
	File: fn_setBounty.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Sets the provided wanted entry as active bounty.
*/
private ["_bounty","_retarget"];

_bounty = [_this,0,[],[[]]] call BIS_fnc_param;
_retarget = [_this,1,false,[false]] call BIS_fnc_param;
_index = -1;
_marker = [0,0,0];

if (!license_civ_bounty && !(playerSide == west && (life_coprole in ["warrant","all"]))) exitWith {life_bounty_contract = [];life_bounty_uid = [];};

if (count _bounty < 1) exitWith { hint "No bounties are available at this time.  Try again shortly."; };

if (_retarget) then {
	_index = [_bounty select 1,life_bounty_list] call life_fnc_index;
	_marker = (life_bounty_list select _index) select 1;
	_bounty pushBack _marker; // Tracking markers
} else {
	["BountyUpdate",[format["You have been tasked to track and arrest %1.", _bounty select 0]]] call BIS_fnc_showNotification;
	systemChat format["Your new bounty target, %1, is currently wanted for $%2.", _bounty select 0, [_bounty select 3] call life_fnc_numberText];
	
	_bounty pushBack _marker; // Tracking markers
};

life_bounty_contract pushBack _bounty;
life_bounty_uid pushBack (_bounty select 1);
player setVariable["myBounties",life_bounty_uid,true];
[_bounty select 1,_marker,_retarget] spawn life_fnc_trackBounty;
[] call life_fnc_hudUpdate;

bounty_task = player createSimpleTask ["Bounty Target"];
player setCurrentTask bounty_task;