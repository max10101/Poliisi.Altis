// _args = [MissionStatus,time - MissionStartTime,MissionDebrief]
_unitsArrested = (_this select 2) select 0;
_unitsKilled = (_this select 2) select 1;
_money = _this select 3;
_time = _this select 1;
_str1 = format["Suspects Arrested: %1",_unitsArrested];
_str2 = format["Suspects Killed: %1",_unitsKilled];
_str3 = format["Money earned: $%1",_money];
_str4 = format["Mission Time: %1",[_time,"MM:SS"] call BIS_fnc_secondsToString];
[[
		["Mission Complete!","align = 'center' shadow = '1' size = '0.7' font='PuristaBold'"],
		["","<br/>"],
		[_str1,"align = 'center' shadow = '0' size = '0.7'","#df3030"],
		["","<br/>"],
		[_str2,"align = 'center' shadow = '0' size = '0.7'","#df3030"],
		["","<br/>"],
		[_str3,"align = 'center' shadow = '0' size = '0.7'","#df3030"],
		["","<br/>"],
		[_str4,"align = 'center' shadow = '0' size = '0.7'","#df3030"]
]] spawn BIS_fnc_typeText2;
playsound "Debrief";