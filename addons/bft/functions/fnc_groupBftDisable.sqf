#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_groupBftDisable

Description:
    Disables local group BFT system, cleaning up any created group position markers
	Must be executed locally to each player that should have group BFT disabled
	Can be disabled for certain players and not others

Execution:
	- Local: Yes
	- Server: No
	- Global: Yes

Parameters:
   	N/A

Example:
	Disable Group BFT for the local player
	[] call VMF_fnc_groupBftDisable;

	Disable Group BFT for all players
	[] remoteExec ["VMF_fnc_groupBftDisable",[0,-2] select isDedicated,true];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

missionNamespace setVariable ["VMF_groupVMF_groupBftRunningBFT_active",false];


{
	private _marker = _x getVariable ["VMF_groupBftMarker",""];
	if (_marker isNotEqualTo "") then {
		deleteMarkerLocal _marker;
		_group setVariable ["VMF_groupBftMarker",""];
	};
} forEach allGroups;
