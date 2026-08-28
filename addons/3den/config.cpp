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
        class createFile {
            PATHTO_FNCFOLDER(createArsenalArrayFile);
        };
    };
};

#include "Cfg3DEN.hpp"
#include "CfgEventHandlers.hpp"
