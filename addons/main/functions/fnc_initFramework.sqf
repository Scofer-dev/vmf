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


if (_module getVariable ["VMF_enableSafeStart",true]) then {
    [] remoteExec [QEFUNC(safeStart,safeStartInit),[0,-2] select isDedicated,true];
};

/*
if (_module getVariable ["VMF_enableMedicalNotification",true]) then {
    [] remoteExec [QEFUNC(aceMedicalNotification,addMedicalEvent),[0,-2] select isDedicated,true];
};
*/



