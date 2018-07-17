/*
	Description: Function for helping spawning local vehicles in, primarily for the dynamic map system.
*/
private["_className","_position","_direction","_vehicle"];
_className = _this param [0,"",[""]];
_position = _this param [1,[],[[]]];
_direction = _this param [2,0,[0,[]]];
_code = _this param [3,"",[""]];

if(_className == "" || _position isEqualTo []) exitWith {};

if(isServer && isDedicated) then {//If this file is called from the server we make the object global so everyone can see it.
	_vehicle = _className createVehicle [random(100),random(100),random(100)];
}else{
	_vehicle = _className createVehicleLocal [random(100),random(100),random(100)];
};

waitUntil{!isNull _vehicle};

if(isServer && isDedicated) then {
	_vehicle enableSimulation true;
}else{
	_vehicle enableSimulation false;
};

_vehicle allowDamage false;
_vehicle setPosWorld _position;

if(typeName _direction == "ARRAY") then {
	private ["_P", "_Y", "_R"];
	_Y = deg (_direction select 1);
	_P = 360 - (deg (_direction select 2));
	_R = 360 - (deg (_direction select 0));         
	{
		private _deg = call compile format [ "%1 mod 360", _x ];
		if ( _deg < 0 ) then { _deg = linearConversion[ -0, -360, _deg, 360, 0 ]; };
		call compile format[ "%1 = _deg", _x ];
	} forEach [ "_P", "_R", "_Y" ];
	private _up = [sin _R, -sin _P, cos _R * cos _P];
	_vehicle setDir _Y;
	if(_vehicle isKindOf "Man") exitWith {};
	_vehicle setVectorUp _up;
}else{
	_vehicle setDir _direction;
};
_vehicle setPosWorld _position;

clearBackpackCargo _vehicle;
clearWeaponCargo _vehicle;
clearMagazineCargo _vehicle;
clearItemCargo _vehicle;

if(_code != "") then {
	_vehicle spawn (compile _code);
};

_vehicle;