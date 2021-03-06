#include "player_sys.sqf"

class Life_weather_menu {
	idd = playersys_DIALOG;
	name= "life_weather_menu";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[] spawn life_fnc_weather";

	class controlsBackground {

		class MainBackground:Life_RscPictureKeepAspect {
			idc = -1;
			text = "images\phone.paa";
			colorBackground[] = {0, 0, 0, 0};
			x = 0;
			y = 0;
			w = 1;
			h = 1;
		};

	};

	class controls {

		class TextTime : Life_RscStructuredText
		{
			idc = 90035;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 0.75};
			x = 0; y = 0.115;
			w = 1; h = 0.05;
		};

		class TextStatusLeft : Life_RscStructuredText
		{
			idc = 90036;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 0.75};
			x = 0.5 - (0.08 * 2) - 0.005; y = 0.115;
			w = 0.3; h = 0.05;
		};

		class TextStatusRight : Life_RscStructuredText
		{
			idc = 90037;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 0.75};
			x = 0.34; y = 0.115;
			w = 1 - (0.34 * 2) - 0.02; h = 0.05;
			class Attributes {
				align = "right";
			};
		};

		class moneyStatusInfo : Life_RscStructuredText
		{
			idc = 2015;
			sizeEx = 0.020;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			x = 0.5 - (0.08 * 2);
			y = 0.18;
			w = 1 - ((0.5 - (0.08 * 2)) * 2);
			h = 0.585;
		};

		class ButtonClose : Life_RscButtonInvisible {
			idc = -1;
			shortcuts[] = {0x00050000 + 2};
			text = "";
			onButtonClick = "closeDialog 0;";
			tooltip = "Go back to home screen";
			x = 0.5 - ((6.25 / 80) / 2);
			y = 1 - 0.1;
			w = (6.25 / 80);
			h = (6.25 / 80);
		};
	};
};
