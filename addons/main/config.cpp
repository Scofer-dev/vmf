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

class CfgFactionClasses {
    class NO_CATEGORY;
    class VMF_modules: NO_CATEGORY {
        displayName = "Void Mission Framework";
    };
};

#include "CfgEventHandlers.hpp"

class CfgFunctions {
    class VMF {
        class main {
            PATHTO_FNCFOLDER(curatorInitModule);
        };
    };
};