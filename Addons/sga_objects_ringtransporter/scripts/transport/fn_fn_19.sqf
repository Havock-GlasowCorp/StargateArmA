[(_this select 0)] spawn {

	private ["_ring","_objlist","_x","_vel"];

	_ring = (_this select 0);
	sleep 1.0;

	_objlist  = nearestObjects [_ring, ["ALL"], 4];
	_objlist = [_objlist] call sga_ringtransporter_fnc_fn_11;

	sleep 0.6;

	{

		if(local _x && !(_x iskindof "Man")) then {
			_vel = velocity _x;
			_vel set [2, (_vel select 2) + 0.7];
			_x setVelocity _vel;
		};
	} foreach _objlist;

};

true




	
