#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_battlefieldSounds

Description:
	Plays distant battlefield sounds for players

Execution:
	- Local: No
	- Server: Yes
	- Global: No

Parameters:
	0: Enable Distant Firefight Sounds <Bool>		Default: true
	1: Enable Distant Explosion Sounds <Bool>		Default: true
	2: Enable Distant Helicopter Sounds <Bool>		Default: true
	3: Enable Distant Jet Sounds <Bool>				Default: true

Example:
	[] spawn VMF_fnc_battlefieldSounds;

	[
		true,
		false,
		true,
		false
	] remoteExec ["VMF_fnc_battlefieldSounds",2];

Returns:
    0: Battlefield Sounds Enabled <Bool>

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(isServer) exitWith {false};		//Onlys wants to execute on server to keep sounds synchronised

if !(canSuspend) exitWith {_this spawn VMF_fnc_groupMarkers};

params [
	["_firefightSounds",true,[true]],
	["_explosionSounds",true,[true]],
	["_helicopterSounds",true,[true]],
	["_jetSounds",true,[true]]
];

if !(_firefightSounds || {_explosionSounds || {_helicopterSounds || {_jetSounds}}}) exitWith {
	false
};

if (_firefightSounds) then {
	_firefightSounds = ["BattlefieldFirefight1_3D","BattlefieldFirefight2_3D","BattlefieldFirefight3_3D","BattlefieldFirefight4_3D","",""];
} else {
	_firefightSounds = [];
};

if (_explosionSounds) then {
	_explosionSounds = ["BattlefieldExplosions1_3D","BattlefieldExplosions2_3D","BattlefieldExplosions3_3D","BattlefieldExplosions4_3D","BattlefieldExplosions5_3D","","","","",""];
} else {
	_explosionSounds = [];
};

if (_helicopterSounds) then {
	_helicopterSounds = ["BattlefieldHeli1_3D","BattlefieldHeli2_3D","BattlefieldHeli3_3D","","","","","","","","",""];
} else {
	_helicopterSounds = [];
};

if (_jetSounds) then {
	_jetSounds = ["BattlefieldJet1_3D","BattlefieldJet2_3D","BattlefieldJet3_3D","","","","","","","","",""];
} else {
	_jetSounds = [];
};

missionNamespace setVariable ["VMF_firefightSounds",_firefightSounds];
missionNamespace setVariable ["VMF_explosionSounds",_explosionSounds];
missionNamespace setVariable ["VMF_helicopterSounds",_helicopterSounds];
missionNamespace setVariable ["VMF_jetSounds",_jetSounds];


private _return = false;

//Only have a single loop active while allowing sound array updates
if !(missionNamespace getVariable ["VMF_battlefieldSoundsEnabled",false]) then {
	missionNamespace setVariable ["VMF_battlefieldSoundsEnabled",true];

	spawn {
		while {missionNamespace getVariable ["VMF_battlefieldSoundsEnabled",false]} do {
			private _firefightSounds = missionNamespace getVariable ["VMF_firefightSounds",[]];
			private _explosionSounds = missionNamespace getVariable ["VMF_explosionSounds",[]];
			private _helicopterSounds = missionNamespace getVariable ["VMF_helicopterSounds",[]];
			private _jetSounds = missionNamespace getVariable ["VMF_jetSounds",[]];

			if (_firefightSounds isNotEqualTo []) then {
				private _sound = selectRandom _firefightSounds;
				if (_sound isNotEqualTo "") then {
					[_sound] remoteExec ["playSound",[0,-2] select isDedicated];
				};
			};
			sleep 1;

			if (_explosionSounds isNotEqualTo []) then {
				private _sound = selectRandom _explosionSounds;
				if (_sound isNotEqualTo "") then {
					[_sound] remoteExec ["playSound",[0,-2] select isDedicated];
				};
			};
			sleep 1;

			if (_helicopterSounds isNotEqualTo []) then {
				private _sound = selectRandom _helicopterSounds;
				if (_sound isNotEqualTo "") then {
					[_sound] remoteExec ["playSound",[0,-2] select isDedicated];
				};
			};
			sleep 1;

			if (_jetSounds isNotEqualTo []) then {
				private _sound = selectRandom _jetSounds;
				if (_sound isNotEqualTo "") then {
					[_sound] remoteExec ["playSound",[0,-2] select isDedicated];
				};
			};
			sleep 5;

			sleep (random 10);	
		};
	};
	
	_return = true;
};

_return
