Sleep 30 + random 30;
_rand = random 1;
IF (_rand < 0.25) then {[] execvm "riot.sqf"};
IF (_rand >= 0.25 && _rand < 0.5) then {[] execvm "robbery.sqf"};
IF (_rand >= 0.5) then {[] execvm "chase.sqf"};