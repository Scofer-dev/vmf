#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_groupBftInit;

Description:
	Inititalises the local group BFT system, displaying markers for the approximate positions of groups containing players

Execution:
	- Local: Yes
	- Server: No
	- Global: Yes

Parameters:
    0: Update Delay <Number>			Default: 3
	1: Max Unit Distance <Number>		Default: 100
	2: Friendly Side Markers <Bool>		Default: true

Example:
	Enable Group BFT for the local player with default parameters
	[] call VMF_fnc_groupBftInit;

	Enable Group BFT for all players with custom parameters
	[5,50,false] remoteExec ["VMF_fnc_groupBftInit",[0,-2] select isDedicated,true];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

if (playerSide == sideLogic) exitWith {};

if !(canSuspend) exitWith {_this spawn VMF_fnc_groupBftInit};

params [
	["_updateDelay",3,[-1]],
	["_maxDistance",100,[-1]],
	["_friendSideMarkers",true,[true]]
];

if (missionNamespace getVariable ["VMF_groupBftRunning",false]) exitWith {systemChat "Group BFT already running"};
missionNamespace setVariable ["VMF_groupBftRunning",true];


addMissionEventHandler ["GroupDeleted",{
	if (missionNamespace setVariable ["VMF_groupBftRunning",true]) then {
		params ["_group"];

		private _marker = _group getVariable ["VMF_groupBftMarker",""];

		if (_marker isNotEqualTo "") then {
			deleteMarker _marker;
			_group setVariable ["VMF_groupBftMarker",""];
		};
	} else {
		removeMissionEventHandler ["GroupDeleted",_thisEventHandler];
	};	
}];

while {missionNamespace getVariable ["VMF_groupBftRunning",false]} do {
	{
		private _group = _x;

		if (
			side player isEqualTo side _group ||
			{_friendSideMarkers && {side player getFriend side _group > 0.6}}
		) then {
			private _units = units _group;

			if (_units findIf {_x in ([switchableUnits,playableUnits] select isMultiplayer)} isNotEqualTo -1) then {
				private _marker = _group getVariable ["VMF_groupBftMarker",""];

				if (_marker isEqualTo "") then {
					_marker = createMarkerLocal [str(_group),position (leader _group)];
					_marker setMarkerShapeLocal "ICON";
					_marker setMarkerTypeLocal "b_inf";
					_marker setMarkerTextLocal (groupId _group);
					_marker setMarkerColorLocal ("color" + str(side _group));

					_group setVariable ["VMF_groupBftMarker",_marker];

					_group addEventHandler ["GroupIdChanged",{
						params ["_group","_newGroupId"];
						if (missionNamespace getVariable ["VMF_groupBftRunning",false]) then {
							private _marker = _group getVariable ["VMF_groupBftMarker",""];
							if (_marker isNotEqualTo "") then {
								_marker setMarkerTextLocal _newGroupId;
							};
						} else {
							_group removeEventHandler ["GroupIdChanged",_thisEventHandler];
						};
					}];

					_group addEventHandler ["Empty",{
						params ["_group"];
						if (missionNamespace getVariable ["VMF_groupBftRunning",false]) then {
							private _marker = _group getVariable ["VMF_groupBftMarker",""];

							if (_marker isNotEqualTo "") then {
								deleteMarkerLocal _marker;
							};

							_group setVariable ["VMF_bftGlobalMarker",""];
						} else {
							_group removeEventHandler ["Empty",_thisEventHandler];
						};
					}];
				};

				private _vehicle = objectParent (leader _group);
				if (isNull _vehicle) then {
					_marker setMarkerTypeLocal "b_inf";
				} else {
					private _markerType = _vehicle call VMF_fnc_groupBftVehicleType;

					_marker setMarkerTypeLocal _markerType;
				};

				private _unitPositions = [];
				{
					if (leader _x distance _x <= _maxDistance) then {
						private _unitPos = getPos _x;
						_unitPos deleteAt 2;
						_unitPositions pushBack _unitPos;
					};
				} forEach _units;

				//Mitigates issues where player groups aren't reinitilised properly when leaving and rejoining
				if (_unitPositions isEqualTo []) exitWith {};

				private _vector = [0,0];
				{
					_vector = _vector vectorAdd _x;
				} forEach _unitPositions;


				private _centroid = _vector vectorMultiply (1 / (count _unitPositions));

				_marker setMarkerPosLocal _centroid;
			} else {
				private _marker = _group getVariable ["VMF_groupBftMarker",""];

				if (_marker isNotEqualTo "") then {
					deleteMarkerLocal _marker;
				};
			};
		};
	} forEach allGroups;

	sleep _updateDelay;
};
