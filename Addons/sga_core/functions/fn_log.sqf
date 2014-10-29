/**
* fn_log.sqf
* @Descr: -
* @Author: Insane
*
* @Arguments: [any]
* @Returns: nothing
* @Example: ["lala error"] spawn sga_core_fnc_debug;
*/

_arg = [_this, 0, ""] call BIS_fnc_param;

diag_log format["%1", _arg];