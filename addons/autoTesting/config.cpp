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
        class autoTesting {
            PATHTO_FNCFOLDER(aiCount);
            PATHTO_FNCFOLDER(aiCountDisplayUpdate);
            PATHTO_FNCFOLDER(aiCountInit);
            PATHTO_FNCFOLDER(autoTest);
            PATHTO_FNCFOLDER(autoTestUI);
            PATHTO_FNCFOLDER(babelTest);
            PATHTO_FNCFOLDER(dlcCheck);
            PATHTO_FNCFOLDER(moduleAttributeTest);
            PATHTO_FNCFOLDER(openTestWindow);
            PATHTO_FNCFOLDER(unitInventoryCheck);
            PATHTO_FNCFOLDER(updateResultsBox);
        };
    };
};

#include "UI\VMF_autoTest.h"
#include "UI\VMF_aiCount.h"

class ctrlMenuStrip;
class Display3DEN {
    class Controls {
        class MenuStrip: ctrlMenuStrip {
            class Items {
                class Tools{
                    items[] += {"VMF_autoTest"};
                    requiredAddons[] = {"3DEN"};
                };
                class VMF_autoTest {
                    text = "Auto Test";
                    action = "[] call VMF_fnc_openTestWindow;";
                    shortcuts[] = {512 + 17};
                    opensNewWindow = 1;
                };
            };
        };
    };
};
