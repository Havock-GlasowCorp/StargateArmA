// _hasRamp = nearestObject bla


_debug = true;


_fromDhd = _this select 0;
_toDhd = _this select 1;
_fromGate = _fromDhd getVariable "btk_sg_dhdGate";
_toGate = _toDhd getVariable "btk_sg_dhdGate";
_fromGatePos = (getPosATL _fromDhd);
_objects = [];


// Create the sensor objects
_travelSensor1Pos = (_fromGate modelToWorld [-1, -0.15, -2]);
_travelSensor2Pos = (_fromGate modelToWorld [0, -0.15, -2]);
_travelSensor3Pos = (_fromGate modelToWorld [1, -0.15, -2]);

_travelSensor1 = "Land_Bucket_F" createVehicleLocal [0, 0, 0];
_travelSensor1 hideObject true;
_travelSensor1 setPosATL _travelSensor1Pos;
_travelSensor1 setDir (getDir _fromGate);

_travelSensor2 = "Land_Bucket_F" createVehicleLocal [0, 0, 0];
_travelSensor2 hideObject true;
_travelSensor2 setPosATL _travelSensor2Pos;
_travelSensor2 setDir (getDir _fromGate);

_travelSensor3 = "Land_Bucket_F" createVehicleLocal [0, 0, 0];
_travelSensor3 hideObject true;
_travelSensor3 setPosATL _travelSensor3Pos;
_travelSensor3 setDir (getDir _fromGate);


if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=== btk_sg_fnc_travelSensor : Travel sensor starting for %1...", _fromDhd]; };


// Scan while connected
while {!(isNil {_fromDhd getVariable "btk_sg_dhdIsConnected"}) && !(isNil {_toDhd getVariable "btk_sg_dhdIsConnected"})} do {

	// Is player in range at all?
	waitUntil {((player distance _fromDhd) < 1000)};

	// Get objects
	_nearObjectsBlackList = nearestObjects [_fromGatePos, ["Land_Bucket_F"], 100];
	_nearObjects = (nearestObjects [_fromGatePos, ["Man","Reammobox"], 100] - (_nearObjectsBlackList));

	// Objects found
	if ((count _nearObjects) > 0) then {

		{
		
			// Only NEW and LCOAL
			if ((local _x) && !(_x in _objects)) then {

				if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=== btk_sg_fnc_travelSensor : Monitoring new object: %1 (%2)...", _x, (typeOf _x)]; };

				_objects = _objects + [_x]; // Add to list

				// Spawn flow
				[_x, _fromDhd, _toDhd, _fromGatePos, _toGate, _travelSensor1, _travelSensor2, _travelSensor3] spawn {

					_object = _this select 0;
					_fromDhd = _this select 1;
					_toDhd = _this select 2;
					_fromGatePos = _this select 3;
					_toGate = _this select 4;
					_travelSensor1 = _this select 5;
					_travelSensor2 = _this select 6;
					_travelSensor3 = _this select 7;
					
					waitUntil {(isNil {_fromDhd getVariable "btk_sg_dhdIsConnected"}) || ((_object distance _travelSensor1) < 1.3) || ((_object distance _travelSensor2) < 1.3) || ((_object distance _travelSensor3) < 1.3)};

					//while {!(isNil {_fromDhd getVariable "btk_sg_dhdIsConnected"}) && (((_object distance _travelSensor1) > 1.5) || ((_object distance _travelSensor2) > 1.5) || ((_object distance _travelSensor3) > 1.5))} do {
					//	sleep 0.01;
					//};
					
					if (isNil {_fromDhd getVariable "btk_sg_dhdIsConnected"}) exitWith {};
					_traveling = [_object, _toGate, _fromDhd] call btk_sg_fnc_travel;

				};

			} else {
			
				if (!(local _x)) then { // Not local anymore? remove
					_objects = _objects - [_x];
				};
				
				
				if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=! btk_sg_fnc_travelSensor : No new objects!"]; };


			};
			
		} forEach _nearObjects;

	};

	sleep 30;

};


if (_debug && !(isNil "btk_global_debug")) then { diag_log text format["=====> btk_sg_fnc_travelSensor : Travel sensor ended for %1!", _fromDhd]; };