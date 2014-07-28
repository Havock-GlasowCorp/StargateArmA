/*
	File: btk_sg_fnc_dhdControlCrystal.sqf
	Author: BTK (btk@arma3.cc)

	Description:
	Take/install DHD control crystal.

	Parameter(s):
	0. DHD (OBJECT)
	1. Unit/Player executing the action (OBJECT)
	2. Action (ACTION)
	3. Parameter (Action) (ARRAY)

	Returns:
	Success (BOOLEAN)

	Syntax:
	[_dhd, player, _action, [_parameter]] spawn btk_sg_fnc_dhdControlCrystal;
*/


_object = _this select 0;
_unit = _this select 1;
_action = _this select 2;
_parameter = _this select 3;
_type = _parameter select 0;


if (!(local _unit)) exitWith {};


switch (_type) do {

	//--- Cancel (via action menu)
	case ("cancel") : {
	
		btk_sg_playerIsInteracting = nil;
		sleep 1;
		btk_sg_playerIsBusy = nil;

	};
	
	//--- Abort?
	case ("abort") : {
	
		player playActionNow "gestureGo";
		[[_object, "btk_sg_sound_dialing_button_1", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP;
	
		_object setVariable ["btk_sg_dhdIsDialing", nil, true];
		btk_sg_playerIsInteracting = nil;
		btk_sg_playerIsBusy = nil;
		
	};

	//--- Close an open wormhole
	case ("close") : {
	
		_remoteDHD =  _object getVariable "btk_sg_dhdIsConnectedTo";
	
		player playActionNow "gestureGo";
		[[_object, "btk_sg_sound_dialing_button_1", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP;
	
		_object setVariable ["btk_sg_dhdIsConnectedTo", nil, true];
		_object setVariable ["btk_sg_dhdIsConnected", nil, true];
		_object setVariable ["btk_sg_dhdIsDialing", nil, true];
		_remoteDHD setVariable ["btk_sg_dhdIsConnectedTo", nil, true];
		_remoteDHD setVariable ["btk_sg_dhdIsConnected", nil, true];
		_remoteDHD setVariable ["btk_sg_dhdIsDialing", nil, true];
		
		btk_sg_playerIsInteracting = nil;
		btk_sg_playerIsBusy = nil;
		
	};

};