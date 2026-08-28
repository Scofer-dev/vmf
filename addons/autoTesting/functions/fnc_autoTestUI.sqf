#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_autoTestUI

Description:
    Handles the Auto Testing UI

Execution:
	- Eden Editor

Parameters:
    0: Test Page (String)

Example:
	["aiCount"] call VMF_fnc_autoTestUI;

Returns:
	Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(is3DEN) exitWith {};

params [
	"_testPage"
];

private _display3DEN = uiNamespace getVariable "display3den";

switch _testPage do {
	case "aiCount": {
		private _display = _display3DEN createDisplay VMF_aiCount
	};
};
