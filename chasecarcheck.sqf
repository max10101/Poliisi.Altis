_manarr = _This select 0;
_car = _this select 1;
_driver = driver _car;

waituntil {
!(Alive _driver) || (_driver getvariable ["Arrested",false]) || (vehicle _driver != _car)
};
if (!(Alive _driver) || (_driver getvariable ["Arrested",false])) exitwith {};
IF ([_driver,AllPlayers,250] call DistCheck) then {
[vehicle (([_driver,AllPlayers,250] call DistCheckUnit) select 1),[SelectRandom PSI_BullhornSounds,100,1]] remoteExec ["Say3D",0];
} else {
_SITREP = [[toUpper format ["HQ: SUSPECT IS ON FOOT %1",(getpos _driver) call BIS_fnc_locationDescription],"align = 'center' size = '1.0'","#2A3DFF"]];
[_SITREP,0.015 * safeZoneW + safeZoneX,0.015 * safeZoneH + safeZoneY,false] remoteExec ["BIS_fnc_typeText2",0];
}