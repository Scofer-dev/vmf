/*
Function:
	VMF_fnc_initGenerateDisplay

Description:
	Adds necessary event handlers to the open Vehicle Spawner Display passed by VMF_fnc_vehicleSpawner

Execution:
	- 3den

Parameters:
	0: Spawner Display <Display>		Default: displayNull
	1: Spawn Position Object <Object>	Default: objNull
	2: Vehicle Data <Array>				Default: []

Examples:
	[_display] call VMF_fnc_initGenerateDisplay;

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(is3DEN) exitWith {};

private _display3DEN = uiNamespace getVariable "display3den";
private _display = _display3DEN createDisplay "vmf_generateFiles";

if (isNull _display) exitWith {};

//fileExists "generated_arsenalArray.txt";

private _descriptionButton = uiNamespace getVariable ["VMF_generateFiles_descriptionButton",controlNull];
private _descriptionText = uiNamespace getVariable ["VMF_generateFiles_descriptionText",controlNull];


if (fileExists "description.ext") then {
    _descriptionText ctrlSetText "File 'description.ext' exists";
} else {
    if (fileExists "generated_description.txt") then {
        _descriptionText ctrlSetText "File 'generated_description.txt' exists";
    } else {
        _descriptionText ctrlSetText "No description file exists";
    };
};

private _briefingButton = uiNamespace getVariable ["VMF_generateFiles_briefingButton",controlNull];
private _briefingText = uiNamespace getVariable ["VMF_generateFiles_briefingText",controlNull];

if (fileExists "briefing.sqf") then {
    _briefingText ctrlSetText "File 'briefing.sqf' exists";
} else {
    if (fileExists "generated_briefing.txt") then {
        _briefingText ctrlSetText "File 'generated_briefing.txt' exists";
    } else {
        _briefingText ctrlSetText "No briefing file exists";
    };
};

private _initButton = uiNamespace getVariable ["VMF_generateFiles_initButton",controlNull];
private _initText = uiNamespace getVariable ["VMF_generateFiles_initText",controlNull];

private _initPlayerLocalButton = uiNamespace getVariable ["VMF_generateFiles_initPlayerLocalButton",controlNull];
private _initPlayerLocalText = uiNamespace getVariable ["VMF_generateFiles_initPlayerLocalText",controlNull];

private _initPlayerServerButton = uiNamespace getVariable ["VMF_generateFiles_initPlayerServerButton",controlNull];
private _initPlayerServerText = uiNamespace getVariable ["VMF_generateFiles_initPlayerServerText",controlNull];

private _initServerButton = uiNamespace getVariable ["VMF_generateFiles_initServerButton",controlNull];
private _initServerText = uiNamespace getVariable ["VMF_generateFiles_initServerText",controlNull];

private _arsenalArrayButton = uiNamespace getVariable ["VMF_generateFiles_arsenalArrayButton",controlNull];
private _arsenalArrayText = uiNamespace getVariable ["VMF_generateFiles_arsenalArrayText",controlNull];

private _defineRgsButton = uiNamespace getVariable ["VMF_generateFiles_defineRgsButton",controlNull];
private _defineRgsText = uiNamespace getVariable ["VMF_generateFiles_defineRgsText",controlNull];

















{
    _x params ["_button","_text"];




} forEach [
    [_descriptionButton,_descriptionText],
    [_briefingButton,_briefingText],
    [_initButton,_initText],
    [_initPlayerLocalButton,_initPlayerLocalText],
    [_initPlayerServerButton,_initPlayerServerText],
    [_initServerButton,_initServerText],
    [_arsenalArrayButton,_arsenalArrayText],
    [_defineRgsButton,_defineRgsText]
];
















private _closeButton = uiNamespace getVariable ["VMF_generateFiles_closeButton",controlNull];
private _closeButtonEH = _closeButton ctrlAddEventHandler ["buttonClick",{
    private _display = uiNamespace getVariable ["VMF_generateFiles_display",displayNull];
    _display closeDisplay 2;
}];
