/*
	File: fn_phoneEnd.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Phone call has been forcibly closed!
*/

life_phone_status = 0;
[player,objNull,true] remoteExecCall ["ASY_fnc_managePhone",2];
