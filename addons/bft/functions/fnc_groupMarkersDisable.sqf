#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_groupMarkersDisable

Description:
    Disables Group BFT; deleting markers and cleaning up event handlers

Execution:
	- Local: Yes
	- Server: No
	- Global: Yes

Parameters:
   	N/A

Example:
	Disable Group BFT for the local player
	[] call VMF_fnc_groupMarkersDisable;

	Disable Group BFT for all players
	[] remoteExec ["VMF_fnc_groupMarkersDisable",[0,-2] select isDedicated,true];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

missionNamespace setVariable ["VMF_groupBFT_active",false];
missionNamespace setVariable ["VMF_groupBFT_activeLoop",false];

private _groupDeletedMEH = missionNamespace getVariable ["VMF_groupBFT_groupDeletedMEH",-1];
if (_groupDeletedMEH != -1) then {
	removeMissionEventHandler ["GroupDeleted",_groupDeletedMEH];
	missionNamespace setVariable ["VMF_groupBFT_groupDeletedMEH",-1];
};

{
	private _group = _x;

	private _marker = _group getVariable ["VMF_bftGroupMarker",""];
	if (_marker != "") then {
		deleteMarkerLocal _marker;
		_group setVariable ["VMF_bftGroupMarker",""];
	};

	private _idChangedEH = _group getVariable ["VMF_groupBFT_idChangedEH",-1];
	if (_idChangedEH != -1) then {
		_group removeEventHandler ["GroupIdChanged",_idChangedEH];
		_group setVariable ["VMF_groupBFT_idChangedEH",-1];
	};

	private _emptyEH = _group getVariable ["VMF_groupBFT_emptyEH",-1];
	if (_emptyEH != -1) then {
		_group removeEventHandler ["Empty",_emptyEH];
		_group setVariable ["VMF_groupBFT_emptyEH",-1];
	};
} forEach allGroups;
