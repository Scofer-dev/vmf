#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_battlefieldSounds

Description:
	Plays battlefield sounds for players, sounds selected from passed sound name arrays
	Can be executed multiple times to update the sound arrays
	Add "" to arrays to add a chance no sound plays
	Leave an array empty to disable that particular sound array

Execution:
	- Local: Yes
	- Server: No
	- Global: Yes

Parameters:
	0: Firefight Sound Array <Array of Strings>		Default: ["BattlefieldFirefight1_3D","BattlefieldFirefight2_3D","BattlefieldFirefight3_3D","BattlefieldFirefight4_3D","",""]
	1: Explosion Sound Array <Array of Strings>		Default: ["BattlefieldExplosions1_3D","BattlefieldExplosions2_3D","BattlefieldExplosions3_3D","BattlefieldExplosions4_3D","BattlefieldExplosions5_3D","","","","",""]
	2: Aircraft Sound Array <Array of Strings>		Default: ["BattlefieldHeli1_3D","BattlefieldHeli2_3D","BattlefieldHeli3_3D","BattlefieldJet1_3D","BattlefieldJet2_3D","BattlefieldJet3_3D","","","","","",""]

Example:
	[
		["BattlefieldFirefight1_3D","BattlefieldFirefight2_3D","BattlefieldFirefight3_3D","BattlefieldFirefight4_3D","",""],
		["BattlefieldExplosions1_3D","BattlefieldExplosions2_3D","BattlefieldExplosions3_3D","BattlefieldExplosions4_3D","BattlefieldExplosions5_3D","","","","",""],
		["BattlefieldHeli1_3D","BattlefieldHeli2_3D","BattlefieldHeli3_3D","BattlefieldJet1_3D","BattlefieldJet2_3D","BattlefieldJet3_3D","","","","","",""]
	] call VMF_fnc_battlefieldSounds;

	[
		["BattlefieldFirefight1_3D","BattlefieldFirefight2_3D","BattlefieldFirefight4_3D","",""],
		["BattlefieldExplosions1_3D","BattlefieldExplosions3_3D","",""],
		["BattlefieldJet1_3D","BattlefieldJet2_3D","BattlefieldJet3_3D","","",""]
	] remoteExec ["VMF_fnc_battlefieldSounds",[0,-2] select isDedicated];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};		//Exit if the client isn't a player

params [
	["_firefightSounds",["BattlefieldFirefight1_3D","BattlefieldFirefight2_3D","BattlefieldFirefight3_3D","BattlefieldFirefight4_3D","",""],[[]]],
	["_explosionSounds",["BattlefieldExplosions1_3D","BattlefieldExplosions2_3D","BattlefieldExplosions3_3D","BattlefieldExplosions4_3D","BattlefieldExplosions5_3D","","","","",""],[[]]],
	["_aircraftSounds",["BattlefieldHeli1_3D","BattlefieldHeli2_3D","BattlefieldHeli3_3D","BattlefieldJet1_3D","BattlefieldJet2_3D","BattlefieldJet3_3D","","","","","",""],[[]]]
];

missionNamespace setVariable ["VMF_firefightSounds",_firefightSounds];
missionNamespace setVariable ["VMF_explosionSounds",_explosionSounds];
missionNamespace setVariable ["VMF_aircraftSounds",_aircraftSounds];


//Only have a single loop active while allowing sound array updates
if !(missionNamespace getVariable ["VMF_battlefieldSoundsActive",false]) then {
	missionNamespace setVariable ["VMF_battlefieldSoundsActive",true];

	while {missionNamespace getVariable ["VMF_battlefieldSoundsActive",false]} do {
		private _firefightSounds = missionNamespace getVariable ["VMF_firefightSounds",[]];
		private _explosionSounds = missionNamespace getVariable ["VMF_explosionSounds",[]];
		private _aircraftSounds = missionNamespace getVariable ["VMF_aircraftSounds",[]];

		if !(_firefightSounds isEqualTo []) then {
			playSound (selectRandom _firefightSounds);
		};
		sleep 1;

		if !(_explosionSounds isEqualTo []) then {
			playSound (selectRandom _explosionSounds);
		};
		sleep 1;

		if !(_aircraftSounds isEqualTo []) then {
			playSound (selectRandom _aircraftSounds);
		};
		sleep 5;

		sleep (random 10);	
	};
};
