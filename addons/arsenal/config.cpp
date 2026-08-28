#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {"VMF_playerArsenal"};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"VMF_main"};
        author = "Scofer";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"

class CfgFunctions {
    class VMF {
        class arsenal {
            PATHTO_FNCFOLDER(addPlayerArsenal);
        };
    };
};
