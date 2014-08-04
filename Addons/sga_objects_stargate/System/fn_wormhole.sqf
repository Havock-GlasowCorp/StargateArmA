/*
	File: btk_sg_fnc_wormhole.sqf
	Author: BTK (btk@arma3.cc)

	Description:
	Global wormhole flow, should be executed by all clients incl. (dedicated) server.

	Parameter(s):
	0. DHD (OBJECT)
	1. Planet Address (STRING)
	2. Planet Code (STRING)
	...

	Returns:
	Success (BOOLEAN)

	Syntax:
	[_dhd, _remoteDhd] spawn btk_sg_fnc_wormhole;
*/


_debug = true;


// Variables
_fromDhd = _this select 0;
_fromGate = _fromDhd getVariable "btk_sg_dhdGate";
_fromPlanetAddress = _fromDhd getVariable "btk_sg_dhdPlanetAddress";
_fromPlanetCode = _fromDhd getVariable "btk_sg_dhdPlanetCode";
_fromPlanetName = _fromDhd getVariable "btk_sg_dhdPlanetName";
_fromPlanetHasIris = _fromDhd getVariable "btk_sg_dhdPlanetHasIris";
_fromPlanetIrisCode = _fromDhd getVariable "btk_sg_dhdPlanetIrisCode";

_toDhd = _this select 1;
_toGate = _toDhd getVariable "btk_sg_dhdGate";
_toPlanetAddress = _toDhd getVariable "btk_sg_dhdPlanetAddress";
_toPlanetCode = _toDhd getVariable "btk_sg_dhdPlanetCode";
_toPlanetName = _toDhd getVariable "btk_sg_dhdPlanetName";
_toPlanetHasIris = _toDhd getVariable "btk_sg_dhdPlanetHasIris";
_toPlanetIrisCode = _toDhd getVariable "btk_sg_dhdPlanetIrisCode";


if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=== btk_sg_fnc_wormhole : Creating wormholes for %1 and %2...", _fromDhd, _toDhd]; };



//--- Travel flow
[_fromDhd, _toDhd] spawn btk_sg_fnc_travelSensor;


