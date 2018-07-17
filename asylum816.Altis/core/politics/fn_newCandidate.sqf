/*
	File: fn_newCandidate.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Send candidacy to server for review.
*/

private _invest = parseNumber(ctrlText 6802);
private _policy = ctrlText 6804;
if(!([str(_invest)] call life_fnc_isnumber)) exitWith {hint "Your investment isn't in an actual number format."};
if(_invest < 0) exitWith {};
if(_invest > 999999) exitWith {hint "You can't invest more than $999,999!";};
if(_invest < 2500) exitWith {hint "You must invest at least $2,500 to run for office.";};
if(count _policy > 250) exitWith {hint "The maximum character limit for a policy is 250."};

if(_invest > life_atmmoney) exitWith {hint "You don't have that much in your bank account!"};
["atm","take",_invest] call life_fnc_updateMoney;

{
	_x params ["_find","_replace"];
	_policy = [_policy,_find,_replace] call KRON_Replace;
} forEach [[",", "|"],["%", " percent"],["'", ""],["""", ""],["\", "\\"]];

[player, _invest, _policy, [name player,1] call life_fnc_cleanName] remoteExecCall ["ASY_fnc_submitCandidate",2];

closeDialog 0;
hint format ["Your candidacy has been received and you are now running for office with an investment of $%1!",[_invest] call life_fnc_numberText];
