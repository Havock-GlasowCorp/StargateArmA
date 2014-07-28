/*
	File: btk_sg_fnc_dialGlobalGlobal.sqf
	Author: BTK (btk@arma3.cc)

	Description:
	Global dial sequence, should be executed by all clients incl. (dedicated) server.

	Parameter(s):
	0. Dialing DHD (OBJECT)
	1. Remote DHD (OBJECT)

	Returns:
	Success (BOOLEAN)

	Syntax:
	[_dhd, _remoteDhd] spawn btk_sg_fnc_dialGlobalGlobal;
*/


_debug = true;


// Parameter
_fromDhd = _this select 0;
_toDhd = _this select 1;


// Variables
_fromGate = _fromDhd getVariable "btk_sg_dhdGate";
_fromPlanetAddress = _fromDhd getVariable "btk_sg_dhdPlanetAddress";
_fromPlanetCode = _fromDhd getVariable "btk_sg_dhdPlanetCode";
_fromPlanetName = _fromDhd getVariable "btk_sg_dhdPlanetName";
_fromPlanetHasIris = _fromDhd getVariable "btk_sg_dhdPlanetHasIris";
_fromPlanetIrisCode = _fromDhd getVariable "btk_sg_dhdPlanetIrisCode";

_toGate = _toDhd getVariable "btk_sg_dhdGate";
_toPlanetAddress = _toDhd getVariable "btk_sg_dhdPlanetAddress";
_toPlanetCode = _toDhd getVariable "btk_sg_dhdPlanetCode";
_toPlanetName = _toDhd getVariable "btk_sg_dhdPlanetName";
_toPlanetHasIris = _toDhd getVariable "btk_sg_dhdPlanetHasIris";
_toPlanetIrisCode = _toDhd getVariable "btk_sg_dhdPlanetIrisCode";

_chevron = 1;


if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=== btk_sg_fnc_dialGlobal : Global dialing from %1 to %2...", _fromPlanetName, _toPlanetName]; };


//--- Server
if (isServer) then {
	
	// Dialing sound
	[_fromGate, _toGate, _fromDhd, _toDhd] spawn {
	
		_fromGate = _this select 0;
		_toGate = _this select 1;
		_fromDhd = _this select 2;
		_toDhd = _this select 3;

		// Dial sound
		_fromGateSoundSource = createVehicle ["Land_HelipadEmpty_F", (getPosATL _fromGate), [], 0, "NONE"];
		_fromGateSoundSource setPosATL (getPosATL _fromGate);
		_toGateSoundSource = createVehicle ["Land_HelipadEmpty_F", (getPosATL _toGate), [], 0, "NONE"];
		_toGateSoundSource setPosATL (getPosATL _toGate);

		[[_fromGateSoundSource, "btk_sg_sound_dialing", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP;
		[[_toGateSoundSource, "btk_sg_sound_dialing", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP;
		
		// Dialing over
		waitUntil {(isNil {_fromDhd getVariable 'btk_sg_dhdIsDialing'})};

		// If dialing was aborted
		
		sleep 10; // Sound
		
		if (isNil {_fromDhd getVariable 'btk_sg_dhdIsConnected'}) then {
		
			deleteVehicle _fromGateSoundSource;
			deleteVehicle _toGateSoundSource;
			sleep 1;
			
			[[_fromGateSoundSource, "btk_sg_sound_dialing_closing", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP;
			[[_toGateSoundSource, "btk_sg_sound_dialing_closing", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP;
			
		} else {
			
			sleep 30;
			deleteVehicle _fromGateSoundSource;
			deleteVehicle _toGateSoundSource;

		};

	};

};


// Dial flow
for "_j" from 1 to 7 do {
	
	// Reset all textures if dialing interrupted
	if (isNil {_fromDhd getVariable "btk_sg_dhdIsDialing"}) exitWith {
		
		if (!isDedicated) then {

			{
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
				_x setObjectTexture [18, ""];
			} forEach [_fromGate, _toGate];

		};

	};
	
	// Chevron
	switch (_chevron) do {

		// CEHVRON 1
		case (1): {
		
			sleep 4.5;
			
			if (!isDedicated) then {
				{
					_x setObjectTexture [2, "\SGImages\Stargate_chlighton2_CO.paa"]; _x setObjectTexture [3, "\SGImages\Stargate_chlighton_CO.paa"];
				} forEach [_fromGate, _toGate];
			};

		};
	
		// CEHVRON 2
		case (2): {
			
			sleep 5.2;
			
			if (!isDedicated) then {
				{
					_x setObjectTexture [4, "\SGImages\Stargate_chlighton2_CO.paa"]; _x setObjectTexture [5, "\SGImages\Stargate_chlighton_CO.paa"];
				} forEach [_fromGate, _toGate];
			};
			
		};
	
		// CEHVRON 3
		case (3): {
			
			sleep 5.3;
			
			if (!isDedicated) then {
				{
					_x setObjectTexture [6, "\SGImages\Stargate_chlighton2_CO.paa"]; _x setObjectTexture [7, "\SGImages\Stargate_chlighton_CO.paa"];
				} forEach [_fromGate, _toGate];
			};
			
		};
	
		// CEHVRON 4
		case (4): {
			
			sleep 5.5;
			
			if (!isDedicated) then {
				{
					_x setObjectTexture [12, "\SGImages\Stargate_chlighton2_CO.paa"]; _x setObjectTexture [13, "\SGImages\Stargate_chlighton_CO.paa"];
				} forEach [_fromGate, _toGate];
			};
			
		};
	
		// CEHVRON 5
		case (5): {
			
			sleep 5.1;
			
			if (!isDedicated) then {
				{
					_x setObjectTexture [14, "\SGImages\Stargate_chlighton2_CO.paa"]; _x setObjectTexture [15, "\SGImages\Stargate_chlighton_CO.paa"];
				} forEach [_fromGate, _toGate];
			};
			
		};
		
		// CEHVRON 6
		case (6): {
			
			sleep 4.7;
			
			if (!isDedicated) then {
				{
					_x setObjectTexture [16, "\SGImages\Stargate_chlighton2_CO.paa"]; _x setObjectTexture [17, "\SGImages\Stargate_chlighton_CO.paa"];
				} forEach [_fromGate, _toGate];
			};
			
		};
	
		// CEHVRON 7 - OPENS WORMHOLE
		case (7): {
			
			sleep 5;
			
			// Check if gate available
			if (!(isNil {_toGate getVariable "btk_sg_gateNoAvailable"})) exitWith {
				// Cannot establish wormhole
				// for whatever reason
			};
			
			// Set chevron texture
			if (!isDedicated) then {
				{
					_x setObjectTexture [1, "\SGImages\Stargate_chlighton2_CO.paa"]; _x setObjectTexture [1, "\SGImages\Stargate_chlighton_CO.paa"];
				} forEach [_fromGate, _toGate];
			};

			// Tag
			_fromDhd setVariable ["btk_sg_dhdIsConnected", _toDhd, true]; // GLOBAL?
			_toDhd setVariable ["btk_sg_dhdIsConnected", _fromDhd, true]; // GLOBAL?
			_fromDhd setVariable ["btk_sg_dhdIsConnectedTo", _toDhd, true]; // GLOBAL?
			
			// Reset
			sleep 1;
			_fromDhd setVariable ["btk_sg_dhdIsDialing", nil, true]; // GLOBAL?
			
			// Kawoosh
			_fromKawoosh = [_fromGate, ((getDir _fromGate) - 180)] call btk_sg_fnc_kawoosh;
			_toKawoosh = [_toGate, ((getDir _toGate) - 180)] call btk_sg_fnc_kawoosh;
	
			//--- Preload active textures on clients
			if (!isDedicated) then {
			
				[_fromGate, _toGate] spawn {
				
					_fromGate = _this select 0;
					_toGate = _this select 1;
				
					/*_textures = [
					"\SGImages\eh1.paa", "\SGImages\eh2.paa", "\SGImages\eh3.paa", "\SGImages\eh4.paa",
					"\SGImages\eh5.paa", "\SGImages\eh6.paa", "\SGImages\eh7.paa", "\SGImages\eh8.paa",
					"\SGImages\eh9.paa", "\SGImages\eh10.paa", "\SGImages\eh11.paa", "\SGImages\eh12.paa",
					"\SGImages\eh13.paa", "\SGImages\eh14.paa", "\SGImages\eh15.paa", "\SGImages\eh16.paa",
					"\SGImages\eh17.paa", "\SGImages\eh18.paa", "\SGImages\eh19.paa", "\SGImages\eh20.paa",
					"\SGImages\eh21.paa", "\SGImages\eh22.paa", "\SGImages\eh23.paa", "\SGImages\eh24.paa",
					"\SGImages\eh25.paa"
					];*/
					
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

					{
							_fromGate setObjectTexture [18, _x];
							_toGate setObjectTexture [18, _x];
						sleep 0.001;
					} forEach _textures;

				};

			};
			
			// Create wormhole
			sleep 2;
			[_fromDhd, _toDhd] spawn btk_sg_fnc_wormhole;

		};
		
	};
	
	_chevron = _chevron + 1;
	
};


if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=====> btk_sg_fnc_dialGlobal : Global dialing from %1 to %2 finished!", _fromPlanetName, _toPlanetName]; };