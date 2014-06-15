private["_height","_ring","_out","_xo","_yo"];	

_ring = _this select 0;
_height = _this select 1;
_out = _ring modelToWorld [0,0,_height];
if(_ring iskindof "sga_ringtransporter_rings_notOnGround") then {
	_xo = -((_ring animationPhase "anim_x") - 0.5) * 4;
	_yo = ((_ring animationPhase "anim_y") - 0.5) * 4;
	_out = _ring modelToWorld [_xo,_yo,_height];
};
_out