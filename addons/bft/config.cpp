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

#include "CfgEventHandlers.hpp"

class CfgFunctions {
    class VMF {
        class groupBFT {
            PATHTO_FNCFOLDER(groupMarkers);
            PATHTO_FNCFOLDER(groupMarkersDisable);
            PATHTO_FNCFOLDER(groupMarkersVehicleType);
        };
        class teamBFT {
            PATHTO_FNCFOLDER(teamMarkers);
            PATHTO_FNCFOLDER(teamMarkersDisable);
            PATHTO_FNCFOLDER(teamMarkersColour);
        };
    };
};
