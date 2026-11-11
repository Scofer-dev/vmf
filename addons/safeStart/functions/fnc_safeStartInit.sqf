#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_safeStartInit

Description:
    Activates Safe Start for each client if it's enabled, and the mission hasn't gone live

Execution:
	- Local: Yes
	- Server: No
	- Global: Yes

	Ideally executed automatically by VMF_fnc_initFramework

Parameters:
    N/A

Example:
	[] call VMF_fnc_safeStartInit;

	[] remoteExec ["VMF_fnc_safeStartInit",[0,-2] select isDedicated,true];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

waitUntil {!isNull player};

if !(missionNamespace getVariable ["VMF_safeStartEnabled",true]) exitWith {};

if (missionNamespace getVariable ["VMF_safeStartRunning",false]) exitWith {systemChat "Safe Start already running"};
missionNamespace setVariable ["VMF_safeStartRunning",true];

player allowDamage false;

//Prevents firing of weapons
private _fireAction = [
	player,
	"DefaultAction",
	"true",
	{
		hintSilent "Safe Start is Active!";
	}
] call ace_common_fnc_addActionEventHandler;

//Extra check that deletes projectiles if weapon is fired, also prevents grenade throwing
private _firedEH = player addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

	deleteVehicle _projectile;

	//If player throws a grenade delete the grenade projectile, and give player the grenade back
	if (_weapon == "Throw") then {
		_unit addMagazine _magazine;
	};
}];

//Find out the current status of ACE Advanced Throwing so it can be restored to that state when Safe Start ends
private _aceThrowing = ace_advanced_throwing_enabled;
//Disable throwing
ace_advanced_throwing_enabled = false;

//Make player immune to WBK melee damage
player setVariable ['IMS_IsUnitInvicibleScripted',1,true];

//Prevents placing ACE explosives
private _explosiveSetupEH = ["ace_explosives_setup",{
    _this params ["_explosive","_magClassname","_unit"];
    
    deleteVehicle _explosive;

    player addMagazine _magClassname;

    hintSilent "Safe Start is Active!";
}] call CBA_fnc_addEventHandler;

"VMF_safeStart" cutRsc ["VMF_safeStart","PLAIN",0];

waitUntil {sleep 0.5; !(missionNamespace getVariable ["VMF_safeStartRunning",false])};

//Re-enable player damage
if (playerSide != sideLogic) then {
	player allowDamage true;
};

//Allow players to shoot
[player,"DefaultAction",_fireAction] call ace_common_fnc_removeActionEventHandler;

//Allow players to throw grenades
player removeEventHandler ["Fired",_firedEH];

//Revert ACE Grenade Throwing to whatever it started as
ace_advanced_throwing_enabled = _aceThrowing;

//Remove player WBK melee immunity
player setVariable ['IMS_IsUnitInvicibleScripted',nil,true];

["ace_explosives_setup",_explosiveSetupEH] call CBA_fnc_removeEventHandler;

private _ctrl = uiNamespace getVariable "VMF_safeStart";
_ctrl ctrlSetText "Safe Start Disabled";
_ctrl ctrlSetBackgroundColor [0.8,0.2,0.2,1];

"VMF_safeStart" cutFadeOut 5;
