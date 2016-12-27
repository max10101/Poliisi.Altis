_array = Cityarray;
_City = selectRandom _array;
_maxcivs = 12;
_i = 0;
_dist = 5;
_unitArray = [];
player setpos (getpos _city);
While {_i < _maxcivs} do {
_i = _i + 1;
_pos = [(getpos _city select 0)+_dist-random(_dist*2),(getpos _city select 1)+_dist-random(_dist*2),0];
_Spawn = [_pos] call CrimRiotInit;
_UnitArray = _UnitArray + [_spawn];
sleep 1;
};
{_x execvm "unitRiot.sqf"} foreach _unitArray;

//add in random unit movements here
//also set missionstatus array properly
MissionStatus set [1,_unitArray];