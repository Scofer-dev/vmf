[
	QGVAR(enabled),	//Setting variable name
	"CHECKBOX",		//Setting type
	["Enable Safe Start","Enable Safe Start at the start of a mission"],	//[Title,Tooltip]
	["Void Mission Framework","Safe Start"],	//[Category,Sub-Category]
	true,	//Default value
	true,	//Is global
	{
		if (_this && hasInterface && isMultiplayer) then {
			[player] call FUNC(safeStartInit);
		};
	},
	false	//Need restart
] call CBA_fnc_addSetting;

[
	QGVAR(3denDisabled),
	"CHECKBOX",
	["Disable in 3DEN Preview","Stop Safe Start activating in 3DEN mission previews"],
	["Void Mission Framework","Safe Start"],
	false,
	false,
	{}
] call CBA_fnc_addSetting;