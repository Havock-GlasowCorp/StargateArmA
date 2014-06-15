private["_x","_array"];
_array = (_this select 0);
{
	if([_x] call sga_ringtransporter_fnc_reqIsBlacklisted) then {
		_array = _array - [_x];
	};
} foreach _array; 
_array