/*
	File: fn_vehicleColorStr.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master configuration for color strings depending on their index location.
*/
private["_vehicle","_color","_index"];
_vehicle = [_this,0,"",[""]] call BIS_fnc_param;
_index = [_this,1,-1,[0]] call BIS_fnc_param;
_color = "";

switch (_vehicle) do
{
	case "C_Offroad_01_F" :
	{
		switch (_index) do
		{
			case 0: {_color = "Red";};
			case 1: {_color = "Yellow";};
			case 2: {_color = "White";};
			case 3: {_color = "Blue";};
			case 4: {_color = "Dark Red";};
			case 5: {_color = "Blue / White"};
			case 6: {_color = "Black"};
			case 7: {_color = "Police"};
			case 8: {_color = "Taxi"};
			case 9: {_color = "Donor Purple"};
			case 10: {_color = "Donor Pink"};
			case 11: {_color = "Donor Sky"};
			case 12: {_color = "Donor Red"};
			case 13: {_color = "Donor Yellow"};
			case 14: {_color = "Donor Lime"};
			case 15: {_color = "Paramedic"};
			case 16: {_color = "Chrome"};
		};
	};
	
	case "C_Plane_Civil_01_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Racing (Tan Interior)";};
			case 1: {_color = "Racing";};
			case 2: {_color = "Red Line (Tan Interior)";};
			case 3: {_color = "Red Line";};
			case 4: {_color = "Blue Wave (Tan Interior)";};
			case 5: {_color = "Blue Wave";};
			case 6: {_color = "Tribal (Tan Interior)";};
			case 7: {_color = "Tribal";};
		};
	};

	case "C_Scooter_Transport_01_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Black";};
			case 1: {_color = "Lime";};
			case 2: {_color = "Yellow";};
			case 3: {_color = "Grey";};
			case 4: {_color = "Red";};
			case 5: {_color = "White";};
			case 6: {_color = "Blue";};
		};
	};
	
	case "I_C_Offroad_02_LMG_F";
	case "C_Offroad_02_unarmed_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Orange";};
			case 1: {_color = "Red";};
			case 2: {_color = "Blue";};
			case 3: {_color = "Green";};
			case 4: {_color = "Olive";};
			case 5: {_color = "Brown";};
			case 6: {_color = "Black";};
			case 7: {_color = "White";};
			case 8: {_color = "Police";};
		};
	};
	
	case "B_T_LSV_01_unarmed_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Dazzle";};
			case 1: {_color = "Sand";};
			case 2: {_color = "Black";};
			case 3: {_color = "Olive";};
			case 4: {_color = "APD Prowler";};
		};
	};
	
	case "O_LSV_02_armed_F";
	case "O_T_LSV_02_unarmed_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Arid";};
			case 1: {_color = "Green Hex";};
			case 2: {_color = "Black";};
		};
	};
	
	case "C_Boat_Transport_02_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Civilian";};
			case 1: {_color = "Black";};
		};
	};
	
	case "B_G_Offroad_01_armed_F" :
	{
		switch (_index) do
		{
			case 0: {_color = "Rebel";};
			case 1: {_color = "Police";};
		};
	};
	
	case "I_Plane_Fighter_03_CAS_F" :
	{
		switch (_index) do
		{
			case 0: {_color = "Civilian Standard";};
		};
	};
	
	case "C_Hatchback_01_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Beige";};
			case 1: {_color = "Green";};
			case 2: {_color = "Blue";};
			case 3: {_color = "Dark Blue";};
			case 4: {_color = "Yellow";};
			case 5: {_color = "White"};
			case 6: {_color = "Grey"};
			case 7: {_color = "Black"};
		};
	};
	
	case "C_Hatchback_01_sport_F":
	{
		switch(_index) do
		{
			case 0: {_color = "Red"};
			case 1: {_color = "Dark Blue"};
			case 2: {_color = "Orange"};
			case 3: {_color = "Black / White"};
			case 4: {_color = "Tan"};
			case 5: {_color = "Green"};
			case 6: {_color = "Police"};
			case 7: {_color = "Wolf Dew [P]"};
			case 8: {_color = "Rust Bucket"};
			case 9: {_color = "Type R"};
			case 10: {_color = "Police Supervisor Hatchback"};
			case 11: {_color = "Police Highway Patrol Hatchback"};
			case 12: {_color = "Paramedic"};
			case 13: {_color = "Smoked Bandit"};
			case 14: {_color = "General Lee"};
			case 15: {_color = "General Light"};
		};
	};
	
	case "C_SUV_01_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Dark Red";};
			case 1: {_color = "Police";};
			case 2: {_color = "Silver";};
			case 3: {_color = "Orange";};
			case 4: {_color = "Black";};
			case 5: {_color = "Paramedic"};
		};
	};
	
	case "C_Van_01_box_F":
	{
		switch (_index) do
		{
			case 0: {_color = "White"};
			case 1: {_color = "Red"};
			case 2: {_color = "RV"};
			case 3: {_color = "Camo v1"};
			case 4: {_color = "Camo v2"};
			case 5: {_color = "Camo v3"};
			case 6: {_color = "Camo v4"};
			case 7: {_color = "Camo v5"};
			case 8: {_color = "Camo v6"};
			case 9: {_color = "Camo v7"};
			case 10: {_color = "Camo v8"};
			case 11: {_color = "Black"};
		};
	};
	
	case "C_Van_01_transport_F":
	{
		switch (_index) do
		{
			case 0: {_color = "White"};
			case 1: {_color = "Red"};
			case 2: {_color = "Black"};
			case 3: {_color = "Camo v1"};
			case 4: {_color = "Camo v2"};
			case 5: {_color = "Camo v3"};
			case 6: {_color = "Camo v4"};
			case 7: {_color = "Camo v5"};
			case 8: {_color = "Camo v6"};
			case 9: {_color = "Camo v7"};
			case 10: {_color = "Camo v8"};
		};
	};
	
	case "C_Van_02_vehicle_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Yellow"};
			case 1: {_color = "Deranged Candy Man"};
			case 2: {_color = "A-Team"};
			case 3: {_color = "News Van"};
			case 4: {_color = "Mystery Machine"};
		};
	};
	
	case "C_Van_02_transport_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Paddy Wagon"};
			case 1: {_color = "Short Bus"};
			case 2: {_color = "Rusted Van"};
			case 3: {_color = "White"};
		};
	};
	
	case "B_Quadbike_01_F" :
	{
		switch (_index) do
		{
			case 0: {_color = "Brown"};
			case 1: {_color = "Digi Desert"};
			case 2: {_color = "Black"};
			case 3: {_color = "Blue"};
			case 4: {_color = "Red"};
			case 5: {_color = "White"};
			case 6: {_color = "Digi Green"};
			case 7: {_color = "Hunter Camo"};
			case 8: {_color = "Rebel Camo"};
		};
	};
	
	case "B_Heli_Light_01_F";
	case "C_Heli_Light_01_civil_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Sheriff"};
			case 1: {_color = "Black"};
			case 2: {_color = "Civ Blue"};
			case 3: {_color = "Civ Red"};
			case 4: {_color = "Digi Green"};
			case 5: {_color = "Blueline"};
			case 6: {_color = "Elliptical"};
			case 7: {_color = "Furious"};
			case 8: {_color = "Jeans Blue"};
			case 9: {_color = "Speedy Redline"};
			case 10: {_color = "Sunset"};
			case 11: {_color = "Vrana"};
			case 12: {_color = "Waves Blue"};
			case 13: {_color = "Rebel Digital"};
			case 14: {_color = "Medivac"};
			case 15: {_color = "Chrome"};
			case 16: {_color = "Shadow"};
			case 17: {_color = "Graywatcher"};
			case 18: {_color = "Wasp"};
			case 19: {_color = "News Chopper"};
		};
	};
	
	case "I_Heli_light_03_unarmed_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Police"};
			case 1: {_color = "Rebel Green"};
			case 2: {_color = "Rebel Digital"};
			case 3: {_color = "Blood Red"};
			case 4: {_color = "White"};
			case 5: {_color = "Sky Blue"};
		};
	};
	
	case "O_Heli_Light_02_unarmed_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Black"};
			case 1: {_color = "White / Blue"};
			case 2: {_color = "Digi Green"};
			case 3: {_color = "Desert Digi"};
			case 4: {_color = "Orca Orca"};
			case 5: {_color = "Pirate"};
			case 6: {_color = "APD Orca"};
			case 7: {_color = "Coast Guard"};
			
		};
	};
	
	case "B_MRAP_01_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Police"};
			case 1: {_color = "Black"};
			case 2: {_color = "Skiptracer"};
			case 3: {_color = "Prime"};
		};
	};
	
	case "O_MRAP_02_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Hex"};
			case 1: {_color = "Assimov"};
			case 2: {_color = "Wartorn"};
			case 3: {_color = "Pirate"};
			case 4: {_color = "Molten"};
			case 5: {_color = "Green"};
			case 6: {_color = "Orange"};
			case 7: {_color = "Red"};
			case 8: {_color = "Violet"};
			case 9: {_color = "White"};
			case 10: {_color = "Yellow"};
			case 11: {_color = "Blue"};
		};
	};
	
	case "I_MRAP_03_F":
	{
		switch (_index) do
		{
			case 0: {_color = "SWAT"};
			case 1: {_color = "Black"};
		};
	};
	
	case "I_Truck_02_covered_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Orange"};
			case 1: {_color = "Black"};
		};
	};
	
	case "I_Truck_02_transport_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Orange"};
			case 1: {_color = "Black"};
		};
	};
	
	case "I_Heli_Transport_02_F":
	{
		switch (_index) do
		{
			case 0: {_color = "Ion"};
			case 1: {_color = "Dahoman"};
			case 2: {_color = "Chrome"};
		};
	};
	
	case "C_Van_01_fuel_F" :
	{
		switch (_index) do
		{
			case 0: {_color = "Lil Pumper";};
		};
	};
	
	case "C_Truck_02_fuel_F" :
	{
		switch (_index) do
		{
			case 0: {_color = "Pressure Pumper";};
		};
	};
	
	case "B_Truck_01_fuel_F" :
	{
		switch (_index) do
		{
			case 0: {_color = "Gusher Grabber";};
		};
	};
};

_color;
