#include "..\script_component.hpp"
class GVAR(missionStart): Module_F {
	author = "Scofer";
	scope = 1;
	scopeCurator = 2;
	displayName = "Mission Start";
	isGlobal = 0;
	category = "VMF_modules";
	icon = "";
	function = QFUNC(missionStartDialog);
	functionPriority = 1;
	class eventHandlers {
		init = _this call EFUNC(main,curatorInitModule);
	};
};
