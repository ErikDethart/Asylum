_veh = vehicle player;
 
// if it's a high-ranking cop and he's driving a vehicle, let him toggle the advanced lights
if(playerSide == west && _veh != player && (driver _veh) == player && life_coplevel >= 5) then {
 
    // if the vehicle's advancedLights variable hasn't been initialized, do that now
    if(isNil {_veh getVariable "advancedLights"}) then {_veh setVariable["advancedLights",false,true];};
 
    // toggle them on or off
    if(_veh getVariable ["advancedLights",false]) then {
        _veh setVariable ["advancedLights", false, true];
        titleText ["SWAT lights: OFF", "PLAIN"];
    } else {
        _veh setVariable ["advancedLights", true, true];
        titleText ["SWAT lights: ON", "PLAIN"];
    };
	
	_veh setVariable ["modeChange", true, true];
	
    _handled = true;
};