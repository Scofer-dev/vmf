#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_displayNotification

Description:
    Displays notification to player when ACE medical is used on them, and by who
	Typically called by VMF_fnc_addMedicalEvent

Execution:
	- Local: Yes
	- Server: No
	- Global: No

Parameters:
    0: Medic name

Example:
	["Scofer"] call VMF_fnc_displayNotification;

	["Scofer"] remoteExec ["VMF_fnc_displayNotification",playerTwo];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

params [
	"_medic"
];

private _textColour = GVAR(textColour) call BIS_fnc_colorRGBtoHTML;
private _textSize = GVAR(textSize);
private _textPosition = GVAR(textPosition);

titleText [
	format ["<t color='%1' size='%2'>%3 is helping you!</t>",_textColour,_textSize,_medic],
	_textPosition,
	1,
	true,
	true
];
