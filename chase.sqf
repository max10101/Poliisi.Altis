_Array = ChaseArray;
_3way = false;

_wp1 = SelectRandom _Array;
_array = _array - [_wp1];
_wp2 = SelectRandom _Array;
_array = _array - [_wp2];
_wp3 = SelectRandom _Array;

IF (_wp1 distance _wp2 < MinChaseDistance) then {_3way = true};
_man = [getpos _wp1] call CrimCarInit;
_group = group _man;
sleep 1;
_wp = _group addwaypoint [getpos _wp2,0];
[_group,0] setwaypointtype "MOVE";
_group setspeedmode "FULL";

if (_3way) then {
  _group addwaypoint [getpos _wp3,5,1];
  [_group,1] setwaypointtype "MOVE";
  [_group,1] setwaypointstatements ["true","this setvariable [""arrested"",true,true];
  FailChase = [EnemyDriver,EnemyWP3];Publicvariable ""FailChase"""];
  NewMission = ["Chase",EnemyWP1,EnemyWP2,EnemyWP3];
  Publicvariable "NewMission"
} else {
  [_group,1] setwaypointstatements ["true","this setvariable [""arrested"",true,true];
  FailChase = [EnemyDriver,EnemyWP2];Publicvariable ""FailChase"""];
  NewMission = ["Chase",EnemyWP1,EnemyWP2];
  Publicvariable "NewMission";
};

while {vehicle _man == _car && alive _man && (count FailChase == 0)} do {sleep 1;};
IF (alive _man && (count FailChase == 0)) then {sleep 1;player sidechat "ENGAGIGN";_man setbehaviour "COMBAT";_man disableAI "FSM";_group setcombatmode "RED";_man setunitpos "UP";SuspectOnFoot = true;publicvariable "SuspectOnFoot"};
while {alive _man && !(_man getvariable "arrested") && (count FailChase == 0)} do {sleep 1;};
MissionComplete = true;
