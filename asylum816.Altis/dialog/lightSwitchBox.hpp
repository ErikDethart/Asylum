class lightSwitchBox {

	idd = 96000;
	movingEnable = false;
	enableSimulation = true;
	
	class controlsBackground {
		
		class MainBackground:Life_RscPictureKeepAspect {
			idc = -1;
			text = "images\LightConsole.paa";			
			colorBackground[] = {0, 0, 0, 0};
			x = 0;
			y = 0;
			w = 1;
			h = 1;
		};
		
	};
	
	class controls
	{		
		class ButtonEmgcyLights : Life_RscButtonInvisible {
			idc = -1;
			onButtonClick = "if((vehicle player) getVariable [""lights"", false]) then { (vehicle player) setVariable[""lights"",false,true]; } else { (vehicle player) remoteExec [""life_fnc_copLights"", -2];};";
			tooltip = "Emergency Lights";
			x = 0.3135;
			y = 1 - 0.45;
			w = (6.25 / 120);
			h = (6.25 / 90);
		};
		
		class ButtonCtrlLeft : Life_RscButtonInvisible {
			idc = -1;
			onButtonClick = "if ((vehicle player) getVariable [""yieldLights"", false]) then {(vehicle player) setVariable[""yieldLights"",false,true];} else {[vehicle player, false, true] remoteExec [""life_fnc_controlLights"", -2];};";
			tooltip = "Control Lights Left";
			x = 0.3135 + (0.0765 * 1);
			y = 1 - 0.45;
			w = (6.25 / 120);
			h = (6.25 / 90);
		};
		
		class ButtonCtrlRight : Life_RscButtonInvisible {
			idc = -1;
			onButtonClick = "if ((vehicle player) getVariable [""yieldLights"", false]) then {(vehicle player) setVariable[""yieldLights"",false,true];} else {[vehicle player, true, true] remoteExec [""life_fnc_controlLights"", -2];};";
			tooltip = "Control Lights Right";
			x = 0.3135 + (0.153 * 1);
			y = 1 - 0.45;
			w = (6.25 / 120);
			h = (6.25 / 90);
		};
		
		class ButtonCtrlFlash : Life_RscButtonInvisible {
			idc = -1;
			onButtonClick = "if ((vehicle player) getVariable [""yieldLights"", false]) then {(vehicle player) setVariable[""yieldLights"",false,true];} else {[vehicle player, true, false] remoteExec [""life_fnc_controlLights"", -2];};";
			tooltip = "Control Lights Flash";
			x = 0.3135 + (0.2295 * 1);
			y = 1 - 0.45;
			w = (6.25 / 120);
			h = (6.25 / 90);
		};
		
		class ButtonSwat : Life_RscButtonInvisible {
			idc = -1;
			onButtonClick = "[] call life_fnc_toggleSwat;";
			tooltip = "Toggle SWAT";
			x = 0.3135 + (0.306 * 1);
			y = 1 - 0.45;
			w = (6.25 / 120);
			h = (6.25 / 90);
		};
		
	};
};