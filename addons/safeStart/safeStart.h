class VMF_safeStart {
    idd = -1;
    fadeIn = 0;
    fadeOut = 0;
    duration = 1e+011;
    movingEnable = 0;
    
    class Controls {
        class background {
            type = 0;
            idc = -1;
            x = safeZoneX;
            y = safeZoneY + safeZoneH - (safeZoneH * 0.03819445);
            w = safeZoneW * 0.11914063;
            h = safeZoneH * 0.03819445;
            style = 2 + 80;
            text = "Safe Start Active";
            colorBackground[] = {0.302,0.502,0.302,1};
            colorText[] = {0,0,0,1};
            font = "PuristaMedium";
            sizeEx = safeZoneH * 0.028;
            onLoad = "uiNamespace setVariable ['VMF_safeStart',_this select 0];";
        };
    };
};
