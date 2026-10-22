#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_initFramework

Description:
    Grabs the valus from the VMF_frameworkSettings modules and initialises individual parts of the Void Mission Framework

Execution:
	- Local: No
	- Server: Required
	- Global: No

Parameters:
    0: Logic (Object)

Example:
	N/A

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(isServer) exitWith {};

private _module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};

diag_log "[VMF initFramework] Start VMF Initialisation";

if (_module getVariable ["VMF_enableSafeStart",false]) then {
    missionNamespace setVariable ["VMF_safeStartEnabled",true,true];
    [] remoteExec ["VMF_fnc_safeStartInit",[0,-2] select isDedicated,true];

    diag_log "[VMF initFramework] Safe Start Enabled";

    private _arsenalFile = _module getVariable ["VMF_arsenalArrayFile","arsenalArrays.sqf]"];
    if (fileExists _arsenalFile) then {
        [_arsenalFile] remoteExec ["VMF_fnc_addArsenal",[0,-2] select isDedicated,true];

        diag_log "[VMF initFramework] Arsenal Array File found, Safe Start Arsenal Enabled";
    } else {
        diag_log "[VMF initFramework] Arsenal Array File not found, Safe Start Arsenal Disabled";
    };
} else {
    diag_log "[VMF initFramework] Safe Start Disabled";
};

if (_module getVariable ["VMF_enableMedicalNotification",false]) then {
    [] remoteExec ["VMF_fnc_addMedicalEvent",[0,-2] select isDedicated,true];

    diag_log "[VMF initFramework] ACE Medical Notification Enabled";
} else {
    diag_log "[VMF initFramework] ACE Medical Notification Disabled";
};

if (_module getVariable ["VMF_enableGroupBFT",false]) then {
    private _updateDelay = _module getVariable ["VMF_groupBFTUpdateDelay",3];
    private _maxDistance = _module getVariable ["VMF_groupBFTMarkerMaxUnitDistance",100];
    private _friendSideMarkers = _module getVariable ["VMF_groupBFTFriendSideMarkers",true];

    [_updateDelay,_maxDistance,_friendSideMarkers] remoteExec ["VMF_fnc_groupBftInit",[0,-2] select isDedicated,true];

    diag_log "[VMF initFramework] Group BFT Enabled";
} else {
    diag_log "[VMF initFramework] Group BFT Disabled";
};

if (_module getVariable ["VMF_enableTeamBFT",false]) then {
    private _updateDelay = _module getVariable ["VMF_teamBFTUpdateDelay",3];

    [_updateDelay] remoteExec ["VMF_fnc_teamBftInit",[0,-2] select isDedicated,true];

    diag_log "[VMF initFramework] Team BFT Enabled";
} else {
    diag_log "[VMF initFramework] Team BFT Disabled";
};


private _soundTypes = [
    _module getVariable ["VMF_firefightSounds",false],
    _module getVariable ["VMF_explosionSounds",false],
    _module getVariable ["VMF_helicopterSounds",false],
    _module getVariable ["VMF_jetSounds",false]
];

private _battlefieldSoundsEnabled = _soundTypes call VMF_fnc_battlefieldSounds;
if (_battlefieldSoundsEnabled) then {
    diag_log "[VMF initFramework] Battlefield Sounds Enabled";
} else {
    diag_log "[VMF initFramework] Battlefield Sounds Disabled";
};

diag_log "[VMF initFramework] End VMF Initialisation";
