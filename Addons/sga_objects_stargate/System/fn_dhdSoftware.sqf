/*
	File: btk_sg_fnc_dhdSoftware.sqf
	Author: BTK (btk@arma3.cc)

	Description:
	Fix DHD Software.

	Parameter(s):
	0. DHD (OBJECT)
	1. Unit/Player executing the action (OBJECT)
	2. Action (ACTION)
	3. Parameter (Action) (ARRAY)

	Returns:
	Success (BOOLEAN)

	Syntax:
	[_dhd, player, _action, [_parameter]] spawn btk_sg_fnc_dhdSoftware;
*/


// Parameter
_object = _this select 0;
_unit = _this select 1;
_action = _this select 2;
_parameter = _this select 3;
_type = _parameter select 0;


// Variables
_playerPos = getPosATL _unit;
_successProbability = round (random 10); // todo: based on conditions
_canceled = false;


// Only where caller is local
if (!(local _unit)) exitWith {};


//  Requirements
if (!("btk_items_laptop" in (items _unit)) && !("btk_items_laptop_small" in (items _unit))) exitWith {
	cutText ["You need a laptop to do that", "PLAIN DOWN", 0.5];
	sleep 5;
	cutText ["", "PLAIN DOWN", 0.5];	
};


// Tag
btk_sg_playerIsInteracting = true;
btk_sg_playerIsBusy = true;


// Play action
_unit playActionNow "Diary";


// Actions
switch (_type) do {

	case ("fix"): {

		// Process time
		_processLoops = if ("btk_items_laptop" in (items _unit)) then { 2; } else { if ("btk_items_laptop_small" in (items _unit)) then { 3; } else { 4; }; };

		// Starting
		_text = format["<t font='Zeppelin33' align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD SOFTWARE</t><br />Fixing</t>"];
		hint parseText _text;
		sleep 1;

		// Processing...
		for "_j" from 1 to _processLoops do {

			_movedAway = if (((getPosATL player) distance _playerPos) > 1.1) then { true; } else { false; };
			if ((isNil "btk_sg_playerIsInteracting") || !(alive _unit) || _movedAway) exitWith { _canceled = true; };

			_text = format["<t font='Zeppelin33' align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD SOFTWARE</t><br />Fixing.</t>"];
			hintSilent parseText _text;
			sleep 1;

			_movedAway = if (((getPosATL player) distance _playerPos) > 1.1) then { true; } else { false; };
			if ((isNil "btk_sg_playerIsInteracting") || !(alive _unit) || _movedAway) exitWith { _canceled = true; };
			
			_text = format["<t font='Zeppelin33' align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD SOFTWARE</t><br />Fixing..</t>"];
			hintSilent parseText _text;
			sleep 1;

			_movedAway = if (((getPosATL player) distance _playerPos) > 1.1) then { true; } else { false; };
			if ((isNil "btk_sg_playerIsInteracting") || !(alive _unit) || _movedAway) exitWith { _canceled = true; };
			
			_text = format["<t font='Zeppelin33' align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD SOFTWARE</t><br />Fixing...</t>"];
			hintSilent parseText _text;
			sleep 1;

		};

		// Canceled?
		if (_canceled) then {

			// Hint
			sleep 0.1;
			hintSilent "";

		} else {

			// Fixed ? 50% chance
			if (_successProbability > 5) then {
			
				_object setVariable ["btk_sg_dhdSoftware", true, true];

				// Hint
				sleep 1;
				_text = format["<t font='Zeppelin33' align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD SOFTWARE</t><br />All problems fixed.</t>"];
				hint parseText _text;
			
			} else {

				// Hint
				sleep 1;
				_text = format["<t font='Zeppelin33' align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD SOFTWARE</t><br />Fixing attempt failed!</t>"];
				hint parseText _text;
			
			};
			
		};

		// Reset
		btk_sg_playerIsInteracting = nil;
		btk_sg_playerIsBusy = nil;
	};
	
	case ("hack"): {

		// Process time
		_processLoops = if ("btk_items_laptop" in (items _unit)) then { 2; } else { if ("btk_items_laptop_small" in (items _unit)) then { 3; } else { 4; }; };

		// Starting
		_text = format["<t font='Zeppelin33' align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD SOFTWARE</t><br />Hacking</t>"];
		hint parseText _text;
		sleep 1;

		// Processing...
		for "_j" from 1 to _processLoops do {

			_movedAway = if (((getPosATL player) distance _playerPos) > 1.1) then { true; } else { false; };
			if ((isNil "btk_sg_playerIsInteracting") || !(alive _unit) || _movedAway) exitWith { _canceled = true; };

			_text = format["<t font='Zeppelin33' align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD SOFTWARE</t><br />Hacking.</t>"];
			hintSilent parseText _text;
			sleep 1;

			_movedAway = if (((getPosATL player) distance _playerPos) > 1.1) then { true; } else { false; };
			if ((isNil "btk_sg_playerIsInteracting") || !(alive _unit) || _movedAway) exitWith { _canceled = true; };
			
			_text = format["<t font='Zeppelin33' align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD SOFTWARE</t><br />Hacking..</t>"];
			hintSilent parseText _text;
			sleep 1;

			_movedAway = if (((getPosATL player) distance _playerPos) > 1.1) then { true; } else { false; };
			if ((isNil "btk_sg_playerIsInteracting") || !(alive _unit) || _movedAway) exitWith { _canceled = true; };
			
			_text = format["<t font='Zeppelin33' align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD SOFTWARE</t><br />Hacking...</t>"];
			hintSilent parseText _text;
			sleep 1;

		};

		// Canceled?
		if (_canceled) then {

			// Hint
			sleep 0.1;
			hintSilent "";

		} else {


			// Hacked ? 50% chance
			if (_successProbability > 5) then {
			
				// Hacked
				_object setVariable ["btk_sg_dhdSoftware", nil, true];

				// Hint
				sleep 1;
				_text = format["<t font='Zeppelin33' align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD SOFTWARE</t><br />System hacked.</t>"];
				hint parseText _text;
			
			} else {

				// Hint
				sleep 1;
				_text = format["<t font='Zeppelin33' align='left' color='#b2b999' size='1.02'><t color='#e9bc55' size='1.05'>DHD SOFTWARE</t><br />Hacking attempt failed!</t>"];
				hint parseText _text;
			
			};
			
		};

		// Reset
		btk_sg_playerIsInteracting = nil;
		btk_sg_playerIsBusy = nil;
	
	};
	
};