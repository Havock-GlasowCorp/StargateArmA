private["_ring", "_x","_array","_xoff","_yoff","_objpos","_ringpos","_xo","_yo"];
_array = (_this select 0);
_ring = (_this select 1);
_ringpos = _ring;
if(typeName _ring == "OBJECT") then {
	_ringpos = [_ring, 0] call sga_ringtransporter_fnc_fn_26;
};

{
	_objpos = _x modelToWorld [0,0,0];

	if((_objpos select 2) < ((_ringpos select 2) - 3 ) || (_objpos select 2) > ((_ringpos select 2) + 3)) then {
		_array = _array - [_x];
	} else {
		_xoff = (_objpos select 0) - (_ringpos select 0);
		_yoff = (_objpos select 1) - (_ringpos select 1);
		if((abs _xoff) > 1.7 || (abs _yoff) > 1.7) then {
			_array = _array - [_x];
		};
	};
} foreach _array; 
_array
