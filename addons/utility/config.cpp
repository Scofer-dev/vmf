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

class CfgFunctions {
    class VMF {
        class utility {
            PATHTO_FNCFOLDER(deleteVehicle);
            PATHTO_FNCFOLDER(crateParadrop);
            PATHTO_FNCFOLDER(playerParadrop);
            PATHTO_FNCFOLDER(playerParadropLocal);
        };
    };
};
