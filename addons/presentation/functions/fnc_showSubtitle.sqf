#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_showSubtitle

Description:
	Modified version of BIS_fnc_showSubtitle to put subtitles at the top of screen and cut out some superfluous stuff

Execution:
	- Local: Yes
	- Server: No
	- Global: Yes

Parameters:
	0: Speaker <String>
	1: Text <String>

Example:
	[
		"ION HQ",
		"Knight Flight, clear for take-off"
	] spawn VMF_fnc_showSubtitle;

	[
		"ION HQ",
		"Knight Flight, clear for take-off"
	] remoteExec ["VMF_fnc_showSubtitle",[0,-2] select isDedicated];

Returns:
    Nothing

Author:
	Thomas Ryan, updated by Karel Moricky, modified by Scofer

---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

params [
	["_title","",[""]],
	["_text","",[""]]
];

//Allow no title, but don't allow no text
if (_text isEqualTo "") exitWith {};

//Different script name so BIS_fnc_showSubtitle can still work alongside it
if !(isNil {VMF_fnc_showSubtitle_script}) then {
	terminate VMF_fnc_showSubtitle_script;
};

VMF_fnc_showSubtitle_script = [_title,_text] spawn {
	private _POS_W = (0.5 * safeZoneW);
	private _POS_H = (safeZoneH);
	private _POS_X = (0.5 - _POS_W / 2);
	private _POS_Y = (safeZoneY + (1/8) * safeZoneH);

	params [
		["_title","",[""]],
		["_text","",[""]]
	];

	"VMF_subtitles" cutRsc ["RscDynamicText","PLAIN"];

	private "_display";
	waitUntil {_display = uiNamespace getVariable "BIS_dynamicText"; !(isNull _display)};

	private _dummyCtrl = _display ctrlcreate ["RscStructuredText",-1];

    _dummyCtrl ctrlSetBackgroundColor [0,0,0,0];
	_dummyCtrl ctrlSetTextColor [0,0,0,0];
    _dummyCtrl ctrlSetPosition [_POS_X,_POS_Y,_POS_W,_POS_H];
	_dummyCtrl ctrlCommit 0;

    _dummyCtrl ctrlSetStructuredText parseText format [
        "<t align='center' shadow='2' size='%2' font='RobotoCondensedBold'>%1</t>",
		_text,
		(safezoneH * 0.65) max 1
	];

	private _ctrlWidth = ctrlTextWidth _dummyCtrl;

    if (_ctrlWidth < 1.21172) then {	//1 line
        _POS_Y = (safeZoneY + (0.75/8) * safeZoneH);
    } else {
        if (_ctrlWidth < 2.40490) then {	//2 lines
            _POS_Y = (safeZoneY + (0.96/8) * safeZoneH);
        } else {
            if (_ctrlWidth < 3.60439) then {	//3 lines
                _POS_Y = (safeZoneY + (1.166/8) * safeZoneH);
            } else {
                if (_ctrlWidth < 4.79126) then {	//4 lines
                    _POS_Y = (safeZoneY + (1.374/8) * safeZoneH);
                };
            };
        };
    };

	_dummyCtrl ctrlSetFade 0;
    _dummyCtrl ctrlCommit 0;


	private _ctrl = _display ctrlcreate ["RscStructuredText",-1];//_display displayCtrl 9999;
	uiNamespace setVariable ["BIS_dynamicText", displayNull];


	_ctrl ctrlSetBackgroundColor (["Subtitles","Background"] call bis_fnc_displayColorGet);
	_ctrl ctrlSetTextColor (["Subtitles","Text"] call bis_fnc_displayColorGet);
	_ctrl ctrlSetPosition [_POS_X,_POS_Y,_POS_W,_POS_H];
	_ctrl ctrlCommit 0;


	// Show subtitle
	_ctrl ctrlSetStructuredText parseText format [
		if (_title isEqualTo "") then {
			"<t align='center' shadow='2' size='%3' font='RobotoCondensedBold'>%2</t>"
		} else {
			"<t align='center' shadow='2' size='%3' font='RobotoCondensedBold'>%1:<br />%2</t>"
		},
		toUpper _title,
		_text,
		(safezoneH * 0.65) max 1
	];

	private _textHeight = ctrlTextHeight _ctrl;
	_ctrl ctrlSetPosition [_POS_X,_POS_Y - _textHeight,_POS_W,_textHeight];
	_ctrl ctrlCommit 0;

	sleep 10;

	// Hide subtitle
	_ctrl ctrlSetFade 1;
	_ctrl ctrlCommit 0.5;
};