//--- Server
if (isServer) then {

	// Add to current active list (for JIPs)
	_this spawn {
	
		_fromDhd = _this select 0;
	
		btk_sg_wormholesActive = btk_sg_wormholesActive + [_this];
		
		while {!(isNil {_fromDhd getVariable "btk_sg_dhdIsConnected"})} do { sleep 2; };
		
		btk_sg_wormholesActive = btk_sg_wormholesActive - [_this];
		
	};

	// MAX TIME OPEN - AUTO CLOSE
	[_fromDhd, _toDhd, _fromGate, _toGate] spawn {

		_fromDhd = _this select 0;
		_toDhd = _this select 1;
		_fromGate = _this select 2;
		_toGate = _this select 3;
		
		_loops = 0;
		
		// 10*30 = 300sec
		while {!(isNil {_fromDhd getVariable "btk_sg_dhd_isConnected"}) && (_loops < 30)} do {
			sleep 10;
			_loops = _loops + 1;
		};
		
		// Check if still open
		if (!(isNil {_fromDhd getVariable "btk_sg_dhd_isConnected"})) then {

			_fromDhd setVariable ["btk_sg_dhdIsConnectedTo", nil, true];
			_fromDhd setVariable ["btk_sg_dhdIsConnected", nil, true];
			_toDhd setVariable ["btk_sg_dhdIsConnected", nil, true];
		
			if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=! btk_sg_fnc_wormhole : %1 Connection timeout!", _fromDhd]; };
		
		};

	};		

	// Open wormhole sound flow
	[_fromDhd, _toDhd, _fromGate, _toGate] spawn {

		_fromDhd = _this select 0;
		_toDhd = _this select 1;
		_fromGate = _this select 2;
		_toGate = _this select 3;
		
		sleep 3;

		while {!(isNil {_fromDhd getVariable "btk_sg_dhdIsConnected"})} do {
			
			[[_toGate, "btk_sg_sound_open", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP;
			[[_fromGate, "btk_sg_sound_open", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP;

			sleep 5.09;
		
		};

		// Closing
		sleep 1;
		[[_toGate, "btk_sg_sound_closing", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP;
		[[_fromGate, "btk_sg_sound_closing", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP;

	};

};


//--- Player
if (!isDedicated) then {

	// Open wormhole texture flow
	[_fromDhd, _toDhd, _fromGate, _toGate] spawn {

		_fromDhd = _this select 0;
		_toDhd = _this select 1;
		_fromGate = _this select 2;
		_toGate = _this select 3;

		_textures = [
		"new_eh\01.paa", "new_eh\02.paa", "new_eh\03.paa", "new_eh\04.paa",
		"new_eh\05.paa", "new_eh\06.paa", "new_eh\07.paa", "new_eh\08.paa",
		"new_eh\09.paa", "new_eh\10.paa", "new_eh\11.paa", "new_eh\12.paa",
		"new_eh\13.paa", "new_eh\14.paa", "new_eh\15.paa", "new_eh\16.paa",
		"new_eh\17.paa", "new_eh\18.paa", "new_eh\19.paa", "new_eh\20.paa",
		"new_eh\21.paa", "new_eh\22.paa", "new_eh\23.paa", "new_eh\24.paa",
		"new_eh\25.paa", "new_eh\26.paa", "new_eh\27.paa", "new_eh\28.paa",
		"new_eh\29.paa", "new_eh\30.paa", "new_eh\31.paa", "new_eh\32.paa",
		"new_eh\33.paa", "new_eh\34.paa", "new_eh\35.paa", "new_eh\36.paa",
		"new_eh\37.paa", "new_eh\38.paa", "new_eh\39.paa", "new_eh\40.paa",
		"new_eh\41.paa", "new_eh\42.paa", "new_eh\43.paa", "new_eh\44.paa",
		"new_eh\45.paa", "new_eh\46.paa", "new_eh\47.paa", "new_eh\48.paa",
		"new_eh\49.paa", "new_eh\50.paa", "new_eh\51.paa", "new_eh\52.paa",
		"new_eh\53.paa", "new_eh\54.paa", "new_eh\55.paa", "new_eh\56.paa",
		"new_eh\57.paa", "new_eh\58.paa", "new_eh\59.paa", "new_eh\60.paa",
		"new_eh\61.paa", "new_eh\62.paa", "new_eh\63.paa", "new_eh\64.paa",
		"new_eh\65.paa", "new_eh\66.paa", "new_eh\67.paa", "new_eh\68.paa",
		"new_eh\70.paa", "new_eh\71.paa", "new_eh\72.paa", "new_eh\73.paa",
		"new_eh\74.paa"
		];

		// Texture flow
		while {!(isNil {_fromDhd getVariable "btk_sg_dhdIsConnected"})} do {
			
			{
				_fromGate setObjectTexture [18, _x];
				_toGate setObjectTexture [18, _x];
				sleep 0.05;
			
			} forEach _textures;
		
		};
			
		// Reset
		sleep 2;
		
		{
			_x setObjectTexture [18, ""]; // Event horizon
			_x setObjectTexture [1, ""];
			_x setObjectTexture [2, ""];
			_x setObjectTexture [3, ""];
			_x setObjectTexture [4, ""];
			_x setObjectTexture [5, ""];
			_x setObjectTexture [6, ""];
			_x setObjectTexture [7, ""];
			_x setObjectTexture [12, ""];
			_x setObjectTexture [13, ""];
			_x setObjectTexture [14, ""];
			_x setObjectTexture [15, ""];
			_x setObjectTexture [16, ""];
			_x setObjectTexture [17, ""];
		} forEach [_fromGate, _toGate];

	};

};


//--- Iris
if (_toPlanetHasIris) then {
	player sideChat "careful, the iris on the other side is closed...!";
};


if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=== btk_sg_fnc_wormhole : Wormholes created for %1 and %2! Waiting for connection to end...", _fromDhd, _toDhd]; };


//--- Gate open flow
waitUntil {(isNil {_fromDhd getVariable "btk_sg_dhdIsConnected"})};


if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=====> btk_sg_fnc_wormhole : Wormholes destroyed for %1 and %2!", _fromDhd, _toDhd]; };