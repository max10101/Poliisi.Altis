(_this select 0) removeaction (_this select 2);
[[_this select 0,_this select 1,_this select 2], "ArrestFnc"] call BIS_fnc_MP;
[_this select 1,[SelectRandom PSI_ArresterSounds,50,1]] remoteExec ["Say3D",0];
IF (random 1 > 0.6) then {
sleep (random 3);
(SelectRandom PSI_ArrestSounds) remoteExec ["PSI_PlaySound",0];
}