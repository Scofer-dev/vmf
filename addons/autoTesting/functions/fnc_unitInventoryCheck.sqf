#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: VMF_fnc_unitInventoryCheck

Description:
    Checks the inventory of each player, checks for sufficient medical supplies, having a radio, and checking those the ACRE radio nets

Execution:
	- Eden Editor

Parameters:
    N/A

Example:
	[_unit] call VMF_fnc_unitInventoryCheck;

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(is3DEN) exitWith {};

params [
    ["_unit",objNull,[objNull]]
];
if (isNull _unit) exitWith {};

private _return = [];

private _medicalArray = [
    ["Bandage (Basic)","ACE_fieldDressing",0,[10,50]],
    ["Morphine","ACE_epinephrine",0,[4,19]],
    ["Epinephrine","ACE_epinephrine",0,[4,19]],
    ["Tourniquet","ACE_tourniquet",0,[2,7]],
    ["Splint","ACE_splint",0,[2,7]],
    ["Blood (1000ml)","ACE_bloodIV",0,[0,10]],
    ["Blood (500)","ACE_bloodIV_500",0,[0,10]],
    ["Blood (250)","ACE_bloodIV_250",0,[0,10]],
    ["Personal Aid Kit","ACE_personalAidKit",0,[0,1]]
];
private _radioArray = [];

private _acreRadios = ["ACRE_PRC117F","ACRE_PRC148","ACRE_PRC152","ACRE_PRC343","ACRE_PRC77","ACRE_BF888S","ACRE_SEM52SL","ACRE_SEM70"];
private _aceMedical = ["ACE_fieldDressing","ACE_epinephrine","ACE_epinephrine","ACE_tourniquet","ACE_splint","ACE_bloodIV","ACE_bloodIV_500","ACE_bloodIV_250","ACE_personalAidKit"];



getUnitLoadout _unit params [
    ["_primaryWeapon",[],[[]]],
    ["_secondaryWeapon",[],[[]]],
    ["_handgunWeapon",[],[[]]],
    ["_uniform",[],[[]]],
    ["_vest",[],[[]]],
    ["_backpack",[],[[]]],
    ["_headgear","",[""]],
    ["_goggles","",[""]],
    ["_binoculars",[],[[]]],
    ["_assignedItems",[],[[]]]
];

{
    if (_x isEqualTo []) exitWith {};
    {
        _x params [
            "_itemClass",
            "_amount"
        ];

        
        switch true do {
            case (_itemClass in _aceMedical): {
                private _arrayIndex = _medicalArray findIf {_x select 1 == _itemClass};
                private _itemAmount = (_medicalArray select _arrayIndex) select 2;
                ADD(_itemAmount,_amount);
                [_medicalArray,[_arrayIndex,2],_itemAmount] call BIS_fnc_setNestedElement;
            };
            case (_itemClass in _acreRadios): {
                private _arrayIndex = _radioArray findIf {_x select 0 == _itemClass};
                if (_arrayIndex == -1) then {
                    _radioArray pushBack _x;
                } else {
                    private _itemAmount = (_radioArray select _arrayIndex) select 1;
                    ADD(_itemAmount,_amount);
                    [_radioArray,[_arrayIndex,1],_itemAmount] call BIS_fnc_setNestedElement;
                };
            };
        };
    } forEach (_x select 1);
} forEach [_uniform,_vest,_backpack];

private _radioCheckOutput = [];
if (count _radioArray > 0) then {
    _radioCheckOutput pushBack [_radioArray,0,format ["Unit %1 has %2 radio(s)",_unit,count _radioArray]];
} else {
    _radioCheckOutput pushBack [[],1,format ["Unit %1 has no radio",_unit]];
};
_return pushBack _radioCheckOutput;


private _isMedic = false;
if (_unit getVariable ["ace_medical_medicClass",0] > 0) then {
    _isMedic = true;
};

private _medicalCheckOutput = [];
{
    _x params [
        "_itemName",
        "_itemClass",
        "_amount",
        "_requiredAmounts"
    ];

    if (_amount < (_requiredAmounts select _isMedic)) then {
        _medicalCheckOutput pushBack [_itemName,_amount,1,format ["Unit %1 has less than the recommended amount of %2",_unit,_itemName]];
    } else {
        _medicalCheckOutput pushBack [_itemName,_amount,0,format ["Unit %1 meets the recommended amount of %2",_unit,_itemName]];
    };


} forEach _medicalArray;
_return pushBack _medicalCheckOutput;

_return 



/*
[
    [//Primary Weapon
        Classname,
        Suppressor,
        Pointer,
        Optics,
        Muzzle 1,
        Muzzle 2,
        Bipod
    ],
    [//Secondary Weapon
        Classname,
        Suppressor,
        Pointer,
        Optics,
        Muzzle 1,
        Muzzle 2,
        Bipod
    ],
    [//Uniform
        Classname,
        [
            Items name and count,
            Magazine name and count,
            Weapon details,
            Container name and if backpack
        ]
    ],
    [//Vest
        Classname,
        [
            Items name and count,
            Magazine name and count,
            Weapon details,
            Container name and if backpack
        ]
    ],
    [//Backpack
        Classname,
        [
            Items name and count,
            Magazine name and count,
            Weapon details,
            Container name and if backpack
        ]
    ],
    [//Handgun Weapon
        Classname,
        Suppressor,
        Pointer,
        Optics,
        Muzzle 1,
        Muzzle 2,
        Bipod
    ],
    Headgear,
    Facewear,
    [//Binoculars
        Classname,
        Suppressor,
        Pointer,
        Optics,
        Muzzle 1,
        Muzzle 2,
        Bipod
    ],
    [//Asssigned Items
        Map,
        GPS,
        Radio,
        Compass,
        Watch,
        NVG
    ]
]
*/
