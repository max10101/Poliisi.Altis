(_this select 0) removeaction (_this select 2);
[[_this select 0,_this select 1,_this select 2], "ArrestFnc"] call BIS_fnc_MP;
IF (random 1 > 0.5) then {
[_this select 1,[SelectRandom PSI_ArresterSounds,50,1]] remoteExec ["Say3D",0];
} else {
(SelectRandom PSI_ArrestSounds) remoteExec ["PSI_PlaySound",0];
};