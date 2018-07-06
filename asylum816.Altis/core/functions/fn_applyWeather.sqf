/*
	File: fn_applyWeather.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Receive set weather requests and... set weather.
*/

private["_overcast","_rain","_wind","_fog"];
_overcast = [_this,0,0,[0]] call BIS_fnc_param;
_rain = [_this,1,0,[0]] call BIS_fnc_param;
_wind = [_this,2,0,[0]] call BIS_fnc_param;
_fog = [_this,3,0,[0]] call BIS_fnc_param;

if (sunOrMoon < 0.5) then { _overcast = 0; };
if (sunOrMoon < 1) then { _rain = 0; };

if (!isServer) then
{
	25 setOvercast _overcast;
	0 = [] spawn {
		sleep 0.1;
		simulWeatherSync;
		forceWeatherChange;
	};
}
else
{
	30 setOvercast _overcast;
	30 setFog 0; // Not using _fog
	setWind [_wind, _wind, true];
	30 setRain _rain;
	forceWeatherChange;
}; 