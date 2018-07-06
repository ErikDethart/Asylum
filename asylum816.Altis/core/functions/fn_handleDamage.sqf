/*
	File: fn_handleDamage.sqf
	Author: John "Paratus" VanderZwet & Skalicon. Optimized by Gnashes

	Description:
	Handles special damage events
	
	NOTE: Multiple "HandleDamage" event handlers can be added to the same unit. If multiple EHs return damage value for custom damage handling, ***only last returned value will be considered by the engine***. EHs that do not return value can be safely added after EHs that do return value. - https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#HandleDamage
*/
params [
    ["_unit",objNull,[objNull]],
    ["_hitBox","",[""]],
    ["_damage",0,[0]],
    ["_source",objNull,[objNull]],
    ["_projectile","",[""]],
    ["_hitPartIndex",0,[0]],
    ["_instigator",objNull,[objNull]],
    ["_hitPoint","",[""]]
];
_curWep = "";
_curMag = "";

if !(alive _unit) exitWith {};

if !(_projectile in ["",'Sub_F_Signal_Green','Sub_F_Signal_Red']) then { [_source] call life_fnc_setAggressive; };

if(isPlayer _source && _source isKindOf "Man") then {
	_curWep = currentWeapon _source;
	_curMag = currentMagazine _source;
};

// Stun grenades
if (_projectile == "mini_Grenade") then {
	_damage = 0;
	[] spawn life_fnc_handleFlashbang;
};

// Rubber Bullets
_stunMag = ((tolower(_curMag) find "_tracer" > -1) || ((_source getVariable ["LT+",false]) && {!("acc_pointer_IR" in primaryWeaponItems _source)}));

if (_source != _unit && (_stunMag || (_curWep in ["SMG_02_F","hgun_P07_F","hgun_P07_snds_F"]))) then {
	if !(_projectile in ["GrenadeHand","mini_Grenade",""]) then {
		_hitDam = if (_hitBox == "") then { damage _unit } else { (_unit getHit _hitBox) };
		if (getDammage _unit >= 0.95 || (_hitDam + _damage >= 0.95)) then {
			_damage = 0;
			[_source] spawn life_fnc_handleDowned;
		};
	};
};

//Everything for damage from LandVehicles, kind of
if ((vehicle _source isKindOf "LandVehicle") && _source != _unit && driver (vehicle _source) == _source && vehicle _unit == _unit) then
{
	if ((((getDammage _unit) + _damage) >= 0.95) || (_damage >= 0.95)) then {
		_damage = 0;
		if(alive (driver _source) && side (driver _source) != west && (time - life_last_vdm) > 5) then
		{
			life_last_vdm = time;
			[(driver _source),"187V"] remoteExec ["life_fnc_addWanted", 2];
		};
	};
};

if (_damage > 0.4 && (!isPlayer _source || (vehicle _source isKindOf "LandVehicle"))) then
{
	if (_hitBox == "legs") then {
		_doBreak = true;
		if (47 in life_talents) then
		{
			_luck = floor (random 2);
			if (_luck == 0) exitWith {systemChat "Someone less hardy could have been seriously injured.";_doBreak = false;};
		};
		if (_doBreak) then { [true] spawn life_fnc_brokenLeg; };
	};
};

if ((((getDammage _unit) + _damage) >= 0.95) || (_damage >= 0.95)) then
{
	if(typeName life_clothing_store != "STRING") then
	{
		life_dead_gear = [player] call life_fnc_fetchDeadGear;
	};
};

if ((_unit getVariable ["restrained",false]) && !(_unit getVariable ["isCivRestrained",false])) then
{
	if((isPlayer _source) && (vehicle _unit != vehicle _source)) then
	{
		_damage = 0;
	};
};

if(vest _unit == "V_HarnessOGL_brn") then {
	if ((isPlayer _source) && (vehicle _unit != vehicle _source)) then {
		if ((!(_projectile in ["mini_Grenade",""])) && (!(_stunMag || (_curWep in ["SMG_02_F","hgun_P07_F","hgun_P07_snds_F"])))) then {
			if (((_damage > 0.4) && (_hitBox in ["spine1","spine2"])) || (((_damage > 1) && (_hitBox == "")) && (random(100) > 50))) then {
				if !(life_clothing_store isEqualType "") then {
					if (_damage > 0.95) then { _damage = 0.95};
					["shot",_source] spawn life_fnc_suicideBomb;
				};
			};
		};
	};
};

if !(isNull objectParent _unit) then {
	/*if (_projectile == "R_PG7_F") then 
	{
		if (_damage > 0.9) then { _damage = 0.9; };
	};*/

	if ((vehicle _unit) isKindOf "Car") then
	{
		if (isNull _source || _source == _unit) then
		{
			if (life_seatbelt || player getVariable["restrained",false]) then
			{
				_damage = _damage / 2 ;
				_myDamage = if(_hitBox == "") then {damage player} else {_unit getHit _hitBox};
				if(_damage < _myDamage) then {_damage = _myDamage};
			};
		};
	};
};

// Prison and court!
if (life_is_arrested || {!isNil "life_jury_active"} || {(typeOf vehicle player == "Steerable_Parachute_F" && _projectile == "")}) then
{
	_damage = 0;
};

//laser tag'd!
/*if (life_laser_inprogress) then
{
	if (((((getDammage _unit) + _damage) >= 0.95) || (_damage >= 0.95)) && ((player getVariable ["laserTeam",0]) != (_source getVariable ["laserTeam",0]))) then
	{
		[_source] spawn life_fnc_handleTagged;
	};
	_damage = 0;
};*/

[] call life_fnc_hudUpdate;
_damage;
