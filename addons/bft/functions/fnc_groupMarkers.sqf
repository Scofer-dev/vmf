#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_groupMarkersInit

Description:
    Initialises the markers for groups containing players

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
	[] call VMF_fnc_groupMarkers;

	Enable Group BFT for all players with custom parameters
	[5,50,false] remoteExec ["VMF_fnc_groupMarkers",[0,-2] select isDedicated,true];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

if (playerSide == sideLogic) exitWith {};

//Prevents it being run multiple times
if (missionNamespace getVariable ["VMF_groupBFT_active",false]) exitWith {};
missionNamespace setVariable ["VMF_groupBFT_active",true];

private _groupDeletedMEH = addMissionEventHandler ["GroupDeleted",{
	params ["_group"];
	private _marker = _group getVariable ["VMF_bftGroupMarker",""];

	if (_marker != "") then {
		deleteMarker _marker;
		_group setVariable ["VMF_bftGroupMarker",""];
	};
}];

missionNamespace setVariable ["VMF_groupBFT_groupDeletedMEH",_groupDeletedMEH];

params [
	["_updateDelay",3,[-1]],
	["_maxDistance",100,[-1]],
	["_friendSideMarkers",true,[true]]
];


//Prevents possibility of multiple update loops running simultaneously
if !(missionNamespace getVariable ["VMF_groupBFT_activeLoop",false]) then {
	missionNamespace setVariable ["VMF_groupBFT_activeLoop"];

	while {missionNamespace getVariable ["VMF_groupBFT_active",true]} do {
		{
			private _group = _x;

			if (side player == side _group || (_friendSideMarkers && side player getFriend side _group > 0.6)) then {
				private _units = units _group;

				if (_units findIf {_x in ([switchableUnits,playableUnits] select isMultiplayer)} != -1) then {
					private _marker = _group getVariable ["VMF_bftGroupMarker",""];

					if (_marker == "") then {
						_marker = createMarkerLocal [str(_group) + "_" + str(time),position (leader _group)];
						_marker setMarkerShapeLocal "ICON";
						_marker setMarkerTypeLocal "b_inf";
						_marker setMarkerTextLocal (groupId _group);
						_marker setMarkerColorLocal ("color" + str(side _group));

						_group setVariable ["VMF_bftGroupMarker",_marker];

						private _idChangedEH = _group addEventHandler ["GroupIdChanged",{
							params ["_group","_newGroupId"];

							private _marker = _group getVariable "VMF_bftGroupMarker";
							_marker setMarkerText _newGroupId;
						}];
						_group setVariable ["VMF_groupBFT_idChangedEH",_idChangedEH];

						private _emptyEH = _group addEventHandler ["Empty",{
							params ["_group"];

							private _marker = _group getVariable ["VMF_bftGroupMarker",""];

							if (_marker != "") then {
								deleteMarker _marker;
							};
						}];
						_group setVariable ["VMF_groupBFT_emptyEH",_emptyEH];
					};		

					private _playerVehicle = objectParent (leader _group);
					if !(isNull _playerVehicle) then {
						//If group leader is in a vehicle find out what kind of vehicle it is
						private _markerType = _playerVehicle call FUNC(groupMarkersvehicleType);

						_marker setMarkerTypeLocal _markerType;
					} else {
						//If the group leader isn't in a vehicle default to infantry
						_marker setMarkerTypeLocal "b_inf";
					};

					private _unitPositions = [];
					{
						if (leader _x distance _x <= _maxDistance) then {
							private _unitPos = getPos _x;
							_unitPos deleteAt 2;
							_unitPositions pushBackUnique _unitPos;
						};
					} forEach (units _group);

					//Mitigates issue where player groups aren't reinitilised after being deleted and a player JIPs into the group
					if (_unitPositions isEqualTo []) exitWith {};

					private _vector = [0,0];
					{
						_vector = _vector vectorAdd _x;
					} forEach _unitPositions;

					private _centroid = _vector vectorMultiply (1 / (count _unitPositions));

					_marker setMarkerPos _centroid;
				};
			};
		} forEach allGroups;

		sleep _updateDelay;
	};
};
