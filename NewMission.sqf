Sleep 30 + random 30;
_rand = random 1;
IF (_rand < 0.33) then {[] execvm "riot.sqf"};
IF (_rand >= 0.33) then {[] execvm "chase.sqf"};