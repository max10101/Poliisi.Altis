Money = 1500;
NewMoney = 0;
sleep 1;
// ADD ENIGMAS CIVILIAN OCCUPATION SYSTEM AND TRAFFIC SCRIPTS
_del = objnull;
Cartypes = ["PSI_sportscar1","PSI_sportscar2","PSI_sportscar3","C_Offroad_01_F","C_SUV_01_F","C_Van_01_transport_F"];
Enemytypes = ["C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_p_beggar_F","C_man_polo_4_F_afro","C_man_shorts_4_F_asia","c_nikos","c_orestes"];
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
Debug = true;

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

//mission status should be [TYPE , PERPS TO BE ARRESTED, WP/Positions , STATUS ("Init","Ongoing","Completed","None")] 
MissionStatus = ["None",[],[],"None"];

//MISSION STATES ARE NONE, INIT, ONGOING, COMPLETED

while {true} do {

sleep 5;

	Switch (MissionStatus select 3) do {
		Case "Init" : {
		systemchat "init";
			MissionStatus set [3,"Ongoing"];
			//MissionStatus execVM "Briefing.sqf";
		};
	
		Case "Ongoing" : {
		systemchat "ongoing";
			private ["_man","_i"];
			for [{_i=0},{_i<(count (MissionStatus select 1))},{_i=_i+1}] do {
				_man = (MissionStatus select 1) select _i;
				
				IF ((!(alive _man)) || (_man getvariable ["arrested",false])) then {_tmp = (MissionStatus select 1) - [_man];MissionStatus set [1,_tmp];IF (Debug) then {Systemchat format ["%1 removed from MissionStatus due to killed/arrested - %2",_man,MissionStatus select 1]}};
				
			};
			
			IF (count (MissionStatus select 1) <= 0) then {
				MissionStatus set [3,"Completed"];
			};
			
		};	
	
		Case "Completed" : {
		systemchat "completed";
			//MissionStatus execVM "Debriefing.sqf";
			MissionStatus set [3,"None"];
		};
	
		Case "None" : {
		systemchat "none";
			//MissionStatus execVM "NewMission.sqf";
		};
	
		Default {sleep 1;systemchat "default";};
	};
};
