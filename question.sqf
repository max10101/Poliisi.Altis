_civ = _this select 0;
IF (!Alive _civ) exitwith {hint "The civilian is unresponsive";_civ removeaction (_this select 2)};
_manarr = MissionStatus select 1;
_man = SelectRandom _manarr;
_direction = [_civ,_man] call BIS_fnc_DirTo;
_compass = _direction call CompassHeading;
_civ globalchat format ["I think I saw somebody by that description %1, just %2 of here",_man call BIS_fnc_locationDescription,_compass];