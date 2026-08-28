#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_updateResultsBox

Description:
    Opens the Auto Testing window

Execution:
	- Eden Editor

Parameters:
    N/A

Example:
	call VMF_fnc_aiCount;

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(is3DEN) exitWith {};
if (isNull (uiNamespace getVariable [QGVAR(display),displayNull])) exitWith {
    ["VMF_fnc_updateResultsBox called when the VMF Auto Testing Display is closed"] call BIS_fnc_error;
};

params [
    ["_testType","",""]
];
if (_testType == "") exitWith {
    ["Invalid Test Type provided to VMF_fnc_updateResultsBox: %1",_testType] call BIS_fnc_error;
};

private _results = uiNamespace getVariable (QGVAR(_testType),[-1]);
if (_results isEqualTo [-1]) exitWith {
    ["Invalid Test Results provided to VMF_fnc_updateResultsBox"] call BIS_fnc_error;
};

private _passResults = [];

{
    _x params [
        "_resultType",
        "_result"
    ];

    switch (_resultType) do {
        case 0: {//Pass

        };
        case 1: {//Advisory

        };
        case 2: {//Fail

        };
    };
} forEach _results;
