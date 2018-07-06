/*
	File: fn_seizeObjects.sqf
	Author: Gnashes
	
	Description: Deletes a groundWeaponHolder or determines the contents and moves them into a police vehicle.

*/

_pile = cursorTarget;
if(isNull _pile) exitWith {};
if(!((_pile isKindOf "GroundWeaponHolder") OR (_pile isKindOf "WeaponHolderSimulated") OR (_pile isKindOf "WeaponHolder"))) exitWith {};

if({player distance getMarkerPos format["police_hq_%1",_x] < 50} count [1,2,3,4,5] > 0) then
{
	deleteVehicle _pile;
	titleText[format["The items from this pile have been seized into evidence!."],"PLAIN"];
} else
{
	_weapons = WeaponCargo _pile;
	_magazines = MagazineCargo _pile;
	_items = itemCargo _pile;
	_wepItems = []; 
	{ 
		for "_i" from 1 to 3 do 
		{ 
			if ((_x select _i) != "") then 
			{ 
				_wepItems = _wepItems + [_x select _i] 
			}; 
		}; 
		
		if ((_x select 4 select 0) != "") then 
		{ 
			_wepItems = _wepItems + [_x select 4 select 0]; 
		}; 
	} forEach weaponsItemsCargo _pile;
	
	_nearVehicle = objNull;
	_near = nearestObjects[(getPos (cursorTarget)),["Car","Air","Ship"],30];
	{
		_sideNearVehicle = _x getVariable["dbInfo",[""]] select 4;
		if (_sideNearVehicle == "cop") exitWith {_nearVehicle = _x};
	} foreach _near;
	
	if(count(_weapons + _magazines + _wepItems + _items) > 0) then
	{
	if(isNull _nearVehicle) exitWith {hint "There aren't any nearby Police vehicles to seize this vehicle's illegal items into!"};
	if(!alive _nearVehicle) exitWith {hint "You cannot seize items into a vehicle which has been destroyed!"};
	
		{
			_nearVehicle addItemCargoGlobal [_x,1];
		} forEach (_weapons + _magazines + _wepItems + _items);
		deleteVehicle _pile;
	
		titleText["The illegal items from this pile have been seized into the nearest police vehicle. The items can be placed into evidence from any Police HQ.","PLAIN"];
	}
	else
	{
		hint "What are you even trying to seize here!?";
	};
};
