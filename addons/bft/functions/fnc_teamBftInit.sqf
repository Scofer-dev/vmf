#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_teamBftInit

Description:
    Initialises the local team BFT system, displaying markers for the players team members positions

Execution:
	- Local: Yes
	- Server: No
	- Global: Yes

Parameters:
    0: Update Delay <Number>			Default: 3

Example:
	Enable Team BFT for the local player with default parameters
	[] call VMF_fnc_teamBftInit;

	Enable Team BFT for all players with custom parameters
	[5] remoteExec ["VMF_fnc_teamBftInit",[0,-2] select isDedicated,true];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

if (playerSide == sideLogic) exitWith {};

if !(canSuspend) exitWith {_this spawn VMF_fnc_teamBftInit};

params [
	["_updateDelay",3,[-1]]
];

if (missionNamespace getVariable ["VMF_teamBftRunning",false]) exitWith {systemChat "Team BFT already running"};
missionNamespace setVariable ["VMF_teamBftRunning",true];

while {missionNamespace getVariable ["VMF_teamBftRunning",false]} do {
	private _group = group player;

	private _unitLeftEH = _group getVariable ["VMF_teamBft_unitLeftEH",-1];
	if (_unitLeftEH isEqualTo -1) then {
		_unitLeftEH = _group addEventHandler ["UnitLeft",{
			params ["_group","_oldUnit"];

			if (isNull _oldUnit) exitWith {};

			if (missionNamespace getVariable ["VMF_teamBftRunning",false]) then {
				if (player isEqualTo _oldUnit) then {
					{
						private _unit = _x;
						private _marker = _unit getVariable ["VMF_teamBftMarker",""];
						if (_marker isNotEqualTo "") then {
							deleteMarkerLocal _marker;
							_unit setVariable ["VMF_teamBftMarker",""];
						};
					} forEach (units _group);
				} else {
					private _marker = _oldUnit getVariable ["VMF_teamBftMarker",""];

					if (_marker isNotEqualTo "") then {
						deleteMarkerLocal _marker;
						_unit setVariable ["VMF_teamBftMarker",""];
					};
				};
			} else {
				_group removeEventHandler ["UnitLeft",_thisEventHandler];
			};
		}];
	};

	{
		private _unit = _x;
		private _marker = _unit getVariable ["VMF_teamBftMarker",""];

		if (_marker isEqualTo "") then {
			_marker = createMarkerLocal [str(_unit),position _unit];

			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "mil_triangle";
			_marker setMarkerSizeLocal [0.5,0.75];

			_unit setVariable ["VMF_teamBftMarker",_marker];
		};

		_marker setMarkerColorLocal ([_unit] call VMF_fnc_teamBftColour);
		_marker setMarkerPosLocal position _unit;
		_marker setMarkerDirLocal getDir _unit;
	} forEach (units _group);

	sleep _updateDelay;
};
