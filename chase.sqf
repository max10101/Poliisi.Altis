_Array = ChaseArray;
_3way = false;
_race = false;
_man2 = objnull;
_group2 = objnull;
_wp1 = SelectRandom _Array;
_array = _array - [_wp1];
_wp2 = SelectRandom _Array;
_array = _array - [_wp2];
_wp3 = SelectRandom _Array;

IF (_wp1 distance _wp2 < MinChaseDistance) then {_3way = true};
_man = [getpos _wp1] call CrimCarInit;
_group = group _man;
_vehicle = vehicle _man;
sleep 1;
IF (([typeof _vehicle] in ["poliisi_sportscar1","poliisi_sportscar2","poliisi_sportscar3"]) && (Random 1 > 0.7)) then {_race = true;};
IF (_race) then {_man2 = [getpos _wp1] call CrimCarInit};

sleep 1;
_wp = _group addwaypoint [getpos _wp2,0];
[_group,0] setwaypointtype "MOVE";
_group setspeedmode "FULL";

IF (_race) then {
_wp = _group2 addwaypoint [getpos _wp2,0];
[_group2,0] setwaypointtype "MOVE";
_group2 setspeedmode "FULL";
};


if (_3way) then {
  _group addwaypoint [getpos _wp3,5,1];
  [_group,1] setwaypointtype "MOVE";
  [_group,1] setwaypointstatements ["true",""];
  IF (_race) then {
    _group2 addwaypoint [getpos _wp3,5,1];
    [_group2,1] setwaypointtype "MOVE";
    [_grou2p,1] setwaypointstatements ["true",""];
  };
} else {
  [_group,1] setwaypointstatements ["true","this setvariable [""arrested"",true,true];FailChase = [EnemyDriver,EnemyWP2];Publicvariable ""FailChase"""];
  NewMission = ["Chase",EnemyWP1,EnemyWP2];
  Publicvariable "NewMission";
  IF (_race) then {
     [_group2,1] setwaypointstatements ["true","this setvariable [""arrested"",true,true];FailChase = [EnemyDriver,EnemyWP2];Publicvariable ""FailChase"""];
    NewMission = ["Chase",EnemyWP1,EnemyWP2];
    Publicvariable "NewMission";
  };
};

MissionStatus = ["CHASE",[_man],[_wp1,_wp2],"Init"]
IF (_race) then {MissionStatus set [1,[_man,_man2]];MissionStatus set [0,"RACE"]};
IF (_3way) then {MissionStatus set [2,[_wp1,_wp2,_wp3]]};
Publicvariable "MissionStatus";
