private ["_abort","_nearest","_bc"];

_nearest = _this select 0;
_abort = false;
_bc = [];
{ 
	if(count _x > 0) then  { 
		if((_x select 0) == _nearest) exitWith { 
			_bc = (_x select 1); 
			_abort = true;
		}; 
	}; 
	if(_abort) exitWith {};
} forEach SGA_rt_rings_inuse; 

_bc

