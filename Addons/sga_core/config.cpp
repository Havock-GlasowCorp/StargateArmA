class CfgMods
{
    class SGA_Mod
    {
        dir = "@Stargate";
        name = "Stargate ArmA";
	picture = "\sga_ui\images\logo-icon-64.paa";
        hidePicture = "true";
        hideName = "true";
        actionName = "Website";
        action = "http://www.stargatearma.com";
        description = "Stargate Mod for ArmA 3";
    };
};

class CfgPatches
{
    class SGA_Code
    {
        units[] = {};
        weapons[] = {};
        requiredVersion = 0.1;
        requiredAddons[] = {"extended_eventhandlers","sga_ui"};
        author[] = {"Stargate ArmA"};
        version = "0.001";
        authorUrl = "http://www.stargatearma.com";
    };
};

class CfgFunctions
{
	class sga_core
	{
		tag = "sga_core";
		
		class sga_core
		{
			file = "\sga_core\functions";
			class init;
			class debug;
			class log;
		};
	};
};

class Extended_PostInit_EventHandlers
{
	class sga_core
	{
		Init="[] spawn sga_core_fnc_init;";
	};
};