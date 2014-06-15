private ["_obj","_out","_x"];
_obj = _this select 0;
_out = false;
{
	if(_obj isKindof _x) exitWith { _out = true; };
} forEach SGA_rt_blacklist;
_out;