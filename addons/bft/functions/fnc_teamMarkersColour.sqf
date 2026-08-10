#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_teamMarkersColour

Description:
    Checks what colour a units team BFT marker should be based on their assigned team colour
	Typically called by VMF_fnc_groupMarkersInit

Execution:
	- Local: Yes
	- Server: No
	- Global: No

Parameters:
    0: Unit

Example:
	[playerOne] call VMF_fnc_teamMarkersColour;

Returns:
    Marker colour name string

Author:
    Scofer
---------------------------------------------------------------------------- */
params [
	"_unit"
];

private _team = "MAIN"; //Sets a default value to prevent error if unit deleted
_team = assignedTeam _unit;
private _markerColour = "";

switch (_team) do {
	case "MAIN": {
		_markerColour = "ColorWhite";
	};
	case "RED": {
		_markerColour = "ColorRed";
	};
	case "GREEN": {
		_markerColour = "ColorGreen";
	};
	case "BLUE": {
		_markerColour = "ColorBlue";
	};
	case "YELLOW": {
		_markerColour = "ColorYellow";
	};
};

_markerColour
