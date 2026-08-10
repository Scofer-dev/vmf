#include "script_component.hpp"

class CfgVehicles {
	class Logic;
	class Module_F: Logic
    {
        class AttributesBase
        {
            class Default;
            class Edit; // Default edit box (i.e., text input field)
            class Combo; // Default combo box (i.e., drop-down menu)
            class CheckBox; // Tickbox, returns true/false
            class CheckBoxNumber; // Tickbox, returns 1/0
            class ModuleDescription; // Module description
        };
        class ModuleDescription
        {
            class Anything;
        };
    };

    class GVARMAIN(safeStart): Module_F {
        author = "Scofer";
        scope = 2;
        displayName = "Safe Start";
        isGlobal = 2;   //Persistent global execution
        category = QGVARMAIN(modules);
        icon = "";
        function = QFUNC(safeStartInit);
        functionPriority = 0;
        isTriggerActivated = 0;
        isDisposable = 1;

        class Attributes: AttributesBase {
            class ModuleDescription: ModuleDescription{};
        };

        class ModuleDescription: ModuleDescription {
            description[] = {
                "Activates Safe Start at the start of the mission.",
                "Safe Start can be deactivated by using the Mission Live Zeus module or by otherwise calling VMF_fnc_missionLive on the server."
            };
        };
    };


    class GVAR(missionLive): Module_F {
        author = "Scofer";
        scope = 1;
        scopeCurator = 2;
        displayName = "Mission Live";
        isGlobal = 0;
        category = QGVARMAIN(modules);
        icon = "";
        function = QFUNC(missionLiveDialog);
        functionPriority = 1;
        class eventHandlers {
            init = _this call vmf_fnc_curatorInitModule;
        };
    };
};
