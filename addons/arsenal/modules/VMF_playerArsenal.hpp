#include "..\script_component.hpp"
class GVARMAIN(playerArsenal): Module_F {
	author = "Scofer";
	scope = 2;
	displayName = "Player Arsenal";
	isGlobal = 2; //Makes it work with synchronised units that JIP?
	category = "VMF_modules";
	icon = "\a3\3den\data\displays\display3den\panelright\modeobjects_ca.paa";
	function = QFUNC(addPlayerArsenal);
	functionPriority = 1;
	isTriggerActivated = 1;
	isDisposable = 1;

	class Attributes: AttributesBase {
		class VMF_arsenalArrayFile: Edit {
			property = "VMF_arsenalArrayFile";
			displayName = "Arsenal Array File";
			tooltip = "The mission file that returns an array of all the items that will be in the arsenal.";
			typeName = "STRING";
			defaultValue = "arsenalArrays.sqf";
		};

		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription {
		sync[] = {"AnyPlayer"};
		description[] = {
			"Synchronise this module to players you want to have access to this arsenal.",
			"The arsenal file must be in the .sqf format, and must return an array of items.",
			"Arsneal will only be available to players when Safe Start is enabled."
		};
	};
};
