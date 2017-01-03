IF (count _this == 1) then {

_this select 0 addAction["<t color='#FF0000'>GRAB SUSPECT</t>","pullout.sqf","driver",100,true,true,"",'_dir = ([_target,player] call BIS_fnc_relativeDirTo);(_dir >= 240 && _dir <= 300) && !IsNull (driver _target) && (speed _target) < 5 && (vehicle player != _target)',3];
_this select 0 addAction["<t color='#FF0000'>GRAB SUSPECT</t>","pullout.sqf","codriver",100,true,true,"",'_dir = ([_target,player] call BIS_fnc_relativeDirTo);(_dir >= 60 && _dir <= 120) && (count ((crew _target) - [driver _target])) >= 1 && (speed _target) < 5 && (vehicle player != _target)',3];

} else {

_target = _this select 0;
_caller = _this select 1;
_action = _this select 2;
_type = _this select 3;

IF (_type in ["driver"]) then {
(driver _target) action ["Eject", _target];
} else {
((crew _target) - [driver _target]) select 0 action ["Eject", _target];
};
};