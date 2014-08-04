/*
	File: btk_sg_fnc_travel.sqf
	Author: BTK (btk@arma3.cc)

	Description:
	Travel thrugh the wormhole...
	Travel time is ~3.3 seconds.

	Parameter(s):
	0. Object to transfer (OBJECT)
	1. Target gate (OBJECT)

	Returns:
	-

	Syntax:
	[_object, _toGate] spawn btk_sg_fnc_travel;
*/


_debug = true;


// Variables
_object = _this select 0;
_toGate = _this select 1;
_fromDHD = _this select 2;
_fromGate = _fromDHD getVariable "btk_sg_dhdGate";
_toDHD = _toGate getVariable "btk_sg_gateDhd";
_toPlanetHasIris = _toDHD getVariable "btk_sg_dhdPlanetHasIris";
_fromPlanetZimezone = _fromDHD getVariable "btk_sg_dhdPlanetCurrentTime";
_toPlanetZimezone = _toDHD getVariable "btk_sg_dhdPlanetCurrentTime";
_hasRamp = _toGate getVariable "btk_sg_gate_hasRamp";
_localPlayer = if (isDedicated) then { false; } else { if (player == _object) then { true; } else { false; }; };
_type = if (_object isKindOf "Man") then { "man"; } else { "other"; };
//_mtw = switch (_type) do { case ("man"): { (_toGate modelToWorld [0, -1.2, 0]); }; default { (_toGate modelToWorld [0, -1.2, 0]); }; };
_mtw = (_toGate modelToWorld [0, -(1.3 + (random 0.4)), 0.5]);
//_atl = if (_hasRamp) then { 2; } else { 0.2; };
_setPos = [_mtw select 0, _mtw select 1, _mtw select 2];
_setDir = ((getDir _toGate) - 180);
_travelTime = 3 + (random 0.33);


if (!(local _object)) exitWith {}; // Input should be local anyway


if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=== btk_sg_fnc_travel : Transfering object %1...", (typeOf _object)]; };


// Sound
[[_fromGate, "btk_sg_sound_travel", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP;


// Player fx
if (_localPlayer) then {

	cutText ["", "WHITE OUT", 0.1];
		
	"dynamicBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [9];
	"dynamicBlur" ppEffectCommit 0;
	"dynamicBlur" ppEffectAdjust [0];
	"dynamicBlur" ppEffectCommit 7;

};


// Just in case
deTach _object;
sleep 0.1;


// Move away
_object setPosATL [0, 0, 5000];
_object allowDamage false;
_object enableSimulation false;


// Travel time
sleep _travelTime;

if (_toPlanetHasIris) exitWith {
	if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=! btk_sg_fnc_travel : Iris hit! (object: %1)", (typeOf _object)]; };
	_object enableSimulation true;
	_object allowDamage true;
	sleep 0.1;
	// ?????????????????
	//[nil, _toGate, rSAY, "btk_sg_gateIrisHit"] call RE;
	//playSound "btk_sg_gateIrisHit";
	// ?????????????????
	sleep 0.5;
	_object setDamage 1;
};


// Set current planet time locally
if (_toPlanetZimezone < _fromPlanetZimezone) then { skipTime -(_fromPlanetZimezone - _toPlanetZimezone); } else { skipTime _toPlanetZimezone; };



// Transfered
_object enableSimulation true;
_object setDir _setDir;
_object setPosATL _setPos;


// Sound
sleep 0.1;
[[_object, "btk_sg_sound_travel", 5], "btk_fnc_MPsay"] spawn BIS_fnc_MP;


// Player fx
if (_localPlayer) then {

	{ player reveal _x; } forEach ((getPosATL player) nearObjects ["All", 50]);
	
	cutText ["", "WHITE IN", 1];

};


// Done
sleep 1;
_object allowDamage true;


if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=====> btk_sg_fnc_travel : Object %1 transferred ! (travel time: %2)", _object, _travelTime]; };