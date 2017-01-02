IF (count _this == 1) then {
IF (!IsNull SpikeStrip) then {
IF (Alive SpikeStrip) then {SpikeStrip setdamage 1};
};
SpikeStripSet = false;
SpikeStripDeployed = false;
SpikeStrip = objnull;
_this select 0 addAction["<t color='#FF0000'>Lay Spike Strip</t>","spikestrip.sqf","spikestrip",-1,false,true,"",'player == _target && vehicle player == player && (screenToWorld [0.5,0.5] distance player) < 5 && (screenToWorld [0.5,0.5] distance player) > 1.5 && !SpikeStripSet'];
_this select 0 addAction["<t color='#FF0000'>Deploy Spike Strip</t>","spikestrip.sqf","deploy",-1,false,true,"",'player == _target && SpikeStripSet && !SpikeStripDeployed'];
_this select 0 addAction["<t color='#FF0000'>Retract Spike Strip</t>","spikestrip.sqf","retract",-1,false,true,"",'player == _target && SpikeStripDeployed'];

} else {

_target = _this select 0;
_caller = _this select 1;
_action = _this select 2;
_type = _this select 3;

IF (_type in ["spikestrip"]) then {
_pos = (screenToWorld [0.5,0.5]);
_obj = "Land_Razorwire_F" createvehicle _pos;
_obj setpos _pos;
_obj setdir (getdir _caller);
_obj setdamage 1;
SpikeStripSet = true;
SpikeStrip = _obj;
SpikeStrip addAction["<t color='#FF0000'>Retrieve Spike Strip</t>","spikestrip.sqf","retrieve",-1,false,true,"",'true',10];
};

IF (_type in ["deploy"]) then {
_pos = getpos SpikeStrip;
SpikeStrip setdamage 0;
SpikeStrip setpos [_pos select 0,_pos select 1,-1];
SpikeStrip setdamage 0;
SpikeStripDeployed = true;
};

IF (_type in ["retrieve"]) then {
Deletevehicle _target;
SpikeStripSet = false;
SpikeStrip = objnull;
SpikeStripDeployed = false
};

IF (_type in ["retract"]) then {
_pos = getpos SpikeStrip;
IF (!Alive SpikeStrip) then {SpikeStrip setdamage 0};
SpikeStrip setdamage 1;
SpikeStrip setpos [_pos select 0,_pos select 1,0];
SpikeStripDeployed = false;
};

};