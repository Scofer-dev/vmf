#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {"VMF_missionStart"};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"VMF_main","zen_main"};
        author = "Scofer";
        VERSION_CONFIG;
    };
};

#include "CfgVehicles.hpp"

class CfgFunctions {
    class VMF {
        class safeStart {
            PATHTO_FNCFOLDER(safeStartInit);
        };
        class missionStart {
            PATHTO_FNCFOLDER(missionStartDialog);
            PATHTO_FNCFOLDER(missionStart);
        };
    };
};

class RscTitles {
    #include "safeStart.h"
};
