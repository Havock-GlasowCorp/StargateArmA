private["_l","_x","_r"];

{
	_l = _x select 0;
	_r = _x select 1;
	if(typeName _r == "OBJECT" && typeName _l == "ARRAY") then { 
		if(_r iskindof "sga_ringtransporter_rings_notOnGround") then {
			[_l,_r] call compile (getText(configFile >> "sga_ringtransporter_events" >> (typeof _r) >> "AiFromRing"));
		} else {
			private["_x","_t"];
			{
				_t = typeName _x;
				if(_t == "OBJECT" && _t != "BOOL") then {
					_x enableAI "MOVE";
					_x dofollow (leader group _x); 
				};
			} forEach _l;
		};
	};
} forEach [[(_this select 0) select 0,(_this select 2)],[(_this select 0) select 1,(_this select 1)]];

true