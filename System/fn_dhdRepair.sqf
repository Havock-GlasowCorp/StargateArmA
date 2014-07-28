/*
	File: btk_sg_fnc_dhdRepair.sqf
	Author: BTK (btk@arma3.cc)

	Description:
	Repair DHD.
	Normal units can repair 10-20%, engineers 20-40%.

	Parameter(s):
	0. DHD (OBJECT)
	1. Unit/Player executing the action (OBJECT)
	2. Action (ACTION)
	3. Parameter (Action) (ARRAY)

	Returns:
	Success (BOOLEAN)

	Syntax:
	[_dhd, player, _action, [_parameter]] spawn btk_sg_fnc_dhdRepair;
*/


// Variables
_object = _this select 0;
_unit = _this select 1;
_action = _this select 2;
_parameter = _this select 3;
_type = _parameter select 0;
_playerPos = getPosATL _unit;
_percent = "%";
_isEngineer = if (getNumber (configFile >> "CfgVehicles" >> (typeOf _unit) >> "canDeactivateMines") == 1) then { true; } else { false; };


// Only where caller is local
if (!(local _unit)) exitWith {};


//  Requirements
if (!(_unit hasWeapon "btk_sg_item_repair_kit")) exitWith {
	cutText ["You need a Repair Kit to do that.", "PLAIN DOWN", 0.5];
	sleep 5;
	cutText ["", "PLAIN DOWN", 0.5];	
};


_canceled = false;


btk_sg_playerIsInteracting = true;
btk_sg_playerIsBusy = true;


_unit playActionNow "Medic";


// Check
for "_j" from 1 to 7 do {

	sleep 1;

	_movedAway = if (((getPosATL player) distance _playerPos) > 1.1) then { true; } else { false; };
	
	if ((isNil "btk_sg_playerIsInteracting") || !(alive _unit) || _movedAway) exitWith { _canceled = true; };

};

sleep 0.5;

// Canceled?
if (_canceled) then {

	btk_sg_playerIsInteracting = nil;
	btk_sg_playerIsBusy = nil;

	[objNull, player, rSWITCHMOVE, "aidlpercmstpsnonwnondnon_player_idlesteady01"] call RE;
	_unit playActionNow "Combat";
	
} else {

	_damage = (damage _object);
	_repairValue = if (_isEngineer) then { (0.2 + (random 0.2)); } else { (0.1 + (random 0.1)); }; // 20 - 40 % / 10 - 20 %
	_newDamage = (_damage - _repairValue);

	_object setDamage _newDamage;
	
	btk_sg_playerIsInteracting = nil;
	btk_sg_playerIsBusy = nil;
	
};