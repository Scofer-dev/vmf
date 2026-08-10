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

    class GVARMAIN(frameworkSettings): Module_F {
        author = "Scofer";
        scope = 2;
        displayName = "Void Mission Framework";
        isGlobal = 0;   //Server execution
        category = QGVARMAIN(modules);
        icon = "";
        function = QFUNC(initFramework);
        functionPriority = 0;
        isTriggerActivated = 0;
        isDisposable = 1;

        class Attributes: AttributesBase {
            class VMF_safeStartSubCat {
                property = "VMF_safeStartSubCat";
                title = "Safe Start";
                control = "SubCategory";
            };

            class VMF_enableSafeStart: Checkbox {
                property = "VMF_enableSafeStart";
                title "Enable Safe Start";
                tooltip = "Enable Safe Start, preventing players from taking and dealing damage until disabled"
            };




            class ModuleDescription: ModuleDescription{};
        };

        class ModuleDescription: ModuleDescription {
            description[] = {
                "Initialises the Void Mission Framework",
                "Individual features can be enabled and disabled in the module attributes"
            };
        };
    };
};