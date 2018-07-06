/*
	File: fn_showBanned.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Player was banned. Tell them why!
*/
private["_message"];
_message = [_this,0,"",[""]] call BIS_fnc_param;
if (_message == "") exitWith {};

sleep 10;
_intro = parseText format["<t align='center' shadow='0'><img size='6' image='images\mission_splash.jpg'/></t><br/><br/><t size='4' color='#FF0000'>%1, YOU WERE BANNED!</t><br/><br/>
		You were banned from all Asylum servers, temporarily, for <t color='#FF0000'>%3</t>! Repeat offenses are taken much more seriously, so do not commit the offense again. This ban is to serve as a warning. If you have questions, contact an Administrator at www.gaming-asylum.com/forums.<br/><br/>", [name player] call life_fnc_cleanName, worldName, _message];


"YOU HAVE BEEN BANNED" hintC _intro;