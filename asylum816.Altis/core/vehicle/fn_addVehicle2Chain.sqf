/*
	File: fn_addVehicle2Chain.sqf
*/
_vehicle = param [0,ObjNull,[ObjNull]];

life_vehicles pushBackUnique _vehicle;

_dbInfo = _vehicle getVariable["dbInfo",[]];
if (count _dbInfo > 2) then {
	if ((_dbInfo select 2) == player) then {
		if (((_vehicle isKindOf "Air") && (23 in life_talents)) || (89 in life_talents)) then {
			life_tracked pushBackUnique _vehicle;
		};

		if (_vehicle isKindOf "Air") then {
			clearItemCargoGlobal _vehicle;
			if (67 in life_talents) then {
				_vehicle addBackpackCargoGlobal ["B_AssaultPack_cbr",1];
				_vehicle addItemCargoGlobal ["ToolKit",2];
			};
	
			if (22 in life_talents) then {
				clearBackpackCargoGlobal _vehicle;
				_num = (count(fullCrew [_vehicle,"",true]));
				_vehicle addBackpackCargoGlobal ["B_Parachute", _num];
				_vehicle addBackpackCargoGlobal ["B_AssaultPack_cbr",1];
			};
	};
		if ((_vehicle isKindOf "Car") && (67 in life_talents)) then	{
			clearItemCargoGlobal _vehicle;
			clearBackpackCargoGlobal _vehicle;
			_vehicle addItemCargoGlobal ["ToolKit",2];
			_vehicle addBackpackCargoGlobal ["B_AssaultPack_cbr",1];
		};
	};
};