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
        class groupBFT {
            PATHTO_FNCFOLDER(groupBftInit);
            PATHTO_FNCFOLDER(groupBftDisable);
            PATHTO_FNCFOLDER(groupBftVehicleType);
        };
        class teamBFT {
            PATHTO_FNCFOLDER(teamBftInit);
            PATHTO_FNCFOLDER(teamBftDisable);
            PATHTO_FNCFOLDER(teamBftColour);
        };
    };
};
