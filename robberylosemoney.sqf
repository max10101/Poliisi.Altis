If (!IsServer) Exitwith {};
_pos = getpos GetawayCar;
IF (vehicle GetawayDriver != GetawayCar) exitwith {};
waituntil {!Alive GetawayDriver OR !Canmove GetawayCar OR (GetawayCar distance _pos) > 100};
IF (!Alive GetawayDriver OR !Canmove GetawayCar) exitwith {};
NewMoney = NewMoney - 2000;publicvariable "NewMoney";
_SITREP = [[toUpper format ["HQ: SUSPECTS HAVE TAKEN THE MONEY %1 AND ARE FLEEING",_pos call BIS_fnc_locationDescription],"align = 'center' size = '1.0'","#2A3DFF"]];
[_SITREP,0.015 * safeZoneW + safeZoneX,0.015 * safeZoneH + safeZoneY,false] remoteExec ["BIS_fnc_typeText2",0];
