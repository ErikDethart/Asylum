////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Paratus, v1.063, #Wanagu)
////////////////////////////////////////////////////////

class crimerecord_menu {
	idd = 3900;
	name = "crimerecord_menu";
	movingEnable = false;
	enableSimulation = true;
	
	class controlsBackground
	{
		class MainBackground : life_RscText
		{
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.268125 * safezoneW;
			h = 0.396 * safezoneH;
		};
		class MainTitle: life_RscText
		{
			idc = -1;
			text = "Criminal Record History (1 week)";
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.268125 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.4, 0, 0, 0.7};
		};
	};
	
	class controls 
	{
		class PlayerList: Life_RscListbox
		{
			idc = 3901;
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.33 * safezoneH;
			onLBSelChanged = "lbClear 3902;[lbData[3901,lbCurSel (3901)],player] remoteExec [""ASY_fnc_getCrimes"",2]; ctrlEnable [3901, false];";
		};
		class PlayerTitle: Life_RscText
		{
			idc = -1;
			text = "Citizens";
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.4, 0, 0, 0.7};
		};
		class RscListbox_1501: Life_RscListbox
		{
			idc = 3902;
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.33 * safezoneH;
		};
		class HistoryTitle: Life_RscText
		{
			idc = -1;
			text = "History";
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.4, 0, 0, 0.7};
		};
		class CloseButton: Life_RscButtonMenu
		{
			text = "OK";
			idc = -1;
			x = 0.556719 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "closeDialog 0;";
		};
	};
};