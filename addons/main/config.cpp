#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {"VMF_frameworkSettings"};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main"};
        author = "Scofer";
        VERSION_CONFIG;
    };
};

#include "CfgVehicles.hpp"

class CfgFactionClasses {
    class NO_CATEGORY;
    class VMF_modules: NO_CATEGORY {
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
