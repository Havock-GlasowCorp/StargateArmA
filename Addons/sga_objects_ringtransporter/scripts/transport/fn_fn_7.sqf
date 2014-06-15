

_this spawn {

private["_in","_out","_group","_x","_c","_i","_list","_inpos","_done"];

_in = (_this select 0);
_inpos = [_in, 0] call sga_ringtransporter_fnc_fn_26;
_out = (_this select 1);
_group = (_this select 2);
//_group LockWP True;
_list = (units _group) - [leader _group];
{
	if(!local _x || !alive _x || ((_in distance _x) > (_out distance _x)) || !(unitReady _x) || !(vehicle _x == _x)) then {
		_list = _list - [_x];
	} else {
		dostop _x;
	};
} foreach _list;

_i = 0;
while { count _list > _i } do {
	sleep 3;
	_c = [];
	{
		if(count _list > _x) then { _c = _c + [_list select _x]; };
	} foreach [_i,_i+1];
	_done = false;
	while { {(_x distance _inpos) > 1.7 } count _c > 0 } do {
		{
			if(alive _x) then {
				if(!_done || !(unitReady _x)) then {
					if(_in iskindof "sga_ringtransporter_rings_notOnGround") then {
						[_x, _in] call compile (getText(configFile >> "sga_ringtransporter_events" >> (typeof _in) >> "AiToRing"));
					} else {
						_x domove (getPos _in);
					};
				};
			} else { _c = _c - [_x]; };			
		} foreach _c;
		_done = true;
		sleep 1;
	};
	if(count _c > 0) then {
		sleep 1;
		{ _x disableAI "MOVE"; } foreach _c;
		waitUntil { (leader _group) distance _out > 2.5 };
		waitUntil { !SGA_rt_rings_AI };
		waitUntil { !(_in in SGA_rt_rings_inuse) && !(_out in SGA_rt_rings_inuse) };
		sleep 1;
		[[_in,_out,false]] spawn sga_ringtransporter_fnc_teleport;
	};
	_i = _i + 2;
};
true

};
true



