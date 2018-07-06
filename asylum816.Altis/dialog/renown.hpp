class life_renown_menu {
	idd = 6710;
	name= "life_renown_menu";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[] spawn life_fnc_showRenown;";
	
	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {0.4, 0.05, 0.05, 0.7};
			idc = -1;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.201094 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.201094 * safezoneW;
			h = 0.198 * safezoneH;
		};
	};
	
	class controls {
		
		class moneyEdit : Life_RscEdit
		{
			idc = 6712;
			text = "1";
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class MarketButton : life_RscButtonMenu 
		{
			idc = -1;
			colorBackground[] = {0.5, 0, 0, 0.5};
			onButtonClick = "[] call life_fnc_renown;";
			text = "Buy Prestige!";
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class CloseButton : Life_RscButtonMenu {
			idc = -1;
			text = "Cancel";
			onButtonClick = "closeDialog 0";
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class RscStructuredText_1100: Life_RscStructuredText
		{
			idc = -1;
			text = "Purchase renown with cash to increase your prestige on the island.";
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class RscStructuredText_1101: Life_RscStructuredText
		{
			idc = 6713;
			text = "Your current ATM balance: %1";
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class RscStructuredText_1102: Life_RscStructuredText
		{
			idc = 6714;
			text = "Your current prestige: %1";
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1001: Life_RscText
		{
			idc = -1;
			text = "Renown to Purchase:";
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "Personal Renown";
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.201094 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};