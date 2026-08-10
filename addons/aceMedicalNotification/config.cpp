#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"VMF_main"};
        author = "Scofer";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"

class CfgFunctions {
    class VMF {
        class aceMedicalNotification {
            PATHTO_FNCFOLDER(addMedicalEvent);
            PATHTO_FNCFOLDER(displayNotification);
        };
    };
};
