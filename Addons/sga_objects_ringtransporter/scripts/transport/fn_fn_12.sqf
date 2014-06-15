private["_in","_out","_x"];
_in = (_this select 0);
_out = (_this select 1);
_in say "sga_ringtransporter_rings_sound";
_out say "sga_ringtransporter_rings_sound";

{
	if(_x iskindof "sga_ringtransporter_rings_notOnGround") then {
		[_x] call compile (getText(configFile >> "sga_ringtransporter_events" >> (typeof _x) >> "onEvent"));
	};
} foreach [_in, _out];
true