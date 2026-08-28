class Extended_InitPost_EventHandlers {
    class CAManBase {
        class ADDON {
            init = QUOTE((_this select 0) assignTeam (_this select 0 getVariable ['VMF_teamColour','MAIN']));
        };
    };
};

class Extended_PreInit_EventHandlers {
	class ADDON {
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
	};
};
