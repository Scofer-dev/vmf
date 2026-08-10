#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_addMedicalEvent

Description:
    Adds an ace_treatmentStarted CBA eventhandler to player, which will tell other players if they're being treated

Execution:
	- Local: Yes
	- Server: No
	- Global: Yes, best use

Parameters:
    N/A

Example:
	[] call VMF_fnc_addMedicalEvent;

	[] remoteExec ["VMF_fnc_addMedicalEvent",[0,-2] select isDedicated,true];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(missionNamespace getVariable [QGVAR(enabled),false]) exitWith {};	//Exit if the setting is disabled

if !(hasInterface) exitWith {};		//Exit if the client isn't a player

if (playerSide == sideLogic) exitWith {};	//Exit if the player is a logic entity

private _eventId = player getVariable ["VMF_medicalNotificationEH",-1];

if (_eventId != -1) then {
	["ace_treatmentStarted",_eventId] call CBA_fnc_removeEventHandler;
};

_eventId = ["ace_treatmentStarted",{
	params [
		"_caller",
		"_target"
	];

	//Stops message appearing if you treat yourself
	if (_caller == _target) exitWith {};
	
	//Stops message appearing if treating an AI that's local to another player
	if !(isPlayer _target) exitWith {};

	private _playerName = profileName;

	if (alive _target) then {	//If treating a live target
		[_playerName] remoteExec [QFUNC(displayNotification),_target];
	};
}] call CBA_fnc_addEventHandler;

//Used to remove the event if the setting gets disabled
player setVariable ["VMF_medicalNotificationEH",_eventId];
