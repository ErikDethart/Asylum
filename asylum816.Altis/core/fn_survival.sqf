private _fnc_food = {
	if(!(player getVariable ["restrained", false] && !(player getVariable ["isCivRestrained", false]))) then {
		_change = 10;
		if ((59 in life_talents) || (85 in life_talents)) then { _change = 7; };
		if ((60 in life_talents) || (86 in life_talents)) then { _change = 5; };
		if (life_smoking) then { systemChat "You've got the munchies!"; _change = _change * 2; };
		if (life_meth_effect > 0) then { _change = _change / 2; };
		if (life_crank_effect > 0) then { _change = _change / 2; };
		life_hunger = life_hunger - (floor _change);
		[] call life_fnc_hudUpdate;
		switch(life_hunger) do {
			case 30: {hint "You haven't eaten anything in awhile. You should find something to eat soon!";};
			case 20: {hint "You are starting to starve, you need to find something to eat.";};
			case 10: {hint "You are now starving, you must eat something";player setFatigue 1;};
		};
	};
};

private _fnc_water = {
	if(!(player getVariable ["restrained", false] && !(player getVariable ["isCivRestrained", false]))) then {
		_change = 15;
		if (59 in life_talents || 85 in life_talents) then { _change = 11; };
		if (60 in life_talents || 86 in life_talents) then { _change = 7; };
		life_thirst = life_thirst - _change;
		[] call life_fnc_hudUpdate;
		switch(life_thirst) do
		{
			case 30: {hint "You haven't drank anything in a while. You should find something to drink soon.";};
			case 20: {hint "You haven't drank anything in a long time. You should find something to drink soon."; player setFatigue 1;};
			case 10: {hint "You are now suffering from severe dehydration find something to drink quickly!"; player setFatigue 1;};
		};
	};
};

[] spawn
{
	while{true} do
	{
		_oldDamage = damage player;
		_canRevive = player getVariable["can_revive", 0];
		waitUntil {sleep 1; (_oldDamage != damage player) || _canRevive != (player getVariable["can_revive", 0]) || (player getVariable["can_revive",-1000]) > serverTime};
		if (_oldDamage != damage player) then
		{
			_damage = (damage player) - _oldDamage;
			if (_damage > 0.2) then
			{
				_pain = (life_pain + _damage);
				if (_pain > 1) then { _pain = 1; };
				[_pain] spawn life_fnc_setPain;
			};
		};
		
		if (damage player < 0.25 && ((player getVariable["can_revive",-1000]) > time)) then { player setDamage 0.25; };
		if ((player getVariable["can_revive",-1000]) > time) then
		{
			[] call life_fnc_hudUpdate;
		};
	};
};

[] spawn
{
	waitUntil { life_session_completed };
	player setCustomAimCoef 0.7;
	for "_i" from 0 to (count life_addiction)-1 do
	{
		_new = life_addiction select _i;
		if (_new > 0) then
		{
			_new = _new - 0.02;
			if (_new < 0) then { _new = 0; };
			life_addiction set [_i, _new];
			if (_new > 0 && (time - (life_used_drug select _i)) > 600) then
			{
				switch (true) do
				{
					case (_new > 0.4): { systemChat "You are craving a high."; life_drug_withdrawl = false; };
					case (_new > 0.6): { systemChat "Getting high occupies all of your thoughts."; life_drug_withdrawl = false; };
					case (_new > 0.9):
					{
						systemChat "You feel shakey and anxious! You need a fix!";
						if (!life_drug_withdrawl) then { [] spawn { while {life_drug_withdrawl} do { resetCamShake; addCamShake [1, 4, 10]; sleep 3.5; }; resetCamShake; } };
						life_drug_withdrawl = true;
					};
				};
			};
		};
	};
	sleep 240;
	life_drug_level = life_drug_level - 0.05;
	if (life_drug_level < 0) then { life_drug_level = 0; };
	life_alcohol_level = life_alcohol_level - 0.15;
	player setCustomAimCoef (life_alcohol_level * 35);
	if (life_alcohol_level < 0) then { life_alcohol_level = 0; };
	if (life_alcohol_level == 0) then { "RadialBlur" ppEffectEnable false; player setCustomAimCoef 0.7; };
};

private _fnc_check = {
	if ((player getVariable["parole",-1000]) > time || (player getVariable["can_revive",-1000]) > time) then { [] call life_fnc_hudUpdate };
	[] spawn life_fnc_calWeight; 
};

private _foodTime = time;
private _waterTime = time;
private _checkTime = time;
private _walkDis = 0;
private _bp = "";
private _lastPos = visiblePosition player;
_lastPos = (_lastPos select 0) + (_lastPos select 1);

for "_i" from 0 to 1 step 0 do {
    if ((time - _waterTime) > 750) then {[] call _fnc_water; _waterTime = time;};
    if ((time - _foodTime) > 900) then {[] call _fnc_food; _foodTime = time;};
    if ((time - _checkTime) > 50) then {call _fnc_check; _checkTime = time;};

    if !(playerSide isEqualTo west) then {
	    if (backpack player isEqualTo "") then {
	        life_maxWeight = 64;
	        _bp = backpack player;
	    } else {
            _bp = backpack player;
            _cfg = getNumber(configFile >> "CfgVehicles" >> (backpack player) >> "maximumload");
			_load = round(_cfg / 10);
			life_maxWeight = 64 + _load;
	    };
	};

    if (life_carryWeight > life_maxWeight) then {
		if !(life_is_arrested) then {
			player forceWalk true;
			player setFatigue 1;
			hint "You are over carrying your max weight! You will not be able to run or move fast till you drop some items!";
		};
    } else {
        if (isForcedWalk player && {isNull life_holding_barrel}) then {
            player forceWalk false;
        };
    };

    if (life_inv_goldbar > 0 || life_inv_dirty_money > 0 || life_thirst <= 0 || life_hunger <= 0) then {
		if (getFatigue player < 0.9) then { player enableFatigue true; player setFatigue 1; };
		if ((vehicle player) isKindOf "Air" && life_inv_goldbar > 0 && !((player getVariable["restrained",false]) && !(player getVariable["isCivRestrained",false]))) then {
			player action ["getOut", (vehicle player)];
			hint "You may not enter an air vehicle while carrying gold bars.  They're too heavy!";
		};
	};

    if (!alive player) then {_walkDis = 0;} else {
        _curPos = visiblePosition player;
        _curPos = (_curPos select 0) + (_curPos select 1);
        if (!(_curPos isEqualTo _lastPos) && {(isNull objectParent player)}) then {
            _walkDis = _walkDis + 1;
            if (_walkDis isEqualTo 1200) then {
                _walkDis = 0;
                life_thirst = life_thirst - 5;
                life_hunger = life_hunger - 5;
                [] call life_fnc_hudUpdate;
            };
        };
        _lastPos = visiblePosition player;
        _lastPos = (_lastPos select 0) + (_lastPos select 1);
    };
    uiSleep 1;
};