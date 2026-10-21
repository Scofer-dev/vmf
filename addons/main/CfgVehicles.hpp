#include "script_component.hpp"

class CfgVehicles {
	class Logic;
	class Module_F: Logic
    {
        class AttributesBase
        {
            class Default;
            class Edit; // Default edit box (i.e., text input field)
            class Combo; // Default combo box (i.e., drop-down menu)
            class CheckBox; // Tickbox, returns true/false
            class CheckBoxNumber; // Tickbox, returns 1/0
            class ModuleDescription; // Module description
        };
        class ModuleDescription
        {
            class Anything;
        };
    };

    class VMF_frameworkSettings: Module_F {
        author = "Scofer";
        scope = 2;
        displayName = "Void Mission Framework";
        isGlobal = 0;   //Server execution
        category = "VMF_modules";
        icon = "\z\vmf\addons\main\void_white_128.paa";
        function = "VMF_fnc_initFramework";
        functionPriority = 0;
        isTriggerActivated = 0;
        isDisposable = 1;

        class Attributes: AttributesBase {
            class VMF_safeStartSubCat {
                property = "VMF_safeStartSubCat";
                title = "Safe Start";
                control = "SubCategory";
            };
            class VMF_enableSafeStart: Checkbox {
                property = "VMF_enableSafeStart";
                displayName = "Enable Safe Start";
                tooltip = "Enable Safe Start, preventing players from taking and dealing damage until disabled";
                defaultValue = "true";
            };
            class VMF_arsenalArrayFile: Edit {
                property = "VMF_arsenalArrayFile";
                displayName = "Arsenal Array File";
                tooltip = "The mission file that returns an array of all the items a player can access in the Safe Start Arsenal. Ignored if file doesn't exist.";
                defaultValue = "arsenalArrays.sqf";
            };


            class VMF_medicalNotificationSubCat {
                property = "VMF_medicalNotificationSubCat";
                title = "ACE Medical Notification";
                control = "SubCategory";
            };
            class VMF_enableMedicalNotification: Checkbox {
                property = "VMF_enableMedicalNotification";
                displayName = "Enable ACE Medical Notifications";
                tooltip = "Enable ACE Medical Notifications, informing players when they're being treated";
                defaultValue = "true";
            };


            class VMF_groupBFTSubCat {
                property = "VMF_groupBFTSubCat";
                title = "Group Blue Force Tracker";
                control = "SubCategory";
            };
            class VMF_enableGroupBFT: Checkbox {
                property = "VMF_enableGroupBFT";
                displayName = "Enable Group BFT";
                tooltip = "Enable Group BFT, showing the approximate location of friendly player groups";
                defaultValue = "true";
            };
            class VMF_groupBFTUpdateTimer: Edit {
                property = "VMF_groupBFTUpdateDelay";
                displayName = "Group BFT Update Delay";
                tooltip = "The delay in seconds between Group Marker position updates";
                defaultValue = "3";
                typeName = "NUMBER";
                validate = "number";
            };
            class VMF_groupBFTMarkerMaxUnitDistance: Edit {
                property = "VMF_groupMarkerMaxUnitDistance";
                displayName = "Group Marker Max Unit Distance";
                tooltip = "The maximum distance a unit can be from its group leader for its position to be counted for the group marker position";
                defaultValue = "100";
                typeName = "NUMBER";
                validate = "number";
            };
            class VMF_groupBFTFriendSideMarkers: Checkbox {
                property = "VMF_groupBFTFriendSideMarkers";
                displayName = "Friendly Side Markers";
                tooltip = "Shows players group markers from friendly sides, not just their own side";
                defaultValue = "true";
            };


            class VMF_teamBFTSubCat {
                property = "VMF_teamBFTSubCat";
                title = "Team Blue Force Tracker";
                control = "SubCategory";
            };
            class VMF_enableTeamBFT: Checkbox {
                property = "VMF_enableTeamBFT";
                displayName = "Enable Team BFT";
                tooltip = "Enable Team BFT, showing the location of units in the same group";
                defaultValue = "true";
            };
            class VMF_teamBFTUpdateDelay: Edit {
                property = "VMF_teamBFTUpdateDelay";
                displayName = "Team BFT Update Delay";
                tooltip = "The delay in seconds between Team Marker position updates";
                defaultValue = "3";
                typeName = "NUMBER";
                validate = "number";
            };

            class ModuleDescription: ModuleDescription{};
        };


            /*
            
            class VMF_battlefieldSoundsSubCat {
                property = "VMF_battlefieldSoundsSubCat";
                title = "Battlefield Sounds";
                control = "SubCategoryDesc1";
                description = "Enable different types of distant battlefield sounds";
            };
            class VMF_enableBattlefieldSounds: Checkbox {
                property = "VMF_enableBattlefieldSounds";
                displayName = "Enable Battlefield Sounds";
                tooltip = "Enables distant battlefield sounds";
                defaultValue = "false";
            };
            class VMF_firefightSounds: Edit {
                property = "VMF_firefightSounds";
                displayName ="Firefight Sounds";
                tooltip = "Array of firefight sounds that can be played. Sounds must be defined in CfgSounds";
                defaultValue = ""["BattlefieldFirefight1_3D","BattlefieldFirefight2_3D","BattlefieldFirefight3_3D","BattlefieldFirefight4_3D","",""]"";
            };
            class VMF_explosionSounds: Edit {
                property = "VMF_explosionSounds";
                displayName ="Explosion Sounds";
                tooltip = "Array of explsions sounds that can be played. Sounds must be defined in CfgSounds";
                defaultValue = ""["BattlefieldExplosions1_3D","BattlefieldExplosions2_3D","BattlefieldExplosions3_3D","BattlefieldExplosions4_3D","BattlefieldExplosions5_3D","","","","",""]"";
            };
            class VMF_aircraftSounds: Edit {
                property = "VMF_aircraftSounds";
                displayName ="Aircraft Sounds";
                tooltip = "Array of aircraft sounds that can be played. Sounds must be defined in CfgSounds";
                defaultValue = ""["BattlefieldHeli1_3D","BattlefieldHeli2_3D","BattlefieldHeli3_3D","BattlefieldJet1_3D","BattlefieldJet2_3D","BattlefieldJet3_3D","","","","","",""]"";
            };
            */
        

        class ModuleDescription: ModuleDescription {
            description[] = {
                "Initialises the Void Mission Framework",
                "Individual features can be enabled and disabled in the module attributes"
            };
        };
    };
};
