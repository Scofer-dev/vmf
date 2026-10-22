#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_playerParadrop

Description:
    Initiates a player paradrop
	Players don't need a parachute backpack, they will keep whatever their backpack is

Execution:
	- Client: No
	- Server: Yes
	- Global: No

Parameters:
    0: Aircraft Classname <String>
	1: Drop Position <PositionASL Array> - Z-pos is the drop height. Planes complete waypoints from further away, position may need to be about ~200 further on
	2: Direction <Number>
	3: Players <Array of Objects>
	4: Side <Side>							Default: civilian		//AI don't shoot civilian planes
	5: Parachute Backpack Class <String>	Default: "B_Parachute"

Examples:
	//Get all playable units in multiplayer and singleplayer
	private _players = []; 
	if (isMultiPlayer) then { 
		_players = playableUnits select {!(_x isKindOf "VirtualMan_F")}; 
	} else { 
		_players = switchableUnits select {!(_x isKindOf "VirtualMan_F")}; 
	}; 
					
	[ 
		"LIB_C47_Skytrain", 
		[1500,3050,300], 
		90, 
		_players,
		civilian,
		"B_Parachute"
	] call VMF_fnc_playerParadrop; 

	[ 
		"LIB_C47_Skytrain", 
		[1500,3050,300], 
		90, 
		_players,
		civilian,
		"B_Parachute"
	] remoteExec ["VMF_fnc_playerParadrop",2];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(isServer) exitWith {};

params [
	["_aircraftClass","",[""]],
	["_dropPos",[0,0,0],[[]]],
	["_direction",-1,[0]],
	["_players",[],[[]]],
	["_side",civilian,[west]],
	["_parachute","B_Parachute",[""]]
];

if (_aircraftClass isEqualTo "") exitWith {
	["[VMF playerParadrop] Aircraft Classname is blank"] call BIS_fnc_error;
};

if !(isClass (configFile >> "CfgVehicles" >> _aircraftClass)) exitWith {
	["[VMF playerParadrop] Aircraft '%1' doesn't exist",_aircraftClass] call BIS_fnc_error;
};

if (_dropPos isEqualTo [0,0,0]) exitWith {
	["[VMF playerParadrop] Drop position not set"] call BIS_fnc_error;
};

if (_direction isEqualTo -1) exitWith {
	["[VMF playerParadrop] Drop direction not set"] call BIS_fnc_error;
};

if (_players isEqualTo []) exitWith {
	["[VMF playerParadrop] No players passed to function"] call BIS_fnc_error;
};

private _dropHeight = _dropPos select 2;

_dropPos params [
	"_dropPosX",
	"_dropPosY",
	"_dropPosZ"
];

//Finds the start position 3000m away from the paradrop position, _direction  -180 as it's basically looking backwards
private _startPosX = (3000 * (sin(_direction - 180))) + _dropPosX;
private _startPosY = (3000 * (cos(_direction - 180))) + _dropPosY;

private _runUpStartPos = [
	_startPosX,
	_startPosY,
	_dropHeight
];

private _runExitPos = [
	(3000 * (sin(_direction))) + _dropPosX,
	(3000 * (cos(_direction))) + _dropPosY,
	_dropHeight
];

private _runDistance = _runUpStartPos distance _runExitPos;

private _positionArray = [];
for "_i" from 0 to _runDistance step 1000 do {
	private _xPos = (_i * (sin _direction)) + _startPosX;
	private _yPos = (_i * (cos _direction)) + _startPosY;

	_positionArray pushBack [_xPos,_yPos,_dropHeight];
};

[_runUpStartPos,_direction,_aircraftClass,_side] call BIS_fnc_spawnVehicle params [
	"_plane",
	"_crew",
	"_group"
];

_plane enableSimulationGlobal false;
_plane allowDamage false;
_plane disableAI "TARGET";
_plane disableAI "AUTOTARGET";

_plane flyInHeightASL [_dropHeight, _dropHeight, _dropHeight];
_plane lock true;
_plane setVariable ["VMF_paradropParams",[_players,_parachute],true];

_group allowFleeing 0;
_group setBehaviour "CARELESS";
_group setSpeedMode "LIMITED";
_group setCombatMode "WHITE";


{
	private _waypoint = _group addWaypoint [_x,-1];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointForceBehaviour true;
	
	switch (_forEachIndex) do {
		case 3: {//Drop point
			_waypoint setWaypointStatements [
				"true",
				toString {
					private _plane = vehicle leader this;

					[_plane] spawn {
						if (isServer) then {
							_this params [
								"_plane"
							];

							_plane getVariable "VMF_paradropParams" params [
								["_paratroopers",[],[[]]],
								["_parachute","B_Parachute",[""]]
							];

							{
								private _unit = _x;

								[_parachute] remoteExec ["VMF_fnc_playerParadropLocal",_unit];
								//unassignVehicle _unit;	//If not done the plane will try to reach [0,0,0] for some reason
								[_unit] remoteExec ["unassignVehicle",0];

								sleep 1;
							} forEach _paratroopers;
						};
					};
				}
			];
		};
		case 6: {//End point
			_waypoint setWaypointStatements [
				"true",
				toString {
					if (isServer) then {
						[this] call VMF_fnc_deleteVehicle;
					};
				}
			];
			_waypoint setWaypointCompletionRadius 500;
		};
	};
} forEach _positionArray;

{	
	[_x,_plane] remoteExec ["moveInCargo",_x];
	[_x,_plane] remoteExec ["assignAsCargo",0];
	_x assignAsCargo _plane;	//If not done the plane will try land at [0,0,0] for some reason
} forEach _players;


_group setGroupOwner 2;
_plane engineOn true;

_plane enableSimulationGlobal true;
_plane setVelocityModelSpace [0,100,0];
