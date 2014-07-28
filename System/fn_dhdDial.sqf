/*
	File: btk_sg_fnc_dhdDial.sqf
	Author: BTK (btk@arma3.cc)

	Description:
	Player dialing.

	Parameter(s):
	0. DHD (OBJECT)
	1. Unit/Player executing the action (OBJECT)
	2. Action (ACTION)
	3. Parameter (Action) (ARRAY)

	Returns:
	Success (BOOLEAN)

	Syntax:
	[_dhd, player, _action, [_parameter]] spawn btk_sg_fnc_dhdDial;
*/


private ["_object", "_unit", "_action", "_parameter", "_type", "_fromParameter", "_toParameter", "_fromDHD", "_toDHD"];


_debug = true;


// Parameter
_object = _this select 0;
_unit = _this select 1;
_action = _this select 2;
_parameter = _this select 3;
_type = _parameter select 0;
_fromParameter = _parameter select 1;
_toParameter = _parameter select 2;
_fromDHD = (_fromParameter select 0);
_toDHD = (_toParameter select 0);


// Variables
_isActualDHD = _object isKindOf "DSF_DHD"; // todo: adjust this file accordingly!
_playerPos = getPosATL _unit;
_canceled = false;
_index = 0;


// Only where caller is local
if (!(local _unit)) exitWith {};


if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=== btk_sg_fnc_dhdDial : Player is dialing..."]; };


if (!(isPlayer _unit)) then {
// send mtw bla...
};


// Tag
_object setVariable ["btk_sg_dhdIsDialing", true, true];
btk_sg_playerIsInteracting = true;
btk_sg_playerIsBusy = true;


// Actual DHD?
if (_isActualDHD) then {

	// Check, dial flow
	for "_j" from 1 to 7 do {
	
		// Abort check
		_playerDir = (getDir player);
		_dhdDir = (getDir _object);
		_turnedAway = if (((_playerDir > (_dhdDir + 60)) && (_playerDir < (_dhdDir + 300)))) then { true; } else { false; };
		_movedAway = if (((getPosATL player) distance _playerPos) > 1.1) then { true; } else { false; };
		_hasControlCrystal = if (isNil {_object getVariable "btk_sg_dhdControlCrystal"}) then { false; } else { true; };
		if ((isNil "btk_sg_playerIsInteracting") || !(alive _unit) || _turnedAway || _movedAway) exitWith { _canceled = true; };

		// Not canceled, next
		_index = _index + 1;

		// Press next button
		player playActionNow "gestureGo";
		sleep 0.2;
		
		// Pressing buttons 1-7
		switch (_index) do {
		
			// Buttons 1
			case (1): {
				[[_object, "btk_sg_sound_dialing_button_1", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP;
			};
			
			// Buttons 2
			case (2): { [[_object, "btk_sg_sound_dialing_button_2", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP; };
			
			// Start actual dialing with 3rd button
			case (3): {
			
				[[_object, "btk_sg_sound_dialing_button_3", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP;
				
				// Broadcasted dialing
				btk_sg_fnc_dialGlobalNow = [_fromDHD, _toDHD]; publicVariable "btk_sg_fnc_dialGlobalNow";
				[_fromDHD, _toDHD] spawn btk_sg_fnc_dialGlobal;
				
			};
			
			// Buttons 4
			case (4): { [[_object, "btk_sg_sound_dialing_button_4", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP; };
			
			// Buttons 5
			case (5): { [[_object, "btk_sg_sound_dialing_button_5", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP; };
			
			// Buttons 6
			case (6): { [[_object, "btk_sg_sound_dialing_button_6", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP; };
			
			// Buttons 7
			case (7): { [[_object, "btk_sg_sound_dialing_button_1", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP; };
			
		};
		
		sleep 1.5;

	};

	// DHD button
	player playActionNow "gestureGo";
	sleep 0.2;
	[[_object, "btk_sg_sound_dialing_button_3", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP;

} else {

	hint "custom dialing computer...!";
	sleep 3;
				
	// Broadcasted dialing
	btk_sg_fnc_dialGlobalNow = [_fromDHD, _toDHD]; publicVariable "btk_sg_fnc_dialGlobalNow";
	[_fromDHD, _toDHD] spawn btk_sg_fnc_dialGlobal;

};


// Canceled?
if (_canceled) then {

	// Reset DHD
	_object setVariable ["btk_sg_dhdIsDialing", nil, true];
	_object setVariable ["btk_sg_dhdIsConnected", nil, true];
	_object setVariable ["btk_sg_dhdIsConnectedTo", nil, true];
	
	// Reset player
	btk_sg_playerIsInteracting = nil;
	btk_sg_playerIsBusy = nil;

} else {

	// Reset player
	btk_sg_playerIsInteracting = nil;
	btk_sg_playerIsBusy = nil;

};


if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=====> btk_sg_fnc_dhdDial : Player has dialed!"]; };


true;