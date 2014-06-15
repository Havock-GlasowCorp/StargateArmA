private["_manlist_a","_manlist_b","_ringin","_ringout","_x"];
_ringin = _this select 0;
_ringout = _this select 1;
_manlist_a = _this select 2;
_manlist_b = _this select 3;

{
	if((_x select 0)  iskindof "sga_ringtransporter_rings_notOnGround" && player in (_x select 1) && !isNull player) then {
		[_x select 0] call compile (getText(configFile >> "sga_ringtransporter_events" >> (typeof (_x select 0)) >> "afterEvent"));
	};
} forEach [[_ringin, _manlist_b],[_ringout, _manlist_a]];

true