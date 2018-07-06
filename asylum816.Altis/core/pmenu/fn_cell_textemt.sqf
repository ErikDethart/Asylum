private["_msg","_to"];
ctrlShow[3018,false];
_msg = ctrlText 3003;
_to = "Emergency Medical";
if(_msg == "") exitWith {hint "You must enter a message to send!";ctrlShow[3018,true];};
if(count _msg > 200) exitWith {hint "The message you entered is too long to send!"};

[_msg,name player,10] remoteExecCall ["life_fnc_clientMessage",-2];
[] call life_fnc_cellphone;
hint format["You sent %1 a message: %2",_to,_msg];
[[name player] call life_fnc_cleanName, position player, "Dispatch"] remoteExec ["life_fnc_createMarker",independent];
ctrlShow[3018,true];
