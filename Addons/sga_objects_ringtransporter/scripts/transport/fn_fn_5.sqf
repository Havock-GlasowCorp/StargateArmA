private["_ring","_diff","_z","_unit","_ringpos","_offset"];

_ring = (_this select 0);
_unit = (_this select 1);
_diff = (_this select 2);

if(typeName _ring == "OBJECT") then {
	_offset = getNumber(configFile >> "CfgVehicles" >> typeof _ring >> "heightoffset");
	_ringpos = [_ring, 0] call sga_ringtransporter_fnc_fn_26;
	_z = (_ringpos select 2) - (_diff select 2);
	if(_ring iskindof "sga_ringtransporter_rings_notOnGround") then {
		_z = _offset max (_offset - (_diff select 2));
	};
	_unit setPos [(_ringpos select 0) - (_diff select 0), (_ringpos select 1) - (_diff select 1), _z];
};
if(typeName _ring == "ARRAY") then {
	_unit setPos [(_ring select 0) - (_diff select 0), (_ring select 1) -  (_diff select 1), (_ring select 2) - (_diff select 2)];
};


true 