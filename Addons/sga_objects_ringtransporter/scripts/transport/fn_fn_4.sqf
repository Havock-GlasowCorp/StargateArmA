private["_ring","_unit","_ringcenter","_unitcenter","_xo","_yo"];
_ring = (_this select 0);
_unit = (_this select 1);
_ringcenter = _ring;
if(typeName _ring == "OBJECT") then {
	_ringcenter = [_ring, 0] call sga_ringtransporter_fnc_fn_26;
};
_unitcenter = getpos _unit;

[(_ringcenter select 0) - (_unitcenter select 0), (_ringcenter select 1) - (_unitcenter select 1), (_ringcenter select 2) - (_unitcenter select 2)]