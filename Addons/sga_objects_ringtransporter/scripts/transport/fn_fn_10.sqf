private ["_in","_out","_timeToLive","_wei","_vol","_x"];

_this spawn {
	_in = [_this select 0, 2] call sga_ringtransporter_fnc_fn_26;
	_out = [_this select 1, 2] call sga_ringtransporter_fnc_fn_26;
	_timeToLive = 1.6;
	_wei = 2;
	_vol = 1.0;
	
	sleep 0.1;
	
	//for [{_x=1},{_x<=14},{_x=_x+1}] do {
		//drop ["\pump_sg_rings_a3\kouleSvetlo","","Billboard",1,_timeToLive,_in,[0,0,0],0,_wei,_vol,0,[6], [[255,255,255,1]],[0],1,0,"","",""];
		//drop ["\pump_sg_rings_a3\kouleSvetlo","","Billboard",1,_timeToLive,_out,[0,0,0],0,_wei,_vol,0,[6], [[255,255,255,1]],[0],1,0,"","",""];
	//};
	true
};

true