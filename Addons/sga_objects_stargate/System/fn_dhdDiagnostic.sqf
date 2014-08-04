/*
	File: btk_sg_fnc_dhdDiagnostic.sqf
	Author: BTK (btk@arma3.cc)

	Description:
	DHD Diagnostic.

	Parameter(s):
	0. DHD (OBJECT)
	1. Unit/Player executing the action (OBJECT)
	2. Action (ACTION)
	3. Parameter (Action) (ARRAY)

	Returns:
	Success (BOOLEAN)

	Syntax:
	[_dhd, player, _action, [_parameter]] spawn btk_sg_fnc_dhdDiagnostic;
*/


_debug = true;


// Variables
_object = _this select 0;
_unit = _this select 1;
_action = _this select 2;
_parameter = _this select 3;
_type = _parameter select 0;
_playerPos = getPosATL _unit;
_percent = "%";
_canceled = false;


// Only where caller is local
if (!(local _unit)) exitWith {};


//  Requirements
if (!("btk_items_tablet_diagnostic" in (items _unit)) && !("btk_items_tablet_high_performance" in (items _unit)) && !(_unit hasWeapon "btk_items_tablet_military")) exitWith {
	cutText ["You need a Tablet PC to do that.", "PLAIN DOWN", 0.5];
	sleep 5;
	cutText ["", "PLAIN DOWN", 0.5];	
};


// Tag
btk_sg_playerIsInteracting = true;
btk_sg_playerIsBusy = true;


// Play action
_unit playActionNow "Diary";


// Collect data
_damageValue = (damage _object);
_damage = if (_damageValue < 0.2) then { format["%1%2", (floor (100 * (damage _object))), _percent]; } else { format["%1%2", (floor (100 * (damage _object))), _percent]; };
_gate =  if (isNil {_object getVariable "btk_sg_dhdGate"}) then { "ERROR"; } else { if (!(isNil {_object getVariable "btk_sg_dhd_isConnected"}) || !(isNil {_object getVariable "btk_sg_dhd_isConnected"})) then { if (!(isNil {_object getVariable "btk_sg_dhd_isConnected"})) then { "OK (Active)"; } else { "OK (Dialing)"; }; } else { "OK (Standby)"; }; };
_controlCrystal = if (isNil {_object getVariable "btk_sg_dhdControlCrystal"}) then { "ERROR"; } else { "OK"; };
_power = if (isNil {_object getVariable "btk_sg_dhdPower"}) then { "ERROR"; } else { _powerValue = (_object getVariable "btk_sg_dhdPower"); format["OK (%1%2)", _powerValue, _percent]; };
_software = if (isNil {_object getVariable "btk_sg_dhdSoftware"}) then { "ERROR"; } else { _softwareOK = (_object getVariable "btk_sg_dhdSoftware"); if (_softwareOK) then { "OK"; } else { "ERROR"; }; };


// Process time
_processLoops = if (("btk_items_sg_tablet_diagnostic" in (items _unit)) || ("btk_sg_item_tablet_high_performance" in (items _unit))) then { if ("btk_items_sg_tablet_diagnostic" in (items _unit)) then { 1; } else { 2; }; } else { 3; };


// Starting
_text = format["<t align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD DIAGNOSTIC</t><br />Running diagnostic</t>"];
hint parseText _text;
sleep 1;
	


// Processing...
for "_j" from 1 to _processLoops do {

	_movedAway = if (((getPosATL player) distance _playerPos) > 1.1) then { true; } else { false; };
	if ((isNil "btk_sg_playerIsInteracting") || !(alive _unit) || _movedAway) exitWith { _canceled = true; };

	_text = format["<t align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD DIAGNOSTIC</t><br />Running diagnostic.</t>"];
	hintSilent parseText _text;
	sleep 1;

	_movedAway = if (((getPosATL player) distance _playerPos) > 1.1) then { true; } else { false; };
	if ((isNil "btk_sg_playerIsInteracting") || !(alive _unit) || _movedAway) exitWith { _canceled = true; };
	
	_text = format["<t align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD DIAGNOSTIC</t><br />Running diagnostic..</t>"];
	hintSilent parseText _text;
	sleep 1;

	_movedAway = if (((getPosATL player) distance _playerPos) > 1.1) then { true; } else { false; };
	if ((isNil "btk_sg_playerIsInteracting") || !(alive _unit) || _movedAway) exitWith { _canceled = true; };
	
	_text = format["<t align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD DIAGNOSTIC</t><br />Running diagnostic...</t>"];
	hintSilent parseText _text;
	sleep 1;

};



// Canceled?
if (_canceled) then {

	// Hint
	sleep 0.1;
	hintSilent "";

} else {

	// Hint
	sleep 1;
	_text = format["<t align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD DIAGNOSTIC</t><br />Damage: <t color='#e9bc55'>%2</t><br />Gate: <t color='#e9bc55'>%4</t><br />Power Supply: <t color='#e9bc55'>%3</t><br />Control Crystal: <t color='#e9bc55'>%5</t><br />Software: <t color='#e9bc55'>%6</t></t>", _percent, _damage, _power, _gate, _controlCrystal, _software];
	hint parseText _text;
	
};


// Reset
btk_sg_playerIsInteracting = nil;
btk_sg_playerIsBusy = nil;