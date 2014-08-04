/*
	File: btk_sg_fnc_kawoosh.sqf
	Author: BTK (btk@arma3.cc)

	Description:
	KAWOOSH!

	Parameter(s):
	0. Gate (OBJECT)
	1. Angle/Dir (NUMBER)

	Returns:
	Success (BOOLEAN)

	Syntax:
	_kawoosh = [_gate, ((getDir _gate) - 180)] call btk_sg_fnc_kawoosh;
*/


_debug = true;


// Variables
_gate = _this select 0;
_angle = _this select 1;


if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=== btk_sg_fnc_kawoosh : Kawoosh for %1...", _gate]; };


// Player flow
if (!isDedicated) then {

	// Only players that are in reasonable range
	if ((player distance _gate) > 1000) exitWith {};

	// Player is near gate, display effects
	if ((player distance _gate) < 30) then {

		[_gate] spawn {
		
			_gate = _this select 0;
		
			cutText ["", "WHITE OUT", 0.2];
		
			"dynamicBlur" ppEffectEnable true;
			"dynamicBlur" ppEffectAdjust [10];
			"dynamicBlur" ppEffectCommit 0;
			"dynamicBlur" ppEffectAdjust [0];
			"dynamicBlur" ppEffectCommit 3;
			
			_ppKawooshColor = ppEffectCreate ["ColorCorrections", 1500];
			_ppKawooshColor ppEffectEnable true;

			_ppKawooshColor ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [0, 0, 0, 1], [0, 0, 0, 0]];
			_ppKawooshColor ppEffectCommit 0;
			_ppKawooshColor ppEffectAdjust [1, 1, 0, [0, 0, 0.47619, 0.603741], [0, 0.946089, 1, 0.321259], [0.471939, 0.221088, 0.740307, 0.47619]];
			_ppKawooshColor ppEffectCommit 6;

			_ppKawooshColor ppEffectAdjust [1, 1, 0, [0, 0, 0.47619, 0.603741], [0, 0.946089, 1, 0.321259], [0.471939, 0.221088, 0.740307, 0.47619]];
			_ppKawooshColor ppEffectCommit 0;
			_ppKawooshColor ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [0, 0, 0, 1], [0, 0, 0, 0]];
			_ppKawooshColor ppEffectCommit 6;

			// PRELOAD TEXTURES
			sleep 0.2;
			cutText ["", "WHITE IN", 0.2];
			
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
				_gate setObjectTexture [18, _x];
				sleep 0.01;
			
			} forEach _textures;
				
			sleep 4;
			
			ppEffectDestroy _ppKawooshColor;
			
		};
		
	};

};


//--- Kawoosh particle source
_kawooshSourcePos = (_gate modelToWorld [0, -0.3, -0.2]);
_kawooshSource = "Land_Bucket_F" createVehicleLocal _kawooshSourcePos;
_kawooshSource setPosATL _kawooshSourcePos;
_kawooshSource setDir (getDir _gate);


// No particle on dedicated
if (!isDedicated) then {

	_kawooshParticle = "#particlesource" createVehicleLocal (getPosATL _kawooshSource);

	_kawooshParticle setParticleParams [
	["\a3\data_f\ParticleEffects\Universal\Universal", 16, 12, 13, 0], // ShapeName - Specifies the P3D-Model being used for this particle
	"", // AnimationName - specifies the animation being used
	"Billboard", // Type - Particle-type (either "Billboard" or "SpaceObject")
	0.4, // TimerPeriod - time (period) between timer events
	0.003, // LifeTime - time, after particles are destroyed
	[0, -1, -0.27], // Position - Origin of the particle either relative to an object or the map
	[(12 * (sin _angle)), (12 * (cos _angle)), 0], // MoveVelocity - velocity vector
	5, // RotationVelocity - rotations per second
	1.275, // Weight - mass
	1, // Volume
	0.5, // Rubbing - friction intensity
	[3.1, 0, 0], // Size - particle size (transition)
	[[0.9, 0.9, 1, 0.8], [0, 0.3, 0.6, 0.1], [1, 1, 1, 0.8]], // Color - particle color (transition)
	[1000], // AnimationPhase - Animation phase (transition) 
	0,// RandomDirectionPeriod - time after velocity is changed periodically
	0,// RandomDirectionIntensity - Intensity how velocity is changed periodically
	"", // OnTimer - Script that is executed periodically by the timer-event
	"", // BeforeDestroy - Script that is executed after particle was destroyed
	_kawooshSource // Object
	];

	_kawooshParticle setParticleRandom [2, [0, 0, 0], [0, 0, 0], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 0];
	_kawooshParticle setDropInterval 0.0023;

};


//--- Kawoosh is deadly!
[_kawooshSource, _gate, _debug] spawn {

	_kawooshSource = _this select 0;
	_gate = _this select 1;
	_debug = _this select 2;
	
	_kawooshSensor1Pos = (_gate modelToWorld [0, -2, -2]);
	_kawooshSensor2Pos = (_gate modelToWorld [0, -3.5, -2]);
	_kawooshSensor3Pos = (_gate modelToWorld [0, -5, -2]);

	_kawooshSensor1 = "Land_Bucket_F" createVehicleLocal [0, 0, 0];
	_kawooshSensor1 hideObject true;
	_kawooshSensor1 setPosATL _kawooshSensor1Pos;
	_kawooshSensor1 setDir (getDir _gate);

	_kawooshSensor2 = "Land_Bucket_F" createVehicleLocal [0, 0, 0];
	_kawooshSensor2 hideObject true;
	_kawooshSensor2 setPosATL _kawooshSensor2Pos;
	_kawooshSensor2 setDir (getDir _gate);

	_kawooshSensor3 = "Land_Bucket_F" createVehicleLocal [0, 0, 0];
	_kawooshSensor3 hideObject true;
	_kawooshSensor3 setPosATL _kawooshSensor3Pos;
	_kawooshSensor3 setDir (getDir _gate);
	
	_toDestroyBlacklist = (nearestObjects [_gate, ["DSF_Stargate_MilkyWay"], 20]) + (nearestObjects [_gate, ["RampConcrete"], 20]) + (nearestObjects [_gate, ["DSF_DHD"], 20]) + (nearestObjects [_gate, ["Land_Bucket_F"], 20]);
	
	//_toDestroy = (_kawooshSensor1 nearEntities [["Man", "Car"], 3]) + (_kawooshSensor2 nearEntities [["Man", "Car"], 3]) + (_kawooshSensor3 nearEntities [["Man", "Car"], 3]);
	_toDestroy = ((nearestObjects [_kawooshSensor1, ["All"], 3]) + (nearestObjects [_kawooshSensor2, ["All"], 3]) + (nearestObjects [_kawooshSensor3, ["All"], 3])) - _toDestroyBlacklist;

	sleep 0.2;

	// Objects found
	if ((count _toDestroy) > 0) then {

		{
		
			// Only local objects
			if (local _x) then {
			
				_x spawn {
					if (_this isKindOf "Man") then { // todo: is standing?
						_this setDamage 1;
						sleep 0.5;
						hideBody _this;
						sleep 0.5;
						deleteVehicle _this;
					} else {
						_this setDamage 1;
						sleep 0.5;
						deleteVehicle _this;
					};
				};
				
			};
			
		} forEach _toDestroy;

		if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=====> btk_sg_fnc_kawoosh : Destroyed %1!", _toDestroy]; };
	
	};
	
	sleep 1;
	
	deleteVehicle _kawooshSource;
	
	sleep 60;
	deleteVehicle _kawooshSensor1;
	deleteVehicle _kawooshSensor2;
	deleteVehicle _kawooshSensor3;
	
};


true;