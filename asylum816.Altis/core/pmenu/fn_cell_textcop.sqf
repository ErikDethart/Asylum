private["_msg","_to"];
ctrlShow[3016,false];
_msg = ctrlText 3003;
_to = "The Police";
if(_msg == "") exitWith {hint "You must enter a message to send!";ctrlShow[3016,true];};
if(count _msg > 200) exitWith {hint "The message you entered is too long to send!"};
if(life_is_arrested) exitWith {titleText["Prison inmates are not allowed to message officers of the law!","PLAIN"];ctrlShow[3016,true];};

[_msg,name player,1] remoteExecCall ["life_fnc_clientMessage",west];
[] call life_fnc_cellphone;
hint format["You sent %1 a message: %2",_to,_msg];
[[name player] call life_fnc_cleanName, position player] remoteExec ["life_fnc_createMarker",west];
ctrlShow[3016,true];
[ceil (random 5000), format["%1 911: %2", [name player] call life_fnc_cleanName, _msg], 1500, 8, 2, position player, getPlayerUID player] remoteExecCall ["life_fnc_createDispatch",2];
