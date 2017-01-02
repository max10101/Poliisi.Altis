_man = _this;
_pos = getpos _man;
_weaps = [["PSI_ROCK_MUZZLE","PSI_ROCK_MUZZLE","PSI_ROCK_MAG"],["PSI_ROCK_MUZZLE","PSI_ROCK_MUZZLE","PSI_ROCK_MAG"],["PSI_CAN_MUZZLE","PSI_CAN_MUZZLE","PSI_CAN_MAG"],["PSI_MOLOTOV_MUZZLE","PSI_MOLOTOV_MUZZLE","PSI_MOLOTOV_MAG"]];
_man addmagazine "PSI_ROCK_MAG";
_man addmagazine "PSI_CAN_MAG";
_man addmagazine "PSI_MOLOTOV_MAG";
_man addeventhandler ["FIRED",{
private ["_mag","_man"];
_mag = _this select 5;
_man = _this select 0;
IF (_mag in ["PSI_MOLOTOV_MAG","PSI_CAN_MAG","PSI_ROCK_MAG"]) then {_man addmagazine _mag};
}];
Sleep (random 5);
_throw = [_man,_weaps] spawn {
private ["_man","_weaps"];
_man = _this select 0;
_weaps = _this select 1;
While {!(_man getvariable ["armed",false]) && Alive _man && !(_man getvariable ["Arrested",false])} do {
WaitUntil{UnitReady _man OR (! Alive _man) OR (_man getvariable ["Arrested",false])};
_man dowatch [(getpos _man select 0)+5-(random 10),(getpos _man select 1)+5-(random 10),0];
sleep 2;
_man fire (selectRandom _weaps);
sleep 2+(random 3);
};
};
_run = [_man,_pos] spawn {
_man = _this select 0;
_pos = _this select 1;
While {Alive _man && !(_man getvariable ["Arrested",false])} do {
sleep 1;
_man domove [(getpos _man select 0)+15-(random 30),(getpos _man select 1)+15-(random 30),0];
sleep 10;
IF (UnitReady _man OR (! Alive _man) OR (_man getvariable ["Arrested",false])) then {sleep 2+(random 6)} else {sleep 5+random 12};
};
};