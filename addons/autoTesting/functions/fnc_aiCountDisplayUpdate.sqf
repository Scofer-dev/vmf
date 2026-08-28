#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_aiCountDisplayUpdate

Description:
    Updates the AI Count testing display

Execution:
	- Eden Editor

Parameters:
    0: BLUFOR Unit Count Results (Array)
	1: BLUFOR Group Count Results (Array)
	2: OPFOR Unit Count Results (Array)
	3: OPFOR Group Count Results (Array)
	4: INDEPENDENT Unit Count Results (Array)
	5: INDEPENDENT Group Count Results (Array)
	6: CIVILIAN Unit Count Results (Array)
	7: CIVILIAN Group Count Results (Array)
	8: TOTAL Unit Count Results (Array)
	9: TOTAL Group Count Results (Array)

Example:
	[_testResults] call VMF_fnc_aiCount;

Returns:
	Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(is3DEN) exitWith {};

params [
	["_testResults",[],[]]
];

if (_testResults isEqualTo []) exitWith {};

private _aiCountCtrls = uiNamespace getVariable ["VMF_countCtrls",[]];

{
	_x params [
		"_count",
		"_resultType",
		"_message"
	];

	private _countCtrl = _aiCountCtrls select _forEachIndex;

	_countCtrl ctrlSetText str(_count);
	if (_resultType == 0) then {
		_countCtrl ctrlSetTextColor [0,1,0,1];
	} else {
		_countCtrl ctrlSetTextColor [0.85,0.4,0,1];
	};

	_countCtrl ctrlSetTooltip _message;
} forEach _testResults;
