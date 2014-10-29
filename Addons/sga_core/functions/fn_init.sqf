/**
* fn_init.sqf
* @Descr: -
* @Author: Insane
*/

[] call compile PreprocessFileLineNumbers "\sga_core\config\common.sqf";

["sga_core loaded", _fnc_scriptName] spawn sga_core_fnc_debug;
