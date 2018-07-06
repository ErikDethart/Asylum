/*
    File: fn_controlLights.sqf
    Author: Chronic [MIT] Modified by: Destrah
 
    Description:
    Adds the light effect to cop vehicles
*/
 
private ["_vehicle", "_ownerCopLevel", "_offroad", "_SUV", "_hatchback", "_prowler", "_hunter", "_strider", "_lightBlack", "_lightBrightYellow", "_lightHighBrightness", "_lightLowBrightness", "_lightAttenuation", "_lightIntensity", "_lightFlareSize", "_lightFlareMaxDistance", "_numStrobes", "_strobeTimeOn", "_strobeTimeOff","_offsetMultiplier","_advancedLights", "_extraLights"];
 
_vehicle = _this select 0;
_left = _this select 1;
_directional = _this select 2;
 
if(isNil {_vehicle getVariable "yieldLights"}) then {
    _vehicle setVariable ["yieldLights", false, true];
};
 
if(_vehicle getVariable ["yieldLights", false]) exitWith {}; // lights are already on, don't do it again
if(_vehicle getVariable ["yieldActive", false]) exitWith {}; // lights are already on and haven't finished yet, don't do it again
 
_vehicle setVariable ["yieldLights", true, false]; // set the vehicle's lights variable locally
 
_modeChanged = true;
// this is a loop that keeps the script going when the user changes the light mode.
// if there's something wrong with the vehicle, or the vehicle's lights aren't supposed to be on, then break out
while {_modeChanged && !isNil "_vehicle" && !isNull _vehicle && _vehicle getVariable ["yieldLights",false]} do {
   
    _daytime = daytime;
    _isDaytime = true;
    if (_daytime >= 18.5 || (_daytime >= 0.0 && _daytime <= 5.5)) then {
        _isDaytime = false;
    };
 
    // what kind of vehicle is it?
    _offroad = typeof _vehicle in ["C_Offroad_01_F","B_G_Offroad_01_armed_F","B_GEN_Offroad_01_gen_F"];
    _SUV = typeof _vehicle == "C_SUV_01_F";
    _hatchback = typeof _vehicle == "C_Hatchback_01_sport_F";
    _prowler = typeof _vehicle == "B_T_LSV_01_unarmed_F";
	_hunter = typeof _vehicle == "B_MRAP_01_F";
	_strider = typeof _vehicle == "I_MRAP_03_F";
	_van = typeof _vehicle == "C_Van_02_transport_F";
 
    // if it's not a police vehicle, then don't put the lights on it!
    if(!(_offroad || _SUV || _hatchback || _prowler || _hunter || _strider || _van)) exitWith{};
 
    // set the ambient colours
    _lightBlack = [0.0025, 0.0025, 0.0];
 
    // set the light colours
    _lightBrightYellow = [0.255, 0.255, 0];
 
    _daytime = daytime;
    // set other fun parameters
    _lightHighBrightness = 30;
    if (!_isDaytime) then {
        _lightHighBrightness = 6;
    };
    _lightLowBrightness = 7;
    _lightAttenuation = [0.095, 0, 1000, 20];
    _lightFlareSize = 0.15;
    _lightFlareMaxDistance = 500;
    _lightUseFlare = true;
    _offsetMultiplier = 0.07;
 
    // set default light flash properties
    _numStrobes = 1;
    _strobeTimeOn = 3;
    _strobeTimeOff = 1;
    _strobeTimeDelay = 0.35;
 
    _alphaLights = [];
 
    _attachLight = {
        _isAlpha = _this select 0;
        _position = _this select 1;
        _light = "#lightpoint" createVehicleLocal [100000,100000,100000];
        _light setLightDayLight true;
        _light setLightBrightness 0;
        _light setLightAttenuation _lightAttenuation;
        _light setLightFlareSize _lightFlareSize;
        _light setLightFlareMaxDistance _lightFlareMaxDistance;
        _light setLightUseFlare _lightUseFlare;
        _light setLightColor _lightBrightYellow;
        _light setLightAmbient _lightBlack;
        _alphaLights = _alphaLights + [[_light, _position]];
        _light attachTo [_vehicle, _position];
    };
 
    // put the lights on the offroad in the appropriate location
    if(_offroad) then {
        [true, [0.41, -2.97, -0.92]] call _attachLight;
        [true, [0.19, -2.98, -0.92]] call _attachLight;
        [true, [-0.03, -2.985, -0.92]] call _attachLight;
        [false, [-0.25, -2.98, -0.92]] call _attachLight;
        [false, [-0.47, -2.97, -0.92]] call _attachLight;
    };
   
    // put the lights on the SUV in the appropriate location
    if(_SUV) then {
		_lightAttenuation = [0.075, 0, 1000, 20];
		[true, [0.48, -1.8, 0.2375]] call _attachLight;
		[true, [0.24, -1.8, 0.24375]] call _attachLight;
		[true, [0, -1.8, 0.25]] call _attachLight;
		[true, [-0.24, -1.8, 0.24375]] call _attachLight;
		[true, [-0.48, -1.8, 0.2375]] call _attachLight;
    };
   
    // put the lights on the Sport Hatch in the appropriate location
    if(_hatchback) then {
        [true, [0.415, -2.53, -0.7]] call _attachLight;
        [true, [0.19, -2.56, -0.6935]] call _attachLight;
        [true, [-0.03, -2.57, -0.6925]] call _attachLight;
        [false, [-0.25, -2.56, -0.6935]] call _attachLight;
        [false, [-0.475, -2.53, -0.7]] call _attachLight;
    };
	
	// put the lights on the prowler in the appropriate location
    if(_prowler) then {
		_lightAttenuation = [0.075, 0, 1000, 20];
        [true, [0.45, -2.1, -1.11]] call _attachLight;
        [true, [0.24, -2.1, -1.11]] call _attachLight;
        [true, [0.035, -2.1, -1.11]] call _attachLight;
        [false, [-0.17, -2.1, -1.11]] call _attachLight;
        [false, [-0.38, -2.1, -1.11]] call _attachLight;
    };
	
	if(_van) then {
		_lightAttenuation = [0.075, 0, 1000, 20];
		[true, [0.8	, -3.343, -1.07]] call _attachLight;
		[true, [0.6, -3.36, -1.07]] call _attachLight;
		[true, [0.4, -3.37, -1.07]] call _attachLight;
		[true, [-0.4, -3.37, -1.07]] call _attachLight;
		[true, [-0.6, -3.36, -1.07]] call _attachLight;
		[true, [-0.8, -3.343, -1.07]] call _attachLight;
	};
	
    if(_hunter) then {
		_lightAttenuation = [0.075, 0, 1000, 20];
        [true, [0.4, -4.22, -0.77]] call _attachLight;
        [true, [0.2, -4.22, -0.77]] call _attachLight;
        [true, [-0.0, -4.22, -0.77]] call _attachLight;
        [false, [-0.2, -4.22, -0.77]] call _attachLight;
        [false, [-0.4, -4.22, -0.77]] call _attachLight;
    };
	
    if(_strider) then {
        [true, [0.44, -3.02, 0.03]] call _attachLight;
        [true, [0.22, -3.02, 0.03]] call _attachLight;
        [true, [-0.0, -3.02, 0.03]] call _attachLight;
        [false, [-0.22, -3.02, 0.03]] call _attachLight;
        [false, [-0.44, -3.02, 0.03]] call _attachLight;
    };
   
    if (_left) then {
        reverse _alphaLights;
    };
    _modeChanged = false;
	
	_vehicle setVariable ["modeChange", true, true];
 
    //Sets that the lights are currently still on
    _vehicle setVariable ["yieldActive", true, false];
    // start the loop that flashes the lights. Break out of it if the vehicle dies, if someone turns off the lights, or if someone changes the light mode
    while{(alive _vehicle && _vehicle getVariable ["yieldLights",false] && !_modeChanged)} do
    {
        // turn on the first set, strobe them if desired
        if (_directional) then {
            for [{_i=0}, {_i<_numStrobes}, {_i=_i+1}] do {
                {
                    (_x select 0) setLightBrightness _lightHighBrightness;
                    sleep _strobeTimeDelay;
                } forEach _alphaLights;
            };
        }
        else {
            for [{_i=0}, {_i<_numStrobes}, {_i=_i+1}] do {
                {
                    (_x select 0) setLightBrightness _lightHighBrightness;
                } forEach _alphaLights;
            };
            sleep _strobeTimeDelay;
        };
        //turns off the lights
        {
            (_x select 0) setLightBrightness 0;
            if (_directional) then {
                sleep _strobeTimeDelay;
            };
        } forEach _alphaLights;
        //Are the lights not directional?
        if (!_directional) then {
            sleep _strobeTimeDelay;
        };
       
        // has someone changed our lighting mode?
        _daytime = daytime;
        _modeChanged = ((_daytime >= 18.5 || (_daytime >= 0.0 && _daytime <= 5.5)) && _isDaytime) || (!(_daytime >= 18.5 || (_daytime >= 0.0 && _daytime <= 5.5)) && !_isDaytime);
    };
    //Sets that all the lights have shut off.
    _vehicle setVariable ["yieldActive", false, false]; // set the vehicle's lights variable locally
 
	_vehicle setVariable ["modeChange", true, true];
 
    // delete all those fancy lights we created so it doesn't lag the server
    {
        deleteVehicle (_x select 0);
    } forEach _alphaLights;
    _alphaLights = [];
};