private ["_ring", "_ringpos", "_manlist"];

_ring = (_this select 0);
_ringpos = [0,0,0];
if(typeName _ring == "OBJECT") then {	
	_ringpos = [_ring, 0] call sga_ringtransporter_fnc_fn_26;
};
if(typeName _ring == "ARRAY") then {
	_ringpos = _ring;
};

_manlist = _ringpos nearObjects 3;
_manlist = [_manlist] call sga_ringtransporter_fnc_fn_11; 
_manlist = [_manlist,_ring] call sga_ringtransporter_fnc_fn_22;

_manlist