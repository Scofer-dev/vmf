#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_main"
        };
        author = "Scofer";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"

class CfgFactionClasses {
    class NO_CATEGORY;
    class GVARMAIN(modules): NO_CATEGORY {
        displayName = "VMF";
    };
};

class CfgFunctions {
    class VMF {
        class main {
            PATHTO_FNCFOLDER(initFramework);
        };
        class curator {
            PATHTO_FNCFOLDER(curatorInitModule);
        };
    };
};
