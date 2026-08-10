#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_teamMarkersDisable

Description:
	Periodically updates the local markers for the players team members
	Typically called by VMF_fnc_teamMarkersInit

Execution:
	- Local: Yes
	- Server: No
	- Global: Yes

Parameters:
    N/A

Example:
	[] call VMF_fnc_teamMarkersDisable;

	[] remoteExec ["VMF_fnc_teamMarkersDisable",-2,true];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

missionNamespace setVariable ["VMF_teamBFT_activeLoop",false];

{
	private _marker = _x getVariable ["VMF_localBFTMarker",""];

	if (_marker != "") then {
		deleteMarkerLocal _marker;
		_x setVariable ["VMF_localBFTMarker",""]; 
	};
} forEach (units (group player));
