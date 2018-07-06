/*
	File: fn_clientMessage.sqf
*/

private["_msg","_from", "_type"];
if (X_Server) exitWith {};
if(isNil "life_session_completed" || {!life_session_completed}) exitWith {}; //related to script errors when logging in
_msg = _this select 0;
_from = _this select 1;
_type = _this select 2;
if(_from == "") exitWith {};

switch (_type) do
{
	case 0 :
	{
		private["_message"];
		_message = format[">>>MESSAGE FROM %1: %2",_from,_msg];
		hint parseText format ["<t color='#FFCC00'><t size='2'><t align='center'>New Message<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>You<br/><t color='#33CC33'>From: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%2",[_from] call life_fnc_cleanName,_msg];

		["TextMessage",[format["You Received A New Private Message From %1",[_from] call life_fnc_cleanName]]] call bis_fnc_showNotification;
		systemChat _message;
		life_messages pushBack [_this select 1,_msg];
		PlaySound "sms";
		life_last_message = (_this select 1);
	};

	case 1 :
	{
		if(side player != west) exitWith {};
		private["_message"];
		_message = format["---911 DISPATCH FROM %1: %2",_from,_msg];
		life_messages pushBack [_this select 1,_message];
		hint parseText format ["<t color='#316dff'><t size='2'><t align='center'>New Dispatch<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>All Officers<br/><t color='#33CC33'>From: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%2",[_from] call life_fnc_cleanName,_msg];

		["PoliceDispatch",[format["A New Police Report From: %1",[_from] call life_fnc_cleanName]]] call bis_fnc_showNotification;
		systemChat _message;
	};

	case 2 :
	{
		private ["_unit"];
		if(life_adminlevel < 2 || life_adminReq) exitWith {};
		private["_message"];
		_message = format["???ADMIN REQUEST FROM %1: %2",_from,_msg];
		life_messages pushBack [_this select 1,_message];
		hint parseText format ["<t color='#ffcefe'><t size='2'><t align='center'>Admin Request<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>Admins<br/><t color='#33CC33'>From: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%2",[_from] call life_fnc_cleanName,_msg];
		
		_unit = objNull;
		{ if (name _x == (_this select 1)) then { _unit = _x; }; } foreach allPlayers;

		["AdminDispatch",[format["%1 Has Requested An Admin!",[_from] call life_fnc_cleanName]]] call bis_fnc_showNotification;
		systemChat _message;
		[_from, getPos _unit, "ADMIN REQUEST"] spawn life_fnc_createMarker;
	};

	case 3 :
	{
		private["_message"];
		_message = format["!!!ADMIN MESSAGE: %1",_msg];
		_admin = format["Sent by admin: %1", _from];
		life_messages pushBack ["The Admins",_message];
		hint parseText format ["<t color='#FF0000'><t size='2'><t align='center'>Admin Message<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>You<br/><t color='#33CC33'>From: <t color='#ffffff'>An Admin<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%1",_msg];

		["AdminMessage",["You Have Received A Message From An Admin!"]] call bis_fnc_showNotification;
		systemChat _message;
		if(life_adminlevel > 1) then {systemChat _admin;};
	};

	case 4 :
	{
		private["_message","_admin"];
		_message = format["!!!ADMIN MESSAGE: %1",_msg];
		_admin = format["Sent by admin: %1", _from];
		life_messages pushBack ["The Admins",_message];
		hint parseText format ["<t color='#FF0000'><t size='2'><t align='center'>Admin Message<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>All Players<br/><t color='#33CC33'>From: <t color='#ffffff'>The Admins<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%1",_msg];

		["AdminMessage",["You Have Received A Message From An Admin!"]] call bis_fnc_showNotification;
		systemChat _message;
		if(life_adminlevel > 1) then {systemChat _admin;};
	};

	case 5 :
	{
		private["_message","_unit"];
		_unit = objNull;
		{ if (name _x == _from) then { _unit = _x; }; } foreach allPlayers;

		if (isNull _unit) exitWith {};
		if (!(playerSide in [west,civilian])) exitWith {};
		if((playerSide == west && !(68 in life_talents)) || (playerSide == civilian && !((getPlayerUID _unit) in life_bounty_uid))) exitWith {};
		if (playerSide == west && (player distance _unit > 4000)) exitWith {};
		_distance = (str(round(player distance _unit)/1000) + " km");
		if(round(player distance _unit)/1000 < 1) then { _distance = str(round(player distance _unit)) + " Meters"}; 


		_message = format["The fugitive, %1, has been spotted %4 (%2 away). Bounty reward at least $%3.",[_from] call life_fnc_cleanName,_distance,[parseNumber(_msg)] call life_fnc_numberText,((getPos _unit) call BIS_fnc_locationDescription)];
		hint parseText format ["<t color='#316dff'><t size='2'><t align='center'>Fugitive Located<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%2",[name player] call life_fnc_cleanName,_message];
		systemChat _message;
		[_from, getPos _unit, "Fugitive"] spawn life_fnc_createMarker;
	};

	case 6 :
	{
		private["_message","_unit"];
		_unit = objNull;
		{ if (name _x == _from) then { _unit = _x; }; } foreach allPlayers;

		if (isNull _unit) exitWith {};
		if (!(playerSide in [west,civilian])) exitWith {};
		if(_msg == "0" && (!(8 in life_talents) && !(69 in life_talents))) exitWith {};
		if(_msg == "1" && !(70 in life_talents)) exitWith {};
		if (playerSide == civilian && !((getPlayerUID _unit) in life_bounty_uid)) exitWith {};
		if (playerSide == west && (player distance _unit > 4000)) exitWith {};
		_distance = (str(round(player distance _unit)/1000) + " km");
		if(round(player distance _unit)/1000 < 1) then { _distance = str(round(player distance _unit)) + " Meters"};

		_message = format["An informant has spotted the fugitive, %1, %3 (%2 away). Location indicated on your map.",[_from] call life_fnc_cleanName,_distance,((getPos _unit) call BIS_fnc_locationDescription)];
		hint parseText format ["<t color='#316dff'><t size='2'><t align='center'>Fugitive Located<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%2",[name player] call life_fnc_cleanName,_message];
		systemChat _message;
		[_from, getPos _unit, "Fugitive"] spawn life_fnc_createMarker;
	};

	case 7 :
	{
		private["_message","_unit"];
		_unit = objNull;
		{ if (name _x == _from) then { _unit = _x; }; } foreach allPlayers;

		if (isNull _unit) exitWith {};
		if (!(72 in life_talents)) exitWith {};
		_distance = (str(round(player distance _unit)/1000) + " km");
		if(round(player distance _unit)/1000 < 1) then { _distance = str(round(player distance _unit)) + " Meters"};

		_message = format["An informant has spotted %1 with a known drug dealer %2.",[_from] call life_fnc_cleanName,((getPos _unit) call BIS_fnc_locationDescription)];
		hint parseText format ["<t color='#316dff'><t size='2'><t align='center'>Fugitive Located<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%2",[name player] call life_fnc_cleanName,_message];
		systemChat _message;
		[_from, getPos _unit, "Fugitive"] spawn life_fnc_createMarker;
	};

	case 8 :
	{
		private["_message","_unit"];
		_unit = objNull;
		{ if (name _x == _from) then { _unit = _x; }; } foreach allPlayers;

		if (isNull _unit) exitWith {};
		if (!(88 in life_talents)) exitWith {};
		if (player distance _unit > 6000) exitWith {};
		_distance = (str(round(player distance _unit)/1000) + " km");
		if(round(player distance _unit)/1000 < 1) then { _distance = str(round(player distance _unit)) + " Meters"};

		_message = format["%1 has been spotted breaking into a car %3 (%2 away). Location indicated on your map.",[_from] call life_fnc_cleanName,_distance,((getPos _unit) call BIS_fnc_locationDescription)];
		hint parseText format ["<t color='#316dff'><t size='2'><t align='center'>Fugitive Located<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%2",[name player] call life_fnc_cleanName,_message];
		systemChat _message;
		[_from, getPos _unit, "Grand Theft Auto"] spawn life_fnc_createMarker;
	};

	case 9 :
	{
		private["_message","_admin"];
		_message = format["!!!GOVERNOR MESSAGE: %1",_msg];
		life_messages pushBack [_this select 1,_message];
		hint parseText format ["<t color='#00FF00'><t size='2'><t align='center'>Governor Message<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>All Players<br/><t color='#33CC33'>From: <t color='#ffffff'>Governor %2<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%1",_msg,[_from] call life_fnc_cleanName];

		["GovMessage",["You have received a message from the Governor!"]] call bis_fnc_showNotification;
		systemChat _message;
	};

	case 10 :
	{
		if(side player != independent) exitWith {};
		private["_message"];
		_message = format["---EMT DISPATCH FROM %1: %2",[_from] call life_fnc_cleanName,_msg];
		life_messages pushBack [_this select 1,_message];
		hint parseText format ["<t color='#00FF00'><t size='2'><t align='center'>New Dispatch<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>All Officers<br/><t color='#33CC33'>From: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%2",[_from] call life_fnc_cleanName,_msg];

		["PoliceDispatch",[format["A New EMT Dispatch From: %1",[_from] call life_fnc_cleanName]]] call bis_fnc_showNotification;
		systemChat _message;
	};
	
	case 11 :
	{
		private["_message","_unit"];
		_unit = objNull;
		{ if (name _x == _from) then { _unit = _x; }; } foreach allPlayers;
		if (isNull _unit) exitWith {};
		if (!(playerSide in [west])) exitWith {};
		_distance = (str(round(player distance _unit)/1000) + " km");
		if(round(player distance _unit)/1000 < 1) then { _distance = str(round(player distance _unit)) + " Meters"};

		_message = format["%1 has violated parole and is now being tracked! He is currently %3 (%2 away).",[_from] call life_fnc_cleanName,_distance,((getPos _unit) call BIS_fnc_locationDescription)];
		hint parseText format ["<t color='#316dff'><t size='2'><t align='center'>Parole Violation<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>All Officers<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%2",[name player] call life_fnc_cleanName,_message];
		systemChat _message;
	};
	    case 12 :
    {
        if (!(playerSide in [west])) exitWith {};
        if !(72 in life_talents) exitWith {};
        
        hint parseText format ["<t color='#316dff'><t size='2'><t align='center'>Drug Runner Activity Spotted!<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%2",[name player] call life_fnc_cleanName,_msg];
        systemChat _msg;
    };
};