private ["_ringin","_ringout","_manlist_a","_manlist_b","_argh","_listofAIs"];

_ringin  = (_this select 0);
_ringout = (_this select 1);

[_ringin] call sga_ringtransporter_fnc_fn_19;
[_ringout] call sga_ringtransporter_fnc_fn_19;

sleep 2;

[_ringin, _ringout] call sga_ringtransporter_fnc_fn_12;

sleep 1.10;

_manlist_a = [_ringin] call sga_ringtransporter_fnc_fn_21;
_manlist_b = [_ringout] call sga_ringtransporter_fnc_fn_21;

if((player in _manlist_a) || (player in _manlist_b)) then { 
	call sga_ringtransporter_fnc_fn_9;
};

[_ringin, _ringout] call sga_ringtransporter_fnc_fn_10;

sleep 0.50;

_listofAis = [_ringin, _ringout, _manlist_a, _manlist_b] call sga_ringtransporter_fnc_fn_20;

sleep 3;

[_ringin, _ringout, _manlist_a, _manlist_b] call sga_ringtransporter_fnc_fn_24;

[_listofAIs,_ringin,_ringout] call sga_ringtransporter_fnc_fn_23;

true