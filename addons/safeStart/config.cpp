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

#include "CfgEventHandlers.hpp"

class CfgFunctions {
    class VMF {
        class safeStart {
            PATHTO_FNCFOLDER(safeStartInit);
        };
    };
};

class RscTitles {
    #include "safeStart.h"
};
