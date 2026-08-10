#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"VMF_main","zen_main"};
        author = "Scofer";
        VERSION_CONFIG;
    };
};

class CfgFunctions {
    class VMF {
        class safeStart {
            PATHTO_FNCFOLDER(safeStartInit);
            PATHTO_FNCFOLDER(missionLive);
        };
        class curator {
            PATHTO_FNCFOLDER(missionLiveDialog);
        };
    };
};

class RscTitles {
    #include "safeStart.h"
};


#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"