private["_ring","_out","_class","_entry","_array","_i","_x","_obj"];
_ring = _this select 0;
_number = _this select 1;
_out = format[localize "STR_SGA_RT_TELEPORTTO", _number];

_class = (missionConfigFile >> "sga_ringtransporter_table");
if(isClass _class) then {
	_entry = (_class >> "rings");
	if(isArray _entry) then {
		_array = getArray _entry;
		_i = count _array;
		if(_i % 2 == 0) then {
			for [{_x=0},{_x < (_i - 1)},{_x=_x+2}] do {
				_obj = call compile (_array select _x);
				if(_obj == _ring) exitWith {				
					_out = format[localize "STR_SGA_RT_TELEPORTTO", (_array select (_x + 1))];
				};
			};
		};
	};
};

_out