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

    class VMF_missionStart: Module_F {
        author = "Scofer";
        scopeCurator = 2;
        displayName = "Mission Start";
        isGlobal = 0;   //Server execution
        category = "VMF_modules";
        icon = "\a3\3den\data\displays\display3den\panelright\modeobjects_ca.paa";
        function = "VMF_fnc_missionStartDialog";
        functionPriority = 1;
        class eventHandlers {
            init = _this call VMF_fnc_curatorInitModule;
        };
    };
};
