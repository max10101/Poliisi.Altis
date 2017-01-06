Sleep 30 + random 30;

_missions = ["CHASE","RIOT","ROBBERY","CHASE"];
_missions = _missions - [LastMission];
_mission = SelectRandom _Missions;
LastMission = _mission;

IF (_mission == "CHASE") then {[] execvm "chase.sqf"};
IF (_mission == "RIOT") then {[] execvm "riot.sqf"};
IF (_mission == "ROBBERY") then {[] execvm "robbery.sqf"};
