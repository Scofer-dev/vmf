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

if (_module getVariable ["VMF_enableSafeStart",false]) then {
    missionNamespace setVariable ["VMF_safeStartEnabled",true,true];
    [] remoteExec ["VMF_fnc_safeStartInit",[0,-2] select isDedicated,true];
};

/*

if (_module getVariable ["VMF_enableMedicalNotification",false]) then {
    [] remoteExec [QEFUNC(aceMedicalNotification,addMedicalEvent),[0,-2] select isDedicated,true];
};


if (_module getVariable ["VMF_enableGroupBFT",false]) then {
    private _updateDelay = _module getVariable ["VMF_groupBFTUpdateDelay",3];
    private _maxDistance = _module getVariable ["VMF_groupBFTMarkerMaxUnitDistance",100];
    private _friendSideMarkers = _module getVariable ["VMF_groupBFTFriendSideMarkers",true];

    [_updateDelay,_maxDistance,_friendSideMarkers] remoteExec [QEFUNC(bft,groupMarkers),[0,-2] select isDedicated,true];
};


if (_module getVariable ["VMF_enableTeamBFT",false]) then {
    private _updateDelay = _module getVariable ["VMF_teamBFTUpdateDelay",3];

    [_updateDelay] remoteExec [QEFUNC(bft,teamMarkers),[0,-2] select isDedicated,true];
};


if (_module getVariable ["VMF_enableBattlefieldSounds",false]) then {
    private _firefightSounds = _module getVariable ["VMF_firefightSounds","['BattlefieldFirefight1_3D','BattlefieldFirefight2_3D','BatlefieldFirefight3_3D','BattlefieldFirefight4_3D','','']"];
    private _explosionSounds = _module getVariable ["VMF_explosionSounds","['BattlefieldExplosions1_3D','BattlefieldExplosions2_3D','BattlefieldExplosions3_3D','BattlefieldExplosions4_3D','BattlefieldExplosions5_3D','','','','',']"];
    private _aircraftSounds = _module getVariable ["VMF_aircraftSounds","['BattlefieldHeli1_3D','BattlefieldHeli2_3D','BattlefieldHeli3_3D','BattlefieldJet1_3D','BattlefieldJet2_3D','BattlefieldJet3_3D','','','','','','']"];

    _firefightSounds = _firefightSounds splitString " " joinString "" splitString ",";
    _explosionSounds = _explosionSounds splitString " " joinString "" splitString ",";
    _aircraftSounds = _aircraftSounds splitString " " joinString "" splitString ",";

    [_firefightSounds,_explosionSounds,_aircraftSounds] remoteExec [QEFUNC(presentation,battlefieldSounds)[0,-2] select isDedicated,true];
};
*/




