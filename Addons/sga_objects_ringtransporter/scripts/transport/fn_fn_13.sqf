private ["_group","_ring"];

_group = units (_this select 1);
_ring = (_this select 0);

if (player in _group) then { _group = _group - [player]; };

{
	_x domove [(getPos _ring) select 0, (getPos _ring) select 1];
} foreach _group;

true