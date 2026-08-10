[
	QGVAR(enabled),	//Setting variable name
	"CHECKBOX",		//Setting type
	["Enable ACE Medical Notification","Players will have a message appear when they are being treated by another player"],	//[Title,Tooltip]
	["Void Mission Framework","ACE Medical Notification"],	//[Category,Sub-Category]
	true,	//Default value
	true,	//Is global
	{	//Script executed on mission start and when setting changed. Is this done globally as it's a global setting?
		if !(hasInterface) exitWith {};

		if (_this) then {
			//If enabled call the function that adds the event	
			call FUNC(addMedicalEvent);
		} else {
			//If disabled find the eventID that was previously added and remove that event if applicable

			//Set at the bottom of fnc_addMedicalEvent.sqf
			private _eventId = player getVariable ["VMF_medicalNotificationEH",-1];	
			
			if (_eventId != -1) then {
				["ace_treatmentStarted",_eventId] call CBA_fnc_removeEventHandler;

				player setVariable ["VMF_medicalNotificationEH",-1];
			};
		};
	},
	false	//Need restart
] call CBA_fnc_addSetting;

[
	QGVAR(textSize),
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
	QGVAR(textPosition),
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
	QGVAR(textColour),
	"COLOR",
	["Text Colour","The colour of the notification text"],
	["Void Mission Framework","ACE Medical Notification"],
	[1,1,1],	//RGB
	false,
	{},
	false
] call CBA_fnc_addSetting;
