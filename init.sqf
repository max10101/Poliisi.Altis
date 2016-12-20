Money = 1500;
NewMoney = 0;


Cartypes = ["poliisi_sportscar1","poliisi_sportscar2","poliisi_sportscar3","C_Offroad_01_F","C_SUV_01_F","C_Van_01_transport_F"];
Enemytypes = ["C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_p_beggar_F","C_man_polo_4_F_afro","C_man_shorts_4_F_asia","poliisi_criminal_1","poliisi_criminal_2","poliisi_criminal_boss"];
Missiontypes = ["Chase.sqf","chase.sqf","chase.sqf"];
//Missiontypes = ["Chase.sqf","Robbery.sqf","Riot.sqf"];
Chasearray = [City,City_1,City_2];
FailChase = [];
FailRiot = [];
FailRobbery = [];
NewMission = [];
MissionComplete = true;
MinChaseDistance = 15;
SuspectOnFoot = False;
SuspectDead = false;
SuspectArrested = false;
_i = 0;
_pay = 0;
Payday = 0;
Debug = false;

//call with [_pos,_unittype,_cartype] call CrimInit OR just [pos] call crimcarinit
CrimCarInit = compile '
params [["_pos",[]],["_unittype",selectRandom EnemyTypes],["_cartype",selectRandom Cartypes]];
private ["_unittype","_cartype","_group","_car","_unit"];
_group = creategroup East;
_unit = _group createUnit [_unittype, _pos, ["this addaction [""Arrest"",""arrest.sqf"",true,10]"], 1, "NONE"];

_unit setvariable ["arrested",false,true];
_unit setskill 1;
_unit setskill ["aimingAccuracy",0.3];_man setskill ["aimingshake",0.2];_man setskill ["aimingSpeed",0.8];
_unit setbehaviour "CARELESS";
_unit setcombatmode "BLUE";
_unit addeventhandler ["GetOutMan",{(_this select 0) setbehaviour "COMBAT";(_this select 0) setcombatmode "RED";(_this select 0) setunitposweak "UP"}];

_car = _cartype createvehicle _pos;
_unit assignasdriver _car;
_unit moveindriver _car;
_group addvehicle _car;
_unit
';

IF (true) ExitWith {};
//mission status should be [TYPE , PERPS TO BE ARRESTED, WP/Positions , STATUS ("Init","Ongoing","Completed","None")] 
MissionStatus = ["None",[],[],"None"];

//MISSION STATES ARE NONE, INIT, ONGOING, COMPLETED

while {true} do {
Sleep 5;
	Switch (MissionStatus select 3) do {
		Case "Init" : {
			MissionStatus set [3,"Ongoing"];
			MissionStatus execVM "Briefing.sqf";
		};
	
		Case "Ongoing" : {
			private ["_man","_i","_del"];
			for [{_i=0},{_i<(count (MissionStatus select 1))},{_i=_i+1}] do {
				_man = (MissionStatus select 1) select _i
				IF (!Alive _man OR (_man getvariable "arrested")) then {_del = (MissionStatus select 1) deleteAt _i;IF (Debug) then {Systemchat format ["%1 removed from MissionStatus due to killed/arrested - %2",_del,MissionStatus select 1]};
				
			};
			
			IF (count (MissionStatus select 1) <= 0) then {
				MissionStatus set [3,"Completed"];
			};
			
		};	
	
		Case "Completed" : {
			MissionStatus execVM "Debriefing.sqf";
		};
	
		Case "None" : {
			MissionStatus execVM "NewMission.sqf";
		};
	
		Default {sleep 1};
	};
};
