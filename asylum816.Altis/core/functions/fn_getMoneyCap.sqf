/*
	File: fn_getMoneyCap.sqf
	Author: John "Paratus" VanderZwet

	Description:
	How much money can I have?
*/

private ["_cap"];

_cap = 1000000 + (switch (true) do
{
	case (4 in life_achievements): { 99999999 };
	case (3 in life_achievements): { 5000000 };
	case (2 in life_achievements): { 1000000 };
	case (1 in life_achievements): { 500000 };
	default { 0 };
});

_cap;