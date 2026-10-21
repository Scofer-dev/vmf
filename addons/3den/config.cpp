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

/*
class CfgFunctions {
    class VMF {
        class createFile {
            PATHTO_FNCFOLDER(initGenerateDisplay);
            PATHTO_FNCFOLDER(createArsenalArrayFile);
        };
    };
};
*/

#include "Cfg3DEN.hpp"
#include "CfgEventHandlers.hpp"

/*
#include "generateFiles.h"

class ctrlMenuStrip;
class Display3DEN {
    class Controls {
        class MenuStrip: ctrlMenuStrip {
            class Items {
                class Tools {
                    items[] += {"VMF_generateFiles"};
                    requiredAddons[] = {"3DEN"};
                };
                class VMF_generateFiles {
                    text = "Generate Mission Files";
                    action = "if (missionName isEqualTo '') then {['Can only generate mission files in a saved mission folder',1] call BIS_fnc_3DENNotification;} else {[] call VMF_fnc_initGenerateDisplay;}";
                    opensNewWindow = 1;
                };
            };
        };
    };
};
*/