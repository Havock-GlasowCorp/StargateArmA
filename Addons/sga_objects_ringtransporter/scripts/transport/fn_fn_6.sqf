private["_unit", "_in", "_out", "_ai","_currPos"];

_unit = (_this select 0);
_in = (_this select 1);
_out = (_this select 2);
_output = true;

if(leader group _unit == _unit && (count units group _unit) > 1) then { 
	[_in, _out, group _unit] call sga_ringtransporter_fnc_fn_7;
	if(!isPlayer _unit) then {
		_currPos = getpos _unit;
		_currPos set [0, (_currPos select 0) + (30 * sin (getdir _unit))];
		_currPos set [1, (_currPos select 1) + (30 * cos (getdir _unit))];
		sleep 3;
		
		if(_out iskindof "sga_ringtransporter_rings_notOnGround") then {
			[_unit, _out] call compile (getText(configFile >> "sga_ringtransporter_events" >> (typeof _out) >> "AiLeaderFromRing"));
		} else {
			_unit doMove _currPos;
		};
	};
} else { 
	if(!isPlayer _unit) then {
		_output = _unit;
	};
};

_output
