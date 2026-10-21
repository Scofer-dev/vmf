#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_addArsenal

Description:
    Adds ACE custom arsenal to each player, giving them access to all equipment they start with, and any additional gear as a parameter
	Does not limit Arsenal opened by sideLogic Curators

Execution:
	- Local: Yes
	- Server: No
	- Global: Yes

Parameters:
   	0: Arsenal Array File

Example:
	["arsenalArrays.sqf"] call VMF_fnc_addArsenal;

	["arsenalArrays.sqf"] remoteExec ["VMF_fnc_addArsenal",[0,-2] select isDedicated];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

if (playerSide == sideLogic) exitWith {};

params [
	["_arsenalFile","arsenalArrays.sqf",[""]]
];

private _arsenalArray = call compile preprocessFileLineNumbers _arsenalFile;

private _unitLoadout = flatten ([getUnitLoadout player] call acre_api_fnc_filterUnitLoadout);
_unitLoadout = _unitLoadout select {_x isEqualType ""};

_arsenalArray = _arsenalArray + _unitLoadout;
_arsenalArray = _arsenalArray arrayIntersect _arsenalArray;


[player,_arsenalArray] call ace_arsenal_fnc_addVirtualItems;

private _openArsenal = [
	"Open Arsenal",
	"Arsenal",
	"",
	{
		[player,player] call ace_arsenal_fnc_openBox;
	},
	{(missionNamespace getVariable ["VMF_safeStartEnabled",false])}
] call ace_interact_menu_fnc_createAction;

[
	player,
	1,
	["ACE_SelfActions"],
	_openArsenal
] call ace_interact_menu_fnc_addActionToObject;

call VMF_fnc_addArsenalEH;
