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

    class GVARMAIN(frameworkSettings): Module_F {
        author = "Scofer";
        scope = 2;
        displayName = "Void Mission Framework";
        isGlobal = 0;   //Server execution
        category = QGVARMAIN(modules);
        icon = "";
        function = QFUNC(initFramework);
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
                title = "Enable Safe Start";
                tooltip = "Enable Safe Start, preventing players from taking and dealing damage until disabled";
                defaultValue = "true";
            };



            class VMF_medicalNotificationSubCat {
                property = "VMF_medicalNotificationSubCat";
                title = "ACE Medical Notification";
                control = "SubCategory";
            };
            class VMF_enableMedicalNotification: Checkbox {
                property = "VMF_enableMedicalNotification";
                title = "Enable ACE Medical Notifications";
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
                title = "Enable Group BFT";
                tooltip = "Enable Group BFT, showing the approximate location of friendly player groups";
                defaultValue = "true";
            };
            class VMF_groupBFTUpdateTimer: Edit {
                property = "VMF_groupBFTUpdateDelay";
                title = "Group BFT Update Delay";
                tooltip = "The delay in seconds between Group Marker position updates";
                defaultValue = "3";
                typeName = "NUMBER";
                validate = "number";
            };
            class VMF_groupBFTMarkerMaxUnitDistance: Edit {
                property = "VMF_groupMarkerMaxUnitDistance";
                title = "Group Marker Max Unit Distance";
                tooltip = "The maximum distance a unit can be from its group leader for its position to be counted for the group marker position";
                defaultValue = "100";
                typeName = "NUMBER";
                validate = "number";
            };
            class VMF_groupBFTFriendSideMarkers: Checkbox {
                property = "VMF_groupBFTFriendSideMarkers";
                title = "Friendly Side Markers";
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
                title = "Enable Team BFT";
                tooltip = "Enable Team BFT, showing the location of units in the same group";
                defaultValue = "true";
            };
            class VMF_teamBFTUpdateDelay: Edit {
                property = "VMF_teamBFTUpdateDelay";
                title = "Team BFT Update Delay";
                tooltip = "The delay in seconds between Team Marker position updates";
                defaultValue = "3";
                typeName = "NUMBER";
                validate = "number";
            };







            class ModuleDescription: ModuleDescription{};
        };

        class ModuleDescription: ModuleDescription {
            description[] = {
                "Initialises the Void Mission Framework",
                "Individual features can be enabled and disabled in the module attributes"
            };
        };
    };
};
