#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_curatorInitModule

Description:
    Initialises a Zeus module and executes the function on the client that placed the module

Execution:
	- Local: Yes
	- Server: No
	- Global: No

Parameters:
    0: Logic (Object)

Example:
	[logicObject] call VMF_fnc_curatorInitModule;

	[logicObject] remoteExec ["VMF_fnc_curatorInitModule",logicObject];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
params ["_logic"];

if !(local _logic) exitWith {};

private _function = getText (configOf _logic >> "function");
if (_function isEqualTo "") exitWith {};

if (isNil _function) then {
	_function = compile _function;
} else {
	_function = missionNamespace getVariable _function;
};

[_function, _logic] call CBA_fnc_execNextFrame;
