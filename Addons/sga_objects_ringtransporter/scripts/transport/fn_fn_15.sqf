private ["_ringin","_ringout","_manlist_a","_manlist_b","_x","_difference","_realposin","_realposout","_listofAis"];

_ringin  = (_this select 0);
_ringout = (_this select 1);


SGA_rt_player_IsUsingRings = true;
if(call sga_ringtransporter_fnc_reqPlayersOnline) then { 
	sga_ringtransporter_mp_NewTransport = [[_ringin, _ringout]]; 
	publicvariable "sga_ringtransporter_mp_NewTransport";
};

[_ringin] call sga_ringtransporter_fnc_fn_19;
[_ringout] call sga_ringtransporter_fnc_fn_19;
sleep 0.8;

if(_ringin iskindof "sga_ringtransporter_rings_goauld") then {
	_ringin animate ["anim_dropring", 1];
	_ringin say "sga_ringtransporter_rings_dropring";
};
if(_ringout iskindof "sga_ringtransporter_rings_ori") then {
	_ringout animate ["anim_dropring", 1];
	_ringout say "sga_ringtransporter_rings_dropring";
};


sleep 1.2;

[_ringin, _ringout] call sga_ringtransporter_fnc_fn_12;
_ringin   animate ["anim_c1", 1];
_ringout  animate ["anim_c1", 1];
sleep 0.30;

_ringin   animate ["anim_c2", 1];
_ringout  animate ["anim_c2", 1];

sleep 0.30;

_ringin   animate ["anim_c3", 1];
_ringout  animate ["anim_c3", 1];

sleep 0.30;

_ringin   animate ["anim_c4", 1];
_ringout  animate ["anim_c4", 1];

sleep 0.20;
	
_ringin   animate ["anim_c5", 1];
_ringout  animate ["anim_c5", 1];

_manlist_a = [_ringin] call sga_ringtransporter_fnc_fn_21;
_manlist_b = [_ringout] call sga_ringtransporter_fnc_fn_21;
if((player in _manlist_a) || (player in _manlist_b)) then { 
	call sga_ringtransporter_fnc_fn_9;
};

[_ringin, _ringout] call sga_ringtransporter_fnc_fn_10;

sleep 0.50;

_listofAis = [_ringin, _ringout, _manlist_a, _manlist_b] call sga_ringtransporter_fnc_fn_20;

_ringin animate["anim_e1",0];
_ringin animate["anim_e2",0];
_ringin animate["anim_e3",0];
_ringout animate["anim_e1",0];
_ringout animate["anim_e2",0];
_ringout animate["anim_e3",0];

_ringin  animate ["anim_stredy1",0];
_ringin  animate ["anim_stredy2",0];
_ringin  animate ["anim_stredy3",0];
_ringin  animate ["anim_stredy4",0];
_ringin  animate ["anim_stredy5",0];
_ringout animate ["anim_stredy1",0];
_ringout animate ["anim_stredy2",0];
_ringout animate ["anim_stredy3",0];
_ringout animate ["anim_stredy4",0];
_ringout animate ["anim_stredy5",0];

sleep 0.10;

_ringin animate["anim_e4",0];
_ringout animate["anim_e4",0];

sleep 0.10;

_ringin animate["anim_e5",0];
_ringout animate["anim_e5",0];


sleep 0.20;

_ringin animate["anim_e1",1];
_ringout animate["anim_e1",1];

sleep 0.20;

_ringin animate["anim_e2",1];
_ringout animate["anim_e2",1];

sleep 0.20;

_ringin animate["anim_e3",1];
_ringout animate["anim_e3",1];

sleep 0.20;

_ringin animate["anim_e4",1];
_ringout animate["anim_e4",1];


sleep 0.20;

_ringin animate["anim_e5",1];
_ringout animate["anim_e5",1];

sleep 0.20;

_ringin  animate ["anim_c5",0];
_ringout animate ["anim_c5",0];

sleep 0.30;
_ringin  animate ["anim_c4",0];
_ringout animate ["anim_c4",0];

sleep 0.30;
_ringin  animate ["anim_c3",0];
_ringout animate ["anim_c3",0];

sleep 0.30;

_ringin  animate ["anim_c2",0];
_ringout animate ["anim_c2",0];

sleep 0.30;

_ringin  animate ["anim_c1",0];
_ringout animate ["anim_c1",0];

_ringin  animate ["anim_stredy1",1];
_ringin  animate ["anim_stredy2",1];
_ringin  animate ["anim_stredy3",1];
_ringin  animate ["anim_stredy4",1];
_ringin  animate ["anim_stredy5",1];
_ringout animate ["anim_stredy1",1];
_ringout animate ["anim_stredy2",1];
_ringout animate ["anim_stredy3",1];
_ringout animate ["anim_stredy4",1];
_ringout animate ["anim_stredy5",1];


if(_ringin iskindof "sga_ringtransporter_rings_ori") then {
	sleep 0.5;
	_ringin animate ["anim_dropring", 0];
	_ringin say "sga_ringtransporter_rings_dropring";
};
if(_ringout iskindof "sga_ringtransporter_rings_ori") then {
	sleep 0.5;
	_ringout animate ["anim_dropring", 0];
	_ringout say "sga_ringtransporter_rings_dropring";
};

sleep 0.4;



[_ringin, _ringout, _manlist_a, _manlist_b] call sga_ringtransporter_fnc_fn_24;

[_listofAis,_ringin,_ringout] call sga_ringtransporter_fnc_fn_23;

true