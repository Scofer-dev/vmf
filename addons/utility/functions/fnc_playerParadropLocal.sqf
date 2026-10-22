#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_playerParadropLocal

Description:
    Automatic local actions for players during running of VMF_fnc_playerParadrop
	Player backpack is saved, replaced with a parachute that automatically opens, and their original backpack is given back

Execution:
	- Client: Yes
	- Server: No
	- Global: No

Parameters:
	0: Parachute Backpack Class <String>	Default: "B_Parachute"

Example:
	[ 
		"B_Parachute"
	] remoteExec ["VMF_fnc_playerParadropLocal",playerOne];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

params [
	["_parachute","B_Parachute",[""]]
];

player allowDamage false;

player setVariable ["VMF_backpackData",[backpack player,backpackItems player]];

removeBackpack player;
player addBackpack _parachute;

//unassignVehicle player;
[player] remoteExec ["unassignVehicle",0];
moveOut player;

sleep 2;

player action ["OpenParachute"];

waitUntil {sleep 1; isNull objectParent player && {isTouchingGround player}};

removeBackpack player;

player getVariable ["VMF_backpackData",["",[]]] params [
	["_backpack","",[""]],
	["_backpackItems",[],[[]]]
];

player addBackpack _backpack;
{
	(unitBackpack player) addItemCargoGlobal [_x,1];
} forEach _backpackItems;

player allowDamage true;
