#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_aiCountInit

Description:
	Initialises the VMF_aiCount display
	Passes existing test results to VMF_fnc_aiCountDisplayUpdate and adds the buttonClick EH to the Run Test button

Execution:
	- Eden Editor

Parameters:
    N/A

Example:
	[_display] call VMF_fnc_aiCountInit;

Returns:
	Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(is3DEN) exitWith {};

params [
	["_display",displayNull,[displayNull]]
];

if (isNull _display) exitWith {};

//Updates AI counts with existing results, the update function exits if results are []
private _testResults = uiNamespace getVariable ["VMF_aiCountResults",[]];
[_testResults] call VMF_fnc_aiCountDisplayUpdate;

//Find the 'Run Test' button and adds the buttonCLick EH
private _testButton = _display displayCtrl 8695861;

_testButton ctrlAddEventHandler ["buttonClick",{
	private _testResults = call VMF_fnc_aiCount;
	uiNamespace setVariable ["VMF_aiCountResults",_testResults];

	[_testResults] call VMF_fnc_aiCountDisplayUpdate;
}];
