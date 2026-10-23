#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_addArsenalEH

Description:
    Adds CBA Event Handlers to the ACE Arsenal, executed as part of VMF_fnc_addArsenal for Safe Start Arsenal
    Does nothing to Arsenal opened by sideLogic Curators

Execution:
	- Local: Yes
	- Server: No
	- Global: Yes

Parameters:
   	N/A

Example:
	call VMF_fnc_addArsenalEH;

	[] remoteExec ["VMF_fnc_addArsenalEH",[0,-2] select isDedicated];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

if (playerSide == sideLogic) exitWith {};

//Removes the delete, loadout, export, and import buttons, saves player loadout to variable
["ace_arsenal_displayOpened",{
	params ["_display"];

	private _deleteButton = _display displayCtrl 40;
	private _loadoutButton = _display displayCtrl 1003;
	private _exportButton = _display displayCtrl 1004;
	private _importButton = _display displayCtrl 1005;

	{
		_x ctrlRemoveAllEventHandlers "ButtonClick";
	} forEach [_deleteButton,_loadoutButton,_exportButton,_importButton];

    player setVariable ["VMF_arsenalLoadout",getUnitLoadout player];
}] call CBA_fnc_addEventHandler;

//Removes the <Empty> option from the Arsenal left panel for all tabs except helmet and facewear
["ace_arsenal_leftPanelFilled",{
	params ["_display","_leftPanelIDC","_rightPanelIDC"];

	if !(_leftPanelIDC in [2008,2016]) then {
		private _leftPanel = _display displayCtrl 13;

		private _item = _leftPanel lbData 0;

		//I'm pretty sure it's always blank, but better to check
		if (_item == "") then {
			_leftPanel lbDelete 0;
		};
	};

    //Removes the delete, loadout, export, and import buttons
	private _deleteButton = _display displayCtrl 40;
	private _loadoutButton = _display displayCtrl 1003;
	private _exportButton = _display displayCtrl 1004;
	private _importButton = _display displayCtrl 1005;

	{
		_x ctrlShow false;
	} forEach [_deleteButton,_loadoutButton,_exportButton,_importButton];
}] call CBA_fnc_addEventHandler;


//Disables the empty select container button from the Arsenal right panel
["ace_arsenal_rightPanelFilled",{
	params ["_display","_leftPanelIDC","_rightPanelIDC"];

	private _deleteButton = _display displayCtrl 40;
	ctrlDelete _deleteButton;
}] call CBA_fnc_addEventHandler;


//Mitigates players being able to import a loadout with Ctrl+C
//Can't stop it happening, so next best is to revert it to a previously saved version

//Saves loadout when player changes uniform/vest/backpack cargo
["ace_arsenal_cargoChanged",{
    player setVariable ["VMF_arsenalLoadout",getUnitLoadout player];
}] call CBA_fnc_addEventHandler;;

//Saves loadout when player changes weapon attachment
["ace_arsenal_weaponItemChanged",{
    player setVariable ["VMF_arsenalLoadout",getUnitLoadout player];
}] call CBA_fnc_addEventHandler;;

//Saves loadout when player changes item
["ace_arsenal_itemsChanged",{
    player setVariable ["VMF_arsenalLoadout",getUnitLoadout player];
}] call CBA_fnc_addEventHandler;;

//Reverts loadout to a previously saved version when player attempts to import with Ctrl+C
["ace_arsenal_loadoutImported",{
    private _oldLoadout = player getVariable ["VMF_arsenalLoadout",[]];

    player setUnitLoadout _oldLoadout;
}] call CBA_fnc_addEventHandler;
