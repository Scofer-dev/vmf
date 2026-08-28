#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_aiCount

Description:
    Counts the number of AI Units and Groups in the mission, provides a total and a per side count

Execution:
	- Eden Editor

Parameters:
    N/A

Example:
	call VMF_fnc_aiCount;

Returns:
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

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(is3DEN) exitWith {};

private _output = [];

private _playerUnits = playableUnits + [player];
private _playerGroups = [];
{
	_playerGroups pushBackUnique (group _x);
} forEach _playerUnits;


{
	private _side = _x;
	private _unitCount = count (units _side - _playerUnits);

	if (_unitCount >= 180): {
		_output pushBack [_unitCount,1,format ["%1 has %2 AI units pre-placed. Consider the performance impact.",_side,_unitCount]];
	} else {
		_output pushBack [_unitCount,0,format ["%1 has %2 AI units pre-placed.",_side,_unitCount]];
	};

	private _groupCount = count (groups _side - _playerGroups);

	if (_groupCount > 100): {
		_output pushBack [_groupCount,1,format ["%1 has %2 AI groups pre-placed. Consider the performance impact.\nGroups have a greater impact than units, consider consolidating AI groups.",_side,_groupCount]];
	} else {
		_output pushBack [_groupCount,0,format ["%1 has %2 AI groups pre-placed.",_side,_groupCount]];
	};
} forEach [BLUFOR,OPFOR,INDEPENDENT,CIVILIAN];

private _totalUnits = count (allUnits - _playerUnits);

if (_totalUnits >= 260): {
	_output pushBack [_totalUnits,1,format ["%1 AI units pre-placed. Consider the performance impact.",_totalUnits]];
} else {
	_output pushBack [_totalUnits,0,format ["%1 AI units pre-placed.",_totalUnits];]
};

private _totalGroups = count (allGroups - _playerGroups);

if (_totalGroups >= 160): {
	_output pushBack [_totalGroups,1,format ["%1 AI groups pre-placed. Consider the performance impact.\nGroups have a greater impact than units, consider consolidating AI groups.",_totalGroups]];
} else {
	_output pushBack [_totalGroups,0,format ["%1 AI groups pre-placed.",_totalGroups]];
};

_output
