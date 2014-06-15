private ["_nearrings","_Rgetin","_c","_x","_bc","_getinaction","_checkGetInAction","_checkTeleportActions","_actions","_Rteleport","_ring","_roff","_name","_value"];


_getinaction = -1;
_checkGetInAction = false;
_checkTeleportActions = false;
_actions = [];
_Rgetin = objNull;
_Rteleport = objNull;
_nearrings = [];
_ring = "";
_bc = [];
_bc2 = [];


while { true } do {
	sleep (0.5 + random 0.3);
	if(_checkGetInAction || _checkTeleportActions) then {
		if(_checkGetInAction) then {
			if( (player distance _Rgetin > 4) || (count units group player < 2)) then {
				player removeaction _getinaction;
				_checkGetInAction = false;
			};
		};
		if(_checkTeleportActions) then {
			
			_roff = _Rteleport modelToWorld [0,0,0];
			if(_Rteleport iskindof "sga_ringtransporter_rings_notOnGround") then {
				_roff = _Rteleport modelToWorld [((_Rteleport animationPhase "anim_y") - 0.5) * 4, ((_Rteleport animationPhase "anim_y") - 0.5) * 4, 0];
			};
			if( (player distance _roff > 1.7) || (_Rteleport in SGA_rt_rings_inuse)) then {
				{
					player removeaction _x;
				} forEach _actions;
				_checkTeleportActions = false;
			};
		};
	};
	_nearrings = nearestObjects[player, ["sga_ringtransporter_rings_basic"], 4];
	if(count _nearrings == 1) then {
		_ring = (_nearrings select 0);
		if(!_checkGetInAction || !_checkTeleportActions) then {
			if(!_checkGetInAction) then {
				if(_ring in SGA_rt_rings_array) then {
					if( ((getpos _ring select 2) < 0.2) && (player distance _ring < 4) && (leader player == player) && (count units group player > 1) ) then {
						if(!(_ring iskindof "sga_ringtransporter_rings_onAircrafts")) then {
							_getinaction = player addaction [localize "STR_SGA_RT_AITORINGS", sga_ringtransporter_fnc_AIgetin,[_ring,group player], 111, false, false];
						};
						_checkGetInAction = true;
						_Rgetin = _ring;
					};
				};
			};
			if(!_checkTeleportActions) then {
			
				_roff = _ring modelToWorld [0,0,0];
				if(_ring iskindof "sga_ringtransporter_rings_notOnGround") then {
					_roff = _ring modelToWorld [((_ring animationPhase "anim_y") - 0.5) * 4, ((_ring animationPhase "anim_y") - 0.5) * 4, 0];
				};

				if ( (player distance _roff < 1.7) && (_ring in SGA_rt_rings_array) && !SGA_rt_player_IsUsingRings && !(_ring in SGA_rt_rings_inuse) ) then {

						_bc = [_ring] call sga_ringtransporter_fnc_ringReqInUse; 
						_c = 0;
						if(!(_ring iskindof "sga_ringtransporter_rings_onAircrafts")) then {
							{
								_value = true;
								
								if(_x iskindof "sga_ringtransporter_rings_onAircrafts") then {
									private["_query","_dup"];
									_query = getText(configFile >> "sga_ringtransporter_events" >> (typeof _x) >> "query");
									_dup = getText(configFile >> "sga_ringtransporter_events" >> (typeof _x) >> "DistanceUp");
									if( ([_x] call compile _query) distance _ring > (call compile _dup) ) then {
										_value = false;
									};
								};
								if(_value) then {
									_c = _c + 1;
									if((_ring != _x) && !(_x in _bc)) then { 
										
										_name = [_x,_c] call sga_ringtransporter_fnc_getRingName;
										_actions = [];
										_actions = _actions + [player addaction [_name, sga_ringtransporter_fnc_teleport, [_ring, _x, false]]];
									};
								};
							} forEach SGA_rt_rings_array;
						};
					_checkTeleportActions = true;
					_Rteleport = _ring;
				};
			};
		};
	};
};
{
	player removeAction _x;
} forEach _actions;
player removeAction _getinaction;
[] spawn sga_ringtransporter_fnc_playerActions;
true