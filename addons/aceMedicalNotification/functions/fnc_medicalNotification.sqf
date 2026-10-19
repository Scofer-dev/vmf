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

private _textSize = missionNamespace getVariable ["VMF_medicalNotification_textSize",2];

private _textPosition = missionNamespace getVariable ["VMF_medicalNotification_textPosition","PLAIN DOWN"];

private _textColour = (missionNamespace getVariable ["VMF_medicalNotification_textColour",[1,1,1]]) call BIS_fnc_colorRGBtoHTML;

titleText [
	format ["<t color='%1' size='%2'>%3 is helping you!</t>",_textColour,_textSize,_medic],
	_textPosition,
	1,
	true,
	true
];
