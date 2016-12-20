_obj = ["Stop and arrest the suspect","Speeding vehicle",""]
IF (_race) then {_obj = ["Stop and arrest the suspects","Racing vehicles",""]};
[West,["CHASE"],_obj,(getpos _wp1),"ASSIGNED",3,true] call BIS_fnc_taskCreate;


player sidechat format ["WE'VE GOT REPORTS OF A FLEEING SUSPECT NEAR %2",_this select 0,(_this select 1) Getvariable "name"];
sleep 5;
IF (Count _this <= 3) then {player sidechat format ["REPORTS INDICATE HE IS HEADED TO %1",(_this select 2) getvariable "name"]} else {player sidechat format ["REPORTS INDICATE HE IS HEADED TO %1 GOING THROUGH %2",(_this select 2) getvariable "name",(_this select 3) getvariable "name"];};
