#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_teamBftDisable

Description:
	Disables the local team BFT system, cleaning up any created team position markers
	Must be executed locally to each player that should have team BFT disabled
	Can be disabled for certain players and not others

Execution:
	- Local: Yes
	- Server: No
	- Global: Yes

Parameters:
    N/A

Example:
	[] call VMF_fnc_teamBftDisable;

	[] remoteExec ["VMF_fnc_teamBftDisable",-2,true];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

missionNamespace setVariable ["VMF_teamBftRunning",false];

{
	private _marker = _x getVariable ["VMF_teamBftMarker",""];

	if (_marker isNotEqualTo "") then {
		deleteMarkerLocal _marker;
		_x setVariable ["VMF_teamBftMarker",""]; 
	};
} forEach (units (group player));
