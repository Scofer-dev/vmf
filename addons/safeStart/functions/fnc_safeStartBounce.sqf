/* ----------------------------------------------------------------------------
Function: VMF_fnc_safeStartBounce

Description:
    Makes local players Safe Start box bounce around like a TV DVD standby screen

Execution:
	- Local: Yes
	- Server: No
	- Global: Yes

Parameters:
    N/A

Example:
    call VMF_fnc_safeStartBounce;

    [] remoteExec ["VMF_fnc_safeStartBound",[0,-2] select isDedicated];

	[] remoteExec ["VMF_fnc_safeStartBounce",playerOne];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

if !(missionNamespace getVariable ["VMF_safeStartEnabled",false]) exitWith {};
if !(missionNamespace getVariable ["VMF_safeStartRunning",false]) exitWith {};

private _ctrl = uiNamespace getVariable "VMF_safeStart";

//Starting position of Safe Start UI
private _xPos = safeZoneX;
private _yPos = safeZoneY + safeZoneH - (safeZoneH * 0.03819445);

private _speedX = 0.006;
private _speedY = 0.003;

//Left side of screen
private _minX = safeZoneX;

//Right side of screen - width of safe start box
private _maxX = safeZoneX + safeZoneW - (safeZoneW * 0.11914063);

//Top of screen
private _minY = safeZoneY;

//Bottom of screen - height of safe start box
private _maxY = safeZoneY + safeZoneH - (safeZoneH * 0.03819445);


while {missionNamespace getVariable ["VMF_safeStartRunning",false]} do {
    _xPos = _xPos + _speedX;
    _yPos = _yPos + _speedY;

    //Check if position is at or outside screen boundary and reverse that axis' speed
    //Left
    if (_xPos <= _minX) then {
        _xPos = _minX;
        _speedX = -_speedX;
    };

    //Right
    if (_xPos >= _maxX) then {
        _xPos = _maxX;
        _speedX = -_speedX;
    };

    //Top
    if (_yPos <= _minY) then {
        _yPos = _minY;
        _speedY = -_speedY;
    };

    //Bottom
    if (_yPos >= _maxY) then {
        _yPos = _maxY;
        _speedY = -_speedY;
    };

    _ctrl ctrlSetPosition [_xPos,_yPos];
    _ctrl ctrlCommit 0;

    sleep 0.01;
};

/*
Top Left -      [-0.712121,-0.409091]
_ctrl ctrlSetPosition [safeZoneX,safeZoneY];


Bottom Left -   [-0.712121,1.33965]
_ctrl ctrlSetPosition [safeZoneX,safeZoneY + safeZoneH - ((ctrlPosition _ctrl) select 3)];


Top Right -     [1.4233,-0.409091]
_ctrl ctrlSetPosition [safeZoneX + safeZoneW - ((ctrlPosition _ctrl) select 2),safeZoneY];


Bottom Right -  [1.4233,1.33965]
_ctrl ctrlSetPosition [safeZoneX + safeZoneW - ((ctrlPosition _ctrl) select 2),safeZoneY + safeZoneH - ((ctrlPosition _ctrl) select 3)];
*/