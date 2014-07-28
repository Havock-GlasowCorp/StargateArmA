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
_playerPos = getPosATL _unit;


if (!(local _unit)) exitWith {};


_canceled = false;

btk_sg_playerIsInteracting = true;
btk_sg_playerIsBusy = true;


_unit playActionNow "Medic";
_canceled = false;		


switch (_type) do {

	//--- Install control crystal
	case ("install"): {
	
		//  Requirements
		
		if (!("btk_items_sg_control_crystal_dhd_milky_way" in (items player))) exitWith {
			cutText ["You need a Control Crystal to do that.", "PLAIN DOWN", 0.5];
			sleep 5;
			cutText ["", "PLAIN DOWN", 0.5];
		};
		
		_unit removeWeapon "btk_items_sg_control_crystal_dhd_milky_way";

		// Check
		for "_j" from 1 to 7 do {
		
			sleep 1;
			
			_movedAway = if (((getPosATL player) distance _playerPos) > 1.1) then { true; } else { false; };
			if (!(isNil {_object getVariable 'btk_sg_dhdControlCrystal'}) || (isNil "btk_sg_playerIsInteracting") || !(alive _unit) || _movedAway) exitWith { _canceled = true; };
		
		};
		
		sleep 0.5;
		
		// Canceled or has crontrol crystal already
		if (_canceled) then {
		
			_unit addItem "btk_items_sg_control_crystal_dhd_milky_way";

			btk_sg_playerIsInteracting = nil;
			btk_sg_playerIsBusy = nil;
		
			_object setVariable ["btk_sg_dhdControlCrystal", nil, false];
			
			_unit playActionNow "Combat";
			
		} else {
		
			_object setVariable ["btk_sg_dhdControlCrystal", true, false];
		
			btk_sg_playerIsInteracting = nil;
			btk_sg_playerIsBusy = nil;
			
		};
	
	};
	
	//--- Take control crystal
	case ("take"): {
		
		// Check
		for "_j" from 1 to 7 do {
		
			sleep 1;
			
			_movedAway = if (((getPosATL player) distance _playerPos) > 1.1) then { true; } else { false; };
			if ((isNil {_object getVariable 'btk_sg_dhdControlCrystal'}) || (isNil "btk_sg_playerIsInteracting") || !(alive _unit) || _movedAway) exitWith { _canceled = true; };
			
		};
		
		sleep 0.5;
		
		// Canceled or has no control crystal anmore
		if (_canceled) then {

			btk_sg_playerIsInteracting = nil;
			btk_sg_playerIsBusy = nil;
		
			_object setVariable ["btk_sg_dhdControlCrystal", true, false];
			
			_unit playActionNow "Combat";
			
		} else {
		
			_unit addItem "btk_items_sg_control_crystal_dhd_milky_way";
		
			_unit setVariable ["btk_sg_playerControlCrystal", true, true];
			_object setVariable ["btk_sg_dhdControlCrystal", nil, false];
		
			btk_sg_playerIsInteracting = nil;
			btk_sg_playerIsBusy = nil;
			
		};

	};

};