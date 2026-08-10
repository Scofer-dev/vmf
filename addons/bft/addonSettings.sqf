/*	Currently done by module
[
	QGVAR(groupMarkersEnabled),	//Setting variable name
	"CHECKBOX",		//Setting type
	["Enable Group Markers","Groups with players will have markers that will have their positions updated periodically"],	//[Title,Tooltip]
	["Void Mission Framework","Group Blue Force Tracking"],	//[Category,Sub-Category]
	true,	//Default value
	true,	//Is global
	{	//Script executed on mission start and when setting changed. Is this done globally as it's a global setting?
		if !(isServer) exitWith {};

		if (_this) then {
			call FUNC(groupMarkersInit);
		} else {
			call FUNC(groupMarkersDisable);
		};
	},
	false	//Need restart
] call CBA_fnc_addSetting;

[
	QGVAR(groupMarkersUpdateDelay),
	"SLIDER",
	["Group Marker Update Delay","The delay in seconds between Group Marker position updates"],
	["Void Mission Framework","Group Blue Force Tracking"],	//[Category,Sub-Category]
	[1, 10, 3, 0],
	true,
	{},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(groupMarkersMaxUnitDistance),
	"SLIDER",
	["Group Marker Max Unit Distance","The maximum distance a unit can be from its group leader for its position to be counted for the group marker centroid"],
	["Void Mission Framework","Group Blue Force Tracking"],	//[Category,Sub-Category]
	[10, 1000, 100, 0],
	true,
	{},
	false
] call CBA_fnc_addSetting;


[
	QGVAR(teamMarkersEnabled),	//Setting variable name
	"CHECKBOX",		//Setting type
	["Enable Team Markers","Each player will have markers on the map showing the position of members of their team, positions updated periodically"],	//[Title,Tooltip]
	["Void Mission Framework","Team Blue Force Tracking"],	//[Category,Sub-Category]
	true,	//Default value
	true,	//Is global
	{	//Script executed on mission start and when setting changed. Is this done globally as it's a global setting?
		if !(isServer) exitWith {};

		if (_this) then {
			call FUNC(teamMarkersInit);
		} else {
			missionNamespace setVariable ["VMF_localBFT_active",false,true];

			[] remoteExec [QFUNC(teamMarkersDisable),[0,-2] select isDedicated,true];
		};
		
	},
	false	//Need restart
] call CBA_fnc_addSetting;

[
	QGVAR(teamMarkersUpdateDelay),
	"SLIDER",
	["Team Marker Update Delay","The delay in seconds between Team Marker position updates"],
	["Void Mission Framework","Team Blue Force Tracking"],	//[Category,Sub-Category]
	[1, 10, 3, 0],
	true,
	{},
	false
] call CBA_fnc_addSetting;
*/
