private ["_who","_SG_rings_invalidData","_arguments","_ringin","_ringout",
"_Sg_rings_transport_IsOtherMultiplayerClient","_tmp","_x"];

_SG_rings_invalidData = false;

_who = _this select 0;
_arguments = [];

if(typeName _who == "ARRAY") then { 
	_arguments = _who; 
} else { 
	if(typeName _who == "OBJECT") then { 
		_arguments = _this select 3;
	} else { 
		diag_log "Stargate Rings: UNKNOWN DATA received, rejecting ..."; 
		_SG_rings_invalidData = true;
	}; 
};
if(_SG_rings_invalidData) exitWith {true};


_ringin = _arguments select 0;
_ringout = _arguments select 1;
_Sg_rings_transport_IsOtherMultiplayerClient = _arguments select 2;

if( !(_ringin in SGA_rt_rings_array) || !(_ringout in SGA_rt_rings_array) ) then { 
	
	diag_log "Stargate Rings: INVALID DATA received, rejecting ...";
	_SG_rings_invalidData = true; 
};
if((_ringin in SGA_rt_rings_inuse) || (_ringout in SGA_rt_rings_inuse)) then {
	if !(_Sg_rings_transport_IsOtherMultiplayerClient) then {
		hint localize "STR_SGA_RT_TRNOTPOSSIBLE";
	};
	_SG_rings_invalidData = true;
};
if( typeName _who == "OBJECT") then { 
	if( _who == player && _who distance _ringin > 4) then {
		_SG_rings_invalidData = true; 
	};
};
if(_SG_rings_invalidData) exitWith {true};

// in use 
SGA_rt_rings_inuse set [count SGA_rt_rings_inuse, [_ringin, _ringout]];

if(isDedicated) then {
	
	_tmp = [_ringin, _ringout] call sga_ringtransporter_fnc_srv_begin;
	sleep 4.6;
	// wieder austragen aus inuse
	SGA_rt_rings_inuse = SGA_rt_rings_inuse - [_ringin, _ringout]];

} else {

	if (_Sg_rings_transport_IsOtherMultiplayerClient) then {
		_tmp = [_ringin, _ringout] call sga_ringtransporter_fnc_fn_16;
		sleep 2.4;	
	} else {
		_tmp = [_ringin, _ringout] call sga_ringtransporter_fnc_fn_15;	
	};
	sleep 1.0;
	
	// wieder austragen aus inuse
	SGA_rt_rings_inuse = SGA_rt_rings_inuse - [_ringin, _ringout]];	
	SGA_rt_rings_AI = false; // AI nimmer drinne
	
	sleep 3.0;
	if(_Sg_rings_transport_IsOtherMultiplayerClient) exitWith {true};
	SGA_rt_player_IsUsingRings = false; // spieler ist auch wieder raus
};

true