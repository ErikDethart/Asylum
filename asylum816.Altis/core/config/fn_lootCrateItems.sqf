/*
	File: fn_lootCrateItems.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	List of items inside loot crates.
*/

private ["_type"];
_type = [_this,0,0,[0]] call BIS_fnc_param;

// Crate ID, Display Name
switch (_type) do
{
	case 1:
	{
		[
			[ // Common
				[1,"Troll Shirt"],
				[2,"Sorry Shirt"],
				[3,"Bieber Shirt"],
				[4,"Unicorn Shirt"]
			],
			
			[ // Rare
				[5,"Hiker's Pack"],
				[6,"Combat Helmet"],
				[7,"Snake Helmet"]
			],
			
			[ // Limited
				[8,"CSAT Fatigues"],
				[9,"CSAT Coveralls"]
			]
		]
	};
	case 2:
	{
		[
			[ // Common
				[10,"Taylor Swift"],
				[11,"F* the Police"],
				[12,"Sad Pepe"]
			],
			
			[ // Rare
				[13,"Pirate Orca"],
				[14,"Tropic Fatigues"],
				[15,"Compact NVGs"]
			],
			
			[ // Limited
				[16,"Assimov Ifrit"],
				[17,"Wartorn Ifrit"],
				[18,"Pirate Ifrit"]
			]
		]
	};
	case 3:
	{
		[
			[ // Common
				[19,"Blue Ifrit"],
				[20,"Green Ifrit"],
				[21,"Orange Ifrit"],
				[22,"Red Ifrit"],
				[23,"Violet Ifrit"],
				[24,"White Ifrit"],
				[25,"Yellow Ifrit"]
			],
			
			[ // Rare
				[26,"Prime Hunter"],
				[27,"Molten Ifrit"],
				[28,"Smoking Bandit Sport"]
			],
			
			[ // Limited
				[29,"General Lee Sport"],
				[30,"Coast Guard Orca"]
			]
		]
	};
	default { [[],[],[]] };
};