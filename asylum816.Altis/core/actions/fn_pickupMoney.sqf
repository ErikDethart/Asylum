/*
	File: fn_pickupMoney.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Picks up money
*/
private["_obj","_val"];

_obj = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if (isNull _obj) then { _obj = cursorObject; };

if((time - life_action_delay) < 1) exitWith {hint "You can't rapidly use action keys!"};
_val = (_obj getVariable "item") select 1;
if(isNil {_val}) exitWith {};
if(isNull _obj || player distance _obj > 4) exitWith {};
if !(isSimpleObject _obj) exitWith {deleteVehicle _obj;};
if(!isNil {_val}) then
{
	deleteVehicle _obj;
	
	//Stop people picking up huge values of money which should stop spreading dirty money.
	switch (true) do
	{
		case (_val > 965748) : {_val = 1;}; //VAL>20mil->100k
		//case (_val > 5000000) : {_val = 250000;}; //VAL>5mil->250k
		default {};
	};
	
	player playmove "AinvPknlMstpSlayWrflDnon";
	titleText[format["You have picked up $%1",[_val] call life_fnc_numberText],"PLAIN"];
[34, player, format["Picked up $%1", [_val] call life_fnc_numberText]] remoteExecCall ["ASY_fnc_logIt",2];
	["cash","add",_val] call life_fnc_updateMoney;
	life_action_delay = time;
};
