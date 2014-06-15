private ["_ringin","_ringout","_manlist_a","_manlist_b","_x","_difference","_listAofAIs","_listBofAIs"];

_ringin = _this select 0;
_ringout = _this select 1;

_manlist_a = _this select 2;
_manlist_b = _this select 3;
_listAofAIs = [];
_listBofAIs = [];

{ 
	if(local _x) then {
		_difference = [_ringin,  _x] call sga_ringtransporter_fnc_fn_4; 
		[_ringout, _x, _difference]  call sga_ringtransporter_fnc_fn_5;

		if(_x iskindOf "Man") then {
			_listAofAIs = _listAofAIs + [[_x, _ringin, _ringout] call sga_ringtransporter_fnc_fn_6]; 
		};
	};
} forEach _manlist_a;
{ 
	if(local _x) then {
		_difference = [_ringout, _x] call sga_ringtransporter_fnc_fn_4;
		[_ringin,  _x, _difference]  call sga_ringtransporter_fnc_fn_5;	

		if(_x iskindOf "Man") then {
			_listBofAIs = _listBofAIs + [[_x, _ringout, _ringin] call sga_ringtransporter_fnc_fn_6];
		};
	};
} forEach _manlist_b;

[_listAofAIs, _listBofAIs]