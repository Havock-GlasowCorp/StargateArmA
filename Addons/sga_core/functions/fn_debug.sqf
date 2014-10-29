/**
* fn_debug.sqf
* @Descr: Debug Function
* @Author: Insane
*
* @Arguments: [string, (identifier)]
* @Returns: nothing
* @Example: ["error43"] spawn sga_core_fnc_debug; ["error43-1", "Vehicle Init"] spawn sga_core_fnc_debug;
*/

if !sga_debug exitWith {};

_arg = [_this, 0, ""] call BIS_fnc_param;
_scriptname = [_this, 1, ""] call BIS_fnc_param;

[format["[SGA DEBUG] %3 %2 >> %1",_arg,_scriptname,time]] spawn sga_core_fnc_log; 