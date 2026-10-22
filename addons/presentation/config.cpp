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
        class presentation {
            PATHTO_FNCFOLDER(battlefieldSounds);
            PATHTO_FNCFOLDER(widescreen);
            PATHTO_FNCFOLDER(fadeEffect);
            PATHTO_FNCFOLDER(subtitles);
            PATHTO_FNCFOLDER(showSubtitle);
        };
    };
};

class RscTitles {
    #include "ui\widescreen.h"
};
