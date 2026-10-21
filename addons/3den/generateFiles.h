class ctrlStatic;
class ctrlStructuredText;
class RscPicture;
class RscButton;

class vmf_generateFiles {
	idd = -1;
	onLoad = "uiNamespace setVariable ['VMF_generateFiles_display',_this select 0];";
	
	class ControlsBackground {
		class background: ctrlStatic {
			x = safeZoneX + safeZoneW * 0.31875;
			y = safeZoneY + safeZoneH * 0.22444445;
			w = safeZoneW * 0.3625;
			h = safeZoneH * 0.55;
			colorBackground[] = {0.4,0.4,0.4,1};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class titleBar: ctrlStatic {
			x = safeZoneX + safeZoneW * 0.31875;
			y = safeZoneY + safeZoneH * 0.22444445;
			w = safeZoneW * 0.3625;
			h = safeZoneH * 0.03666667;
			style = 2;
			text = "Generate Mission File";
			colorBackground[] = {0.302,0.302,0.302,1};
			colorText[] = {1,1,1,1};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class backgroundFrame: ctrlStatic {
			x = safeZoneX + safeZoneW * 0.31875;
			y = safeZoneY + safeZoneH * 0.22444445;
			w = safeZoneW * 0.3625;
			h = safeZoneH * 0.55;
			style = 64;
			colorText[] = {0,0,0,1};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class titleFrame: ctrlStatic {
			x = safeZoneX + safeZoneW * 0.31875;
			y = safeZoneY + safeZoneH * 0.22444445;
			w = safeZoneW * 0.3625;
			h = safeZoneH * 0.03666667;
			style = 64;
			colorText[] = {0,0,0,1};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class infoText: ctrlStatic {
			x = safeZoneX + safeZoneW * 0.34375;
			y = safeZoneY + safeZoneH * 0.27333334;
			w = safeZoneW * 0.3125;
			h = safeZoneH * 0.06111112;
			style = 16+512;
			text = "Use this window to generate mission files you don't already have. Due to limitations files are generated as .txt with generated_ at the start. They must be manually renamed.";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class descriptionText: ctrlStatic {
			x = safeZoneX + safeZoneW * 0.44375;
			y = safeZoneY + safeZoneH * 0.34666667;
			w = safeZoneW * 0.2125;
			h = safeZoneH * 0.03666667;
			text = "File generated_description.txt already exists";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_descriptionText',_this select 0];";
		};
		class briefingText: descriptionText {
			y = safeZoneY + safeZoneH * 0.39555556;
			text = "File generated_briefing.txt already exists";
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_briefingText',_this select 0];";	
		};
		class initText: descriptionText {
			y = safeZoneY + safeZoneH * 0.44444445;
			text = "File generated_init.txt already exists";
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_initText',_this select 0];";
		};
		class initPlayerLocalText: descriptionText {
			y = safeZoneY + safeZoneH * 0.49333334;
			text = "File generated_initPlayerLocal.txt already exists";
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_initPlayerLocalText',_this select 0];";
		};
		class initPlayerServerText: descriptionText {
			y = safeZoneY + safeZoneH * 0.54222223;
			text = "File generated_initPlayerServer.txt already exists";
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_initPlayerServerText',_this select 0];";
		};
		class initServerText: descriptionText {
			y = safeZoneY + safeZoneH * 0.59111112;
			text = "File generated_initServer.txt already exists";
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_initServerText',_this select 0];";
		};
		class arsenalArrayText: descriptionText	{
			y = safeZoneY + safeZoneH * 0.64;
			text = "File generated_arsenalArray.txt already exists";
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_arsenalArrayText',_this select 0];";
		};
		class defineRgsText: descriptionText {
			y = safeZoneY + safeZoneH * 0.68888889;
			text = "File generated_defineRGS.txt already exists";
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_defineRgsText',_this select 0];";	
		};
	};
	class Controls
	{
		class descriptionButton: RscButton {
			x = safeZoneX + safeZoneW * 0.34375;
			y = safeZoneY + safeZoneH * 0.34666667;
			w = safeZoneW * 0.0875;
			h = safeZoneH * 0.03666667;
			style = 2;
			text = "description.ext";
			colorBackground[] = {0.2,0.4,0.2,1};
			colorBackgroundActive[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.005;
			offsetPressedY = 0.005;
			offsetX = 0.005;
			offsetY = 0.005;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_descriptionButton',_this select 0];";
		};
		class briefingButton: descriptionButton {
			y = safeZoneY + safeZoneH * 0.39555556;
			text = "briefing.sqf";
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_briefingButton',_this select 0];";	
		};
		class initButton: descriptionButton {
			y = safeZoneY + safeZoneH * 0.44444445;
			text = "init.sqf";
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_initButton',_this select 0];";
		};
		class initPlayerLocalButton: descriptionButton {
			y = safeZoneY + safeZoneH * 0.49333334;
			text = "initPlayerLocal.sqf";
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_initPlayerLocalButton',_this select 0];";
		};
		class initPlayerServerButton: descriptionButton {
			y = safeZoneY + safeZoneH * 0.54222223;
			text = "initPlayerServer.sqf";
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_initPlayerServerButton',_this select 0];";
		};
		class initServerButton: descriptionButton {
			y = safeZoneY + safeZoneH * 0.59111112;
			text = "initServer.sqf";
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_initServerButton',_this select 0];";
		};
		class arsenalArrayButton: descriptionButton {
			y = safeZoneY + safeZoneH * 0.64;
			text = "arsenalArrays.sqf";
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_arsenalArrayButton',_this select 0];";
		};
		class defineRgsButton: descriptionButton {
			y = safeZoneY + safeZoneH * 0.68888889;
			text = "defineRGS.sqf";
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_defineRgsButton',_this select 0];";
		};
		class closeButton: RscButton {
			x = safeZoneX + safeZoneW * 0.65875;
			y = safeZoneY + safeZoneH * 0.22444445;
			w = safeZoneW * 0.0225;
			h = safeZoneH * 0.03666667;
			style = 48;
			text = "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_exit_cross_ca.paa";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			onLoad = "uiNamespace setVariable ['VMF_generateFiles_closeButton',_this select 0];";
		};
	};
};
