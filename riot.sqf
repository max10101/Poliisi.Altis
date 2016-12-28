_array = Cityarray;
_City = selectRandom _array;
_maxcivs = 12;
_i = 0;
_dist = 5;
_unitArray = [];

While {_i < _maxcivs} do {
_i = _i + 1;
_pos = [(getpos _city select 0)+_dist-random(_dist*2),(getpos _city select 1)+_dist-random(_dist*2),0];
_Spawn = [_pos] call CrimRiotInit;
_UnitArray = _UnitArray + [_spawn];
sleep 0.1;
};
{_x execvm "unitRiot.sqf"} foreach _unitArray;
sleep 2;
//add in random unit movements here
//also set missionstatus array properly
MissionStatus = ["RIOT",_unitarray,[_city],"Init"];
publicvariable "MissionStatus";
[[_city, _unitarray, "RIOT"],"Briefing.sqf"] RemoteExec ["ExecVM",0];
sleep 5;
[West,["RIOT"],["Quell the riots","Arrest suspects"],(getpos _city),"ASSIGNED",3,true] call BIS_fnc_taskCreate;
["RIOT",true] call BIS_fnc_taskSetAlwaysVisible;
CurrentTaskArray = ["RIOT"];