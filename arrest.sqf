(_this select 0) removeaction (_this select 2);
IF (alive (_this select 0)) then {
(_this select 0) setvariable ["arrested",true,true];
NewMoney = NewMoney + 500;Publicvariable "NewMoney";
removeallweapons (_this select 0);
(_this select 0) playmoveNow "AmovPercMstpSsurWnonDnon";
};

//Acts_ExecutionVictim_Loop