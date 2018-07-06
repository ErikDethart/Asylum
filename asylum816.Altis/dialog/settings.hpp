class ClientSettings
{
	idd = 2900;
	name= "ClientSettings";
	movingEnable = false;
	enableSimulation = true;

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

		class VDonFoot : life_RscText
		{
			idc = -1;
			text = "Foot:";

			x = 0.34;
			y = 0.17;
			w = 0.07; h = 0.04;
		};

		class VDinCar : life_RscText
		{
			idc = -1;
			text = "Car:";

			x = 0.34;
			y = 0.22;
			w = 0.07; h = 0.04;
		};

		class VDinAir : life_RscText
		{
			idc = -1;
			text = "Air:";

			x = 0.34;
			y = 0.27;
			w = 0.07; h = 0.04;
		};
		class VDinVolume : life_RscText
		{
			idc = -1;
			text = "Vol.:";

			x = 0.34;
			y = 0.32;
			w = 0.07; h = 0.04;
		};

	};

	class controls
	{
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

		class VD_onfoot_slider : life_RscXSliderH
		{
			idc = 2901;
			text = "";
			onSliderPosChanged = "[0,_this select 1] call life_fnc_s_onSliderChange;";
			tooltip = "View distance while on foot";
			x = 0.34 + 0.07;
			y = 0.17;
			w = 1 - (0.34 * 2) - (0.07 * 2);
			h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};

		class VD_onfoot_value : life_RscText
		{
			idc = 2902;
			text = "";

			x = 1 - 0.34 - 0.07;
			y = 0.17;
			w = 0.07;
			h = 0.04;
			class Attributes {
				align = "right";
			};
		};

		class VD_car_slider : life_RscXSliderH
		{
			idc = 2911;
			text = "";
			onSliderPosChanged = "[1,_this select 1] call life_fnc_s_onSliderChange;";
			tooltip = "View distance while in a land vehicle";
			x = 0.34 + 0.07;
			y = 0.22;
			w = 1 - (0.34 * 2) - (0.07 * 2);
			h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};

		class VD_car_value : life_RscText
		{
			idc = 2912;
			text = "";

			x = 1 - 0.34 - 0.07;
			y = 0.22;
			w = 0.07;
			h = 0.04;
			class Attributes {
				align = "right";
			};
		};

		class VD_air_slider : life_RscXSliderH
		{
			idc = 2921;
			text = "";
			onSliderPosChanged = "[2,_this select 1] call life_fnc_s_onSliderChange;";
			tooltip = "View distance while in a air vehicle";
			x = 0.34 + 0.07;
			y = 0.27;

			w = 1 - (0.34 * 2) - (0.07 * 2);
			h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};

		class VD_air_value : life_RscText
		{
			idc = 2922;
			text = "";

			x = 1 - 0.34 - 0.07;
			y = 0.27;
			w = 0.07;
			h = 0.04;
			class Attributes {
				align = "right";
			};
		};

		class VD_volume_slider : life_RscXSliderH
		{
			idc = 2931;
			text = "";
			onSliderPosChanged = "[7,_this select 1] call life_fnc_s_onSliderChange;";
			tooltip = "Volume Adjustment for earplugs";
			x = 0.34 + 0.07;
			y = 0.32;

			w = 1 - (0.34 * 2) - (0.07 * 2);
			h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};

		class VD_volume_value : life_RscText
		{
			idc = 2932;
			text = "";

			x = 1 - 0.34 - 0.07;
			y = 0.32;
			w = 0.07;
			h = 0.04;
			class Attributes {
				align = "right";
			};
		};

		class VDTerrSet : life_RscText
		{
			idc = -1;
			text = "Player Tags";
			shadow = 0;
			colorBackground[] = {0.4, 0, 0, 0.7};

			x = 0.34;
			y = 0.37;
			w = 1 - ((0.5 - (0.08 * 2)) * 2);
			h = (1 / 25);
		};

		class VD_terr_low : Life_RscActiveText
		{
			idc = -1;
			text = "Tags ON";
			action = "LIFE_ID_PlayerTags = [""LIFE_PlayerTags"",""onEachFrame"",""life_fnc_playerTags""] call BIS_fnc_addStackedEventHandler;";
			sizeEx = 0.04;

			x = 0.38; y = 0.42;
			w = 0.275; h = 0.04;
		};

		class VD_terr_normal : Life_RscActiveText
		{
			idc = -1;
			text = "Tags OFF";
			action = "[""LIFE_PlayerTags"", ""onEachFrame""] call BIS_fnc_removeStackedEventHandler;";
			sizeEx = 0.04;

			x = 0.5; y = 0.42;
			w = 0.275; h = 0.04;
		};

		class SideChannelSettings : life_RscText
		{
			idc = -1;
			text = "Phone Settings";
			shadow = 0;
			colorBackground[] = {0.4, 0, 0, 0.7};

			x = 0.34;
			y = 0.52;
			w = 1 - ((0.5 - (0.08 * 2)) * 2);
			h = (1 / 25);
		};

		class SideChatONOFF : Life_RscActiveText
		{
			idc = 2926;
			text = "Ringer OFF";
			color[] = {1, 0, 0, 1};
			action = "[] call life_fnc_toggleRinger";
			sizeEx = 0.04;

			x = 0.34; y = 0.57;
			w = 1 - ((0.5 - (0.08 * 2)) * 2);
			h = 0.04;

			class Attributes {
				align = "center";
			};
		};

		class adminONOFF : Life_RscActiveText
		{
			idc = 1337;
			text = "Admin Requests ON";
			color[] = {1, 0, 0, 1};
			action = "if (life_adminReq) then {life_adminReq = false} else {life_adminReq = true}; [] call life_fnc_settingsMenu; ";
			sizeEx = 0.04;

			x = 0.34; y = 0.62;
			w = 1 - ((0.5 - (0.08 * 2)) * 2);
			h = 0.04;

			class Attributes {
				align = "center";
			};
		};

		class SideChatOffOn : Life_RscActiveText
		{
			idc = 1338;
			text = "Sidechat ON";
			color[] = {1,0,0,1};
			action = "if(time - life_last_sold < 5) then {hint ""You have just changed this setting. Please try again in a moment!""} else { if (life_sidechat) then {life_sidechat = false} else {life_sidechat = true}; [player,life_sidechat,playerSide] remoteExecCall [""ASY_fnc_managesc"",2]; life_last_sold = time};";
			sizeEx = 0.04;

			x = 0.34; y = 0.67;
			w = 1 - ((0.5 - (0.08 * 2)) * 2);
			h = 0.04;

			class Attributes {
				align = "center";
			};
		};
		
		class EnvironmentOnOff : Life_RscActiveText
		{
			idc = 1340;
			text = "Environment Sounds ON";
			color[] = {0, 1, 0, 1};
			action = "if (environmentEnabled select 1) then {enableEnvironment [true,false]} else {enableEnvironment [true,true]};";
			sizeEx = 0.04;

			x = 0.34; y = 0.72;
			w = 1 - ((0.5 - (0.08 * 2)) * 2);
			h = 0.04;

			class Attributes {
				align = "center";
			};
		};

		class Page2 : Life_RscActiveText
		{
			idc = 1339;
			text = "Page 2";
			color[] = {0, 1, 0, 1};
			action = "[2] call life_fnc_settingsMenu;";
			sizeEx = 0.04;

			x = 0.34; y = 0.77;
			w = 1 - ((0.5 - (0.08 * 2)) * 2);
			h = 0.04;

			class Attributes {
				align = "center";
			};
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
