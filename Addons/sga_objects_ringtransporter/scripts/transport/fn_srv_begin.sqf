private ["_ringin","_ringout","_manlist_a","_manlist_b","_listofAIs"];

_ringin  = (_this select 0);
_ringout = (_this select 1);

[_ringin] call sga_ringtransporter_fnc_fn_19;
[_ringout] call sga_ringtransporter_fnc_fn_19;

sleep 3.10;

_manlist_a = [_ringin] call sga_ringtransporter_fnc_fn_21;
_manlist_b = [_ringout] call sga_ringtransporter_fnc_fn_21; 


sleep 0.50;

_listofAIs = [_ringin, _ringout, _manlist_a, _manlist_b] call sga_ringtransporter_fnc_fn_20; 

sleep 3;

[_ringin, _ringout, _manlist_a, _manlist_b] call sga_ringtransporter_fnc_fn_24;

[_listofAIs,_ringin,_ringout] call sga_ringtransporter_fnc_fn_23;

true