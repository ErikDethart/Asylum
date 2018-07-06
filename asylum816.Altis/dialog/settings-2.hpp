class ClientSettingsPg2 
{
	idd = 29200;
	name= "ClientSettingsPg2";
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
		
		class MarkerClass_Town: Life_RscText
		{
			idc = -1;
		
			text = "Town Shops:";
			x = 0.434 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.058875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MarkerClass_Cop: Life_RscText
		{
			idc = -1;
		
			text = "Cop Markers:";
			x = 0.434 * safezoneW + safezoneX;
			y = 0.3735 * safezoneH + safezoneY;
			w = 0.058875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MarkerClass_Race: Life_RscText
		{
			idc = -1;
		
			text = "Race Starts:";
			x = 0.434 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.058875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MarkerClass_Illegal: Life_RscText
		{
			idc = -1;
		
			text = "Illegal Jobs:";
			x = 0.434 * safezoneW + safezoneX;
			y = 0.4285 * safezoneH + safezoneY;
			w = 0.058875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MarkerClass_Reb: Life_RscText
		{
			idc = -1;
		
			text = "Rebel/Cartel:";
			x = 0.434 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.058875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MarkerClass_DMV: Life_RscText
		{
			idc = -1;
		
			text = "Car Shops:";
			x = 0.434 * safezoneW + safezoneX;
			y = 0.4835 * safezoneH + safezoneY;
			w = 0.058875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MarkerClass_Gas: Life_RscText
		{
			idc = -1;
		
			text = "Gas Stations:";
			x = 0.434 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.058875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MarkerClass_Legal: Life_RscText
		{
			idc = -1;
		
			text = "Legal Jobs:";
			x = 0.434 * safezoneW + safezoneX;
			y = 0.5385 * safezoneH + safezoneY;
			w = 0.058875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MarkerClass_DPs: Life_RscText
		{
			idc = -1;
		
			text = "DP Missions:";
			x = 0.434 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.058875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MarkerClass_Turfs: Life_RscText
		{
			idc = -1;
		
			text = "Turf Markers:";
			x = 0.434 * safezoneW + safezoneX;
			y = 0.5935 * safezoneH + safezoneY;
			w = 0.058875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MarkerClass_Garage: Life_RscText
		{
			idc = -1;
		
			text = "Garages:";
			x = 0.434 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.058875 * safezoneW;
			h = 0.022 * safezoneH;
		}
		class MarkerClass_Misc: Life_RscText
		{
			idc = -1;
		
			text = "Misc:";
			x = 0.434 * safezoneW + safezoneX;
			y = 0.6485 * safezoneH + safezoneY;
			w = 0.058875 * safezoneW;
			h = 0.022 * safezoneH;
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
			x = 0; y = 0.165;
			w = 1; h = 0.05;
		};
		
		class TextStatusLeft : Life_RscStructuredText
		{
			idc = 90036;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 0.75};
			x = 0.5 - (0.08 * 2) - 0.005; y = 0.165;
			w = 0.3; h = 0.05;
		};
		
		class TextStatusRight : Life_RscStructuredText
		{
			idc = 90037;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 0.75};
			x = 0.34; y = 0.165;
			w = 1 - (0.34 * 2) - 0.02; h = 0.05;
			class Attributes {
				align = "right";
			};
		};
		class Town_slider: life_RscXSliderH
		{
			idc = 29201;
			onSliderPosChanged = "[8,_this select 1,['ColorGreen','ColorWhite'],'Marker_Town'] call life_fnc_s_onSliderChange;";
		
			x = 0.495 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.06225 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Slide to change opacity of specified marker.";
		};
		class Cop_slider: life_RscXSliderH
		{
			idc = 29202;
			onSliderPosChanged = "[8,_this select 1,['ColorWEST'],'Marker_Cop'] call life_fnc_s_onSliderChange;";
		
			x = 0.495 * safezoneW + safezoneX;
			y = 0.3735 * safezoneH + safezoneY;
			w = 0.06225 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Slide to change opacity of specified marker.";
		};
		class Race_slider: life_RscXSliderH
		{
			idc = 29203;
			onSliderPosChanged = "[8,_this select 1,['ColorBrown'],'Marker_Race'] call life_fnc_s_onSliderChange;";
		
			x = 0.495 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.06225 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Slide to change opacity of specified marker.";
		};
		class Illegal_slider: life_RscXSliderH
		{
			idc = 29204;
			onSliderPosChanged = "[8,_this select 1,['ColorRed'],'Marker_Illegal'] call life_fnc_s_onSliderChange;";
		
			x = 0.495 * safezoneW + safezoneX;
			y = 0.4285 * safezoneH + safezoneY;
			w = 0.06225 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Slide to change opacity of specified marker.";
		};
		class Reb_slider: life_RscXSliderH
		{
			idc = 29205;
			onSliderPosChanged = "[8,_this select 1,['ColorEAST'],'Marker_Reb'] call life_fnc_s_onSliderChange;";
		
			x = 0.495 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.06225 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Slide to change opacity of specified marker.";
		};
		class DMV_slider: life_RscXSliderH
		{
			idc = 29206;
			onSliderPosChanged = "[8,_this select 1,['ColorBlue'],'Marker_DMV'] call life_fnc_s_onSliderChange;";
		
			x = 0.495 * safezoneW + safezoneX;
			y = 0.4835 * safezoneH + safezoneY;
			w = 0.06225 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Slide to change opacity of specified marker.";
		};
		class Gas_slider: life_RscXSliderH
		{
			idc = 29207;
			onSliderPosChanged = "[8,_this select 1,['ColorGUER'],'Marker_Gas'] call life_fnc_s_onSliderChange;";
		
			x = 0.495 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.06225 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Slide to change opacity of specified marker.";
		};
		class Legal_slider: life_RscXSliderH
		{
			idc = 29208;
			onSliderPosChanged = "[8,_this select 1,['ColorYellow','ColorCIV'],'Marker_Legal'] call life_fnc_s_onSliderChange;";
		
			x = 0.495 * safezoneW + safezoneX;
			y = 0.5385 * safezoneH + safezoneY;
			w = 0.06225 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Slide to change opacity of specified marker.";
		};
		class DPs_slider: life_RscXSliderH
		{
			idc = 29209;
			onSliderPosChanged = "[8,_this select 1,['ColorKhaki'],'Marker_DPs'] call life_fnc_s_onSliderChange;";
		
			x = 0.495 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.06225 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Slide to change opacity of specified marker.";
		};
		class Turfs_slider: life_RscXSliderH
		{
			idc = 29210;
			onSliderPosChanged = "[8,_this select 1,['ColorUNKNOWN'],'Marker_Turfs'] call life_fnc_s_onSliderChange;";
		
			x = 0.495 * safezoneW + safezoneX;
			y = 0.5935 * safezoneH + safezoneY;
			w = 0.06225 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Slide to change opacity of specified marker.";
		};
		class Garage_slider: life_RscXSliderH
		{
			idc = 29211;
			onSliderPosChanged = "[8,_this select 1,['ColorOrange'],'Marker_Garage'] call life_fnc_s_onSliderChange;";
		
			x = 0.495 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.06225 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Slide to change opacity of specified marker.";
		};
		class Misc_slider: life_RscXSliderH
		{
			idc = 29212;
			onSliderPosChanged = "[8,_this select 1,['ColorBlack'],'Marker_Misc'] call life_fnc_s_onSliderChange;";
		
			x = 0.495 * safezoneW + safezoneX;
			y = 0.6485 * safezoneH + safezoneY;
			w = 0.06225 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Slide to change opacity of specified marker.";
		};
		class ButtonClose : Life_RscButtonInvisible {
			idc = -1;
			shortcuts[] = {0x00050000 + 2};
			text = "";
			onButtonClick = "closeDialog 0;";
			tooltip = "Go back to home screen";
			x = 0.5 - ((6.25 / 40) / 2);
			y = 1 - 0.15;
			w = (6.25 / 40);
			h = (6.25 / 40);
		};
	};
};