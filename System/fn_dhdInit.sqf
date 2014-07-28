/*
	File: btk_sg_fnc_dhdInit.sqf
	Author: BTK (btk@arma3.cc)

	Description:
	Initialize a DHD (Planet).
	Check for gate and add dial actions for off-world gates.

	Parameter(s):
	0. DHD (OBJECT)
	1. Planet Address (STRING)
	2. Planet Code (STRING)
	3. Planet Name (STRING)
	4. Has Iris? (BOOLEAN)
	5. Iris Code (NUMBER)

	Returns:
	Success (BOOLEAN)

	Syntax:
	_dhdReady = [dhd3, "2222222", "P3M-783", "Planet Two", false, 000000] call btk_sg_fnc_dhdInit;
*/


/*
	TODO:
	Locality
*/


private ["_debug", "_dhd", "_planetAddress", "_planetCode", "_planetName", "_remoteDhds", "_dhdActionIndex", "_nearGates", "_gate"];


_debug = true;


// Parameter
_dhd = _this select 0;
_planetAddress = _this select 1;
_planetCode = _this select 2;
_planetName = _this select 3;
_planetHasIris = _this select 4;
_planetIrisCode = _this select 5;


// Variables
_dhdActionIndex = 14000;


//--- Default init for all DHDs
if (isNil "btk_sg_dhd_default_init") then {

	btk_sg_dhd_default_init = true;

	{

		_x spawn {
			
			// Parameter
			_planet = _this;
			_dhd = (_planet select 0);
			
			// Cariables
			_actions = [];
			
			// Marker
			_marker = createMarkerLocal [format["btk_sg_marker_%1", (_this select 1)], (getPosATL (_this select 0))];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "mil_circle";
			_marker setMarkerColorLocal "ColorBlack";
			_marker setMarkerSizeLocal [0.4, 0.4];
			_marker setMarkerTextLocal format[" %1 (%2)", (_this select 2), (_this select 3)];
		
			while {true} do {
				
				// Wait until in reasonable range
				while {((player distance _dhd) > 100)} do { sleep 5; };
			
				// Is actual DHD?
				if ((typeOf _dhd) == "DSF_DHD") then {
				
					// Actions for DHD
					_actionCloseWormhole = _dhd addAction [format[("<t color='#ff0000'>" + ("Close wormhole") + "</t>")], "btk_sg\action_dhd.sqf", ["close"], 13002, false, false, "", "(player distance (_target modelToWorld [0, -0.7, -0.5]) < 1.5) && (isNil 'btk_sg_playerIsInteracting') && (isNil 'btk_sg_playerIsBusy') && !(isNil {_target getVariable 'btk_sg_dhdIsConnectedTo'})"];
					_actionAbortDialing = _dhd addAction [format[("<t color='#ff0000'>" + ("Abort dialing sequence") + "</t>")], "btk_sg\action_dhd.sqf", ["abort"], 13001, false, false, "", "(player distance (_target modelToWorld [0, -0.7, -0.5]) < 1.5) && (isNil 'btk_sg_playerIsInteracting') && (isNil 'btk_sg_playerIsBusy') && !(isNil {_target getVariable 'btk_sg_dhdIsDialing'}) && (isNil {_target getVariable 'btk_sg_dhdIsConnected'})"];
					_actionRepairDHD = _dhd addAction [format[("<t color='#ffa700'>" + ("Repair DHD") + "</t>")], "btk_sg\action_dhd.sqf", ["repair"], 13000, false, false, "", "(player distance (_target modelToWorld [0, -0.7, -0.5]) < 1.5) && ((damage _target) > 0.01) && (isNil 'btk_sg_playerIsInteracting') && (isNil 'btk_sg_playerIsBusy') && (isNil {_target getVariable 'btk_sg_dhdIsDialing'}) && (isNil {_target getVariable 'btk_sg_dhdIsConnected'})"];
					_actionHackSoftware = _dhd addAction [format[("<t>" + ("Hack DHD software") + "</t>")], "btk_sg\action_dhd.sqf", ["hack"], 12999, false, false, "", "(player distance (_target modelToWorld [0, -0.7, -0.5]) < 1.5) && !(isNil {_target getVariable 'btk_sg_dhdSoftware'}) && (isNil 'btk_sg_playerIsInteracting') && (isNil 'btk_sg_playerIsBusy') && (isNil {_target getVariable 'btk_sg_dhdIsDialing'}) && (isNil {_target getVariable 'btk_sg_dhdIsConnected'})"];
					_actionFixSoftware = _dhd addAction [format[("<t color='#ffa700'>" + ("Fix DHD software") + "</t>")], "btk_sg\action_dhd.sqf", ["fix"], 12998, false, false, "", "(player distance (_target modelToWorld [0, -0.7, -0.5]) < 1.5) && (isNil {_target getVariable 'btk_sg_dhdSoftware'}) && (isNil 'btk_sg_playerIsInteracting') && (isNil 'btk_sg_playerIsBusy') && (isNil {_target getVariable 'btk_sg_dhdIsDialing'}) && (isNil {_target getVariable 'btk_sg_dhdIsConnected'})"];
					_actionInstallControlCrystal = _dhd addAction [format[("<t>" + ("Install DHD control crystal") + "</t>")], "btk_sg\action_dhd.sqf", ["install"], 12997, false, false, "", "(player distance (_target modelToWorld [0, -0.7, -0.5]) < 1.5) && (isNil 'btk_sg_playerIsInteracting') && (isNil {_target getVariable 'btk_sg_dhdControlCrystal'}) && (isNil 'btk_sg_playerIsBusy') && (isNil {_target getVariable 'btk_sg_dhdIsDialing'}) && (isNil {_target getVariable 'btk_sg_dhdIsConnected'})"];
					_actionTakeControlCrystal = _dhd addAction [format[("<t>" + ("Take DHD control crystal") + "</t>")], "btk_sg\action_dhd.sqf", ["take"], 12996, false, false, "", "(player distance (_target modelToWorld [0, -0.7, -0.5]) < 1.5) && (isNil 'btk_sg_playerIsInteracting') && !(isNil {_target getVariable 'btk_sg_dhdControlCrystal'}) && (isNil 'btk_sg_playerIsBusy') && (isNil {_target getVariable 'btk_sg_dhdIsDialing'}) && (isNil {_target getVariable 'btk_sg_dhdIsConnected'})"];
					_actionDiagnostic = _dhd addAction [format[("<t>" + ("DHD Diagnostic") + "</t>")], "btk_sg\action_dhd.sqf", ["diagnostic"], 12995, false, false, "", "(player distance (_target modelToWorld [0, -0.7, -0.5]) < 1.5) && (isNil 'btk_sg_playerIsInteracting') && (isNil 'btk_sg_playerIsBusy') && (isNil {_target getVariable 'btk_sg_dhdIsDialing'})"];
				
					_actions = _actions + [_actionCloseWormhole, _actionAbortDialing, _actionRepairDHD, _actionFixSoftware, _actionHackSoftware, _actionInstallControlCrystal, _actionTakeControlCrystal, _actionDiagnostic];
				
				} else {
				
					// Acions for WALTER :-)
					_actionCloseWormhole = _dhd addAction [format[("<t color='#ff0000'>" + ("Close wormhole") + "</t>")], "btk_sg\action_dhd.sqf", ["close"], 13002, false, false, "", "(isNil 'btk_sg_playerIsInteracting') && (isNil 'btk_sg_playerIsBusy') && !(isNil {_target getVariable 'btk_sg_dhdIsConnectedTo'})"];
					_actionAbortDialing = _dhd addAction [format[("<t color='#ff0000'>" + ("Abort dialing sequence") + "</t>")], "btk_sg\action_dhd.sqf", ["abort"], 13001, false, false, "", "(isNil 'btk_sg_playerIsInteracting') && (isNil 'btk_sg_playerIsBusy') && !(isNil {_target getVariable 'btk_sg_dhdIsDialing'}) && (isNil {_target getVariable 'btk_sg_dhdIsConnected'})"];
					_actionRepairDHD = _dhd addAction [format[("<t color='#ffa700'>" + ("Repair DHD") + "</t>")], "btk_sg\action_dhd.sqf", ["repair"], 13000, false, false, "", "((damage _target) > 0.01) && (isNil 'btk_sg_playerIsInteracting') && (isNil 'btk_sg_playerIsBusy') && (isNil {_target getVariable 'btk_sg_dhdIsDialing'}) && (isNil {_target getVariable 'btk_sg_dhdIsConnected'})"];
					//_actionHackSoftware = _dhd addAction [format[("<t>" + ("Hack DHD software") + "</t>")], "btk_sg\action_dhd.sqf", ["hack"], 12999, false, false, "", "!(isNil {_target getVariable 'btk_sg_dhdSoftware'}) && (isNil 'btk_sg_playerIsInteracting') && (isNil 'btk_sg_playerIsBusy') && (isNil {_target getVariable 'btk_sg_dhdIsDialing'}) && (isNil {_target getVariable 'btk_sg_dhdIsConnected'})"];
					//_actionFixSoftware = _dhd addAction [format[("<t color='#ffa700'>" + ("Fix DHD software") + "</t>")], "btk_sg\action_dhd.sqf", ["fix"], 12998, false, false, "", "(isNil {_target getVariable 'btk_sg_dhdSoftware'}) && (isNil 'btk_sg_playerIsInteracting') && (isNil 'btk_sg_playerIsBusy') && (isNil {_target getVariable 'btk_sg_dhdIsDialing'}) && (isNil {_target getVariable 'btk_sg_dhdIsConnected'})"];
					//_actionInstallControlCrystal = _dhd addAction [format[("<t>" + ("Install DHD control crystal") + "</t>")], "btk_sg\action_dhd.sqf", ["install"], 12997, false, false, "", "(isNil 'btk_sg_playerIsInteracting') && (isNil {_target getVariable 'btk_sg_dhdControlCrystal'}) && (isNil 'btk_sg_playerIsBusy') && (isNil {_target getVariable 'btk_sg_dhdIsDialing'}) && (isNil {_target getVariable 'btk_sg_dhdIsConnected'})"];
					//_actionTakeControlCrystal = _dhd addAction [format[("<t>" + ("Take DHD control crystal") + "</t>")], "btk_sg\action_dhd.sqf", ["take"], 12996, false, false, "", "(isNil 'btk_sg_playerIsInteracting') && !(isNil {_target getVariable 'btk_sg_dhdControlCrystal'}) && (isNil 'btk_sg_playerIsBusy') && (isNil {_target getVariable 'btk_sg_dhdIsDialing'}) && (isNil {_target getVariable 'btk_sg_dhdIsConnected'})"];
					_actionDiagnostic = _dhd addAction [format[("<t>" + ("DHD Diagnostic") + "</t>")], "btk_sg\action_dhd.sqf", ["diagnostic"], 12995, false, false, "", "(isNil 'btk_sg_playerIsInteracting') && (isNil 'btk_sg_playerIsBusy') && (isNil {_target getVariable 'btk_sg_dhdIsDialing'})"];
					
					_actions = _actions + [_actionCloseWormhole, _actionAbortDialing, _actionRepairDHD, _actionDiagnostic];
				
				};
				
				while {((player distance _dhd) < 100)} do { sleep 5; };
				
				{ _dhd removeAction _x; } forEach _actions;

			};

		};
		
	} forEach btk_planets;


	//--- Default player actions
	player addAction [format[("<t color='#ff0000'>" + ("Cancel") + "</t>")], "btk_sg\action_dhd.sqf", ["cancel"], 18000, false, false, "", "!(isNil 'btk_sg_playerIsInteracting')"];

};


if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=== btk_sg_fnc_dhdInit : Initializing %1 (planet address: %2, planet name: %3, planet code: %4, has iris: %5, iris code: %6)...", _dhd, _planetAddress, _planetName, _planetCode, _planetHasIris, _planetIrisCode]; };


// DHD already initialized
if (!(isNil {_dhd getVariable 'btk_sg_dhdInit'})) exitWith {
	diag_log text format["=! btk_sg_fnc_dhdInit : %1 is already initialized!", _dhd];
};


// Default values local
_dhd setVariable ["btk_sg_dhdInit", true, false];


// Planet data
if (isNil {_dhd getVariable "btk_sg_dhdPlanetAddress"}) then { _dhd setVariable ["btk_sg_dhdPlanetAddress", _planetAddress, false]; };
if (isNil {_dhd getVariable "btk_sg_dhdPlanetCode"}) then { _dhd setVariable ["btk_sg_dhdPlanetCode", _planetCode, false]; };
if (isNil {_dhd getVariable "btk_sg_dhdPlanetName"}) then { _dhd setVariable ["btk_sg_dhdPlanetName", _planetName, false]; };
if (isNil {_dhd getVariable "btk_sg_dhdPlanetHasIris"}) then { _dhd setVariable ["btk_sg_dhdPlanetHasIris", _planetHasIris, false]; };
if (isNil {_dhd getVariable "btk_sg_dhdPlanetIrisCode"}) then { _dhd setVariable ["btk_sg_dhdPlanetIrisCode", _planetIrisCode, false]; };


// DHD properties
if (isNil {_dhd getVariable "btk_sg_dhdControlCrystal"}) then { _dhd setVariable ["btk_sg_dhdControlCrystal", true, false]; };
if (isNil {_dhd getVariable "btk_sg_dhdPower"}) then { _dhd setVariable ["btk_sg_dhdPower", 100, false]; };
if (isNil {_dhd getVariable "btk_sg_dhdSoftware"}) then { _dhd setVariable ["btk_sg_dhdSoftware", true, false]; };


//(player distance (_target modelToWorld [0, -0.7, 0]) < 0.9) && (isNil {_target getVariable 'btk_sg_dhd_isBusy'}) && ((_target getVariable 'btk_sg_dhd_controlcrystal') == 0) && !(isNil {player getVariable 'btk_sg_player_hasControlCrystal'})


//--- Find nearest gate
_nearGates = nearestObjects [(getPosATL _dhd), ["DSF_Stargate_MilkyWay"], 20];


// If there is none, wait for one
if ((count _nearGates) < 1) then {
	waitUntil {((count (nearestObjects [(getPosATL _dhd), ["DSF_Stargate_MilkyWay"], 20])) > 0)};
};


// ???
//   ^ lol
_nearGatesNotOccupied = [];

{
	if (isNil {_x getVariable 'btk_sg_gateDhd'}) then { _nearGatesNotOccupied = _nearGatesNotOccupied + [_x]; };
} forEach _nearGates;


// No gates available
if ((count _nearGatesNotOccupied) < 1) exitWith {};


_gate = (_nearGatesNotOccupied select 0);



// - GATE LIGHT REMOVED FROM HERE -



// Set variables
_dhd setVariable ["btk_sg_dhdGate", _gate, true];
_gate setVariable ["btk_sg_gateDhd", _dhd, true];


//--- Remote DHDs
if ((count btk_planets) < 1) then { waitUntil {((count btk_planets) > 0)}; };

{

	private ["_remoteDhd", "_remotePlanetAddress", "_remotePlanetCode", "_remotePlanetName", "_remotePlanetHasIris", "_remotePlanetIrisCode"];

	_remoteDhd = (_x select 0);
	_remotePlanetAddress = (_x select 1);
	_remotePlanetCode = (_x select 2);
	_remotePlanetName = (_x select 3);
	_remotePlanetHasIris = (_x select 4);
	_remotePlanetIrisCode = (_x select 5);

	// Only if not self
	if (_remoteDhd != _dhd) then {

		if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=== btk_sg_fnc_dhdInit : Linking DHD %1 with %2...", _dhd, _remoteDhd]; };

		_dhd addAction [format[("<t color='#8bd661'>" + ("Dial %1") + "</t>"), _remotePlanetName], "btk_sg\action_dhd.sqf", ["dial", [_dhd, _planetAddress, _planetCode, _planetName, _planetHasIris], [_remoteDhd, _remotePlanetAddress, _remotePlanetCode, _remotePlanetName, _remotePlanetHasIris]], _dhdActionIndex, false, false, "", "(player distance (_target modelToWorld [0, -0.7, 0]) < 1) && ((damage _target) < 0.2) && (isNil 'btk_sg_playerIsInteracting') && (isNil 'btk_sg_playerIsBusy') && !(isNil {_target getVariable 'btk_sg_dhdSoftware'}) && !(isNil {_target getVariable 'btk_sg_dhdControlCrystal'}) && (isNil {_target getVariable 'btk_sg_dhdIsDialing'}) && (isNil {_target getVariable 'btk_sg_dhdIsConnected'})"];
		_dhdActionIndex = _dhdActionIndex - 1;
		
	};
	
} forEach btk_planets;


if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=====> btk_sg_fnc_dhdInit : %1 (%2, %3) initializied!", _dhd, _planetCode, _planetName]; };


true;