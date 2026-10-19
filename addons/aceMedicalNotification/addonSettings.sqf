[
	"VMF_medicalNotification_textSize",
	"SLIDER",
	["Notification Text Size","Size of the notification text"],
	["Void Mission Framework","ACE Medical Notification"],
	[
		1,		//Min
		5,		//Max
		2,		//Default
		0,		//Decimals
		false	//% Display
	],
	false,
	{},
	false
] call CBA_fnc_addSetting;

[
	"VMF_medicalNotification_textPosition",
	"LIST",
	["Notification Position","Where the notification will appear"],
	["Void Mission Framework","ACE Medical Notification"],
	[
		["PLAIN","PLAIN DOWN"],	//Possible values
		["Middle","Bottom"],	//Corresponding pretty names
		1						//Index of default value
	],
	false,
	{},
	false
] call CBA_fnc_addSetting;

[
	"VMF_medicalNotification_textColour",
	"COLOR",
	["Text Colour","The colour of the notification text"],
	["Void Mission Framework","ACE Medical Notification"],
	[1,1,1],	//RGB
	false,
	{},
	false
] call CBA_fnc_addSetting;
