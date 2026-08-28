#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_autoTest

Description:
    Runs a series of mission quality checks

Execution:
	- Eden Editor

Parameters:
    N/A

Example:
	call VMF_fnc_autoTest;

Returns:
	Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(is3DEN) exitWith {};

private _aiCountTest = call VMF_fnc_aiCountTest;

_aiCountTest params [
	["_totalGroups",0,[nil]],
	["_totalUnits",0,[nil]],
	["_groupData",[],[]],
	["_unitData",[],[]]
];

{
	_x params [
		["_side",sideUnknown,[sideUnknown]],
		["_groupCount",0,[nil]],
		["_testResult",0,[nil]],
		["_outputLog","",[""]]
	];
} forEach _groupData;

{
	_x params [
		["_side",sideUnknown,[sideUnknown]],
		["_unitCount",0,[nil]],
		["_testResult",0,[nil]],
		["_outputLog","",[""]]
	];
} forEach _unitData;

private _playerUnits = allUnits select {(_x get3DENAttribute "ControlSP") select 0 || (_x get3DENAttribute "ControlMP") select 0};

{
	private _unit = _x;

	_unit call VMF_fnc_unitInventoryCheck;
} forEach _playerUnits;
