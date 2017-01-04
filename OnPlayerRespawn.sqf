sleep 1;
player enablefatigue false;
player addeventhandler ["Killed",{_this call PlayerKilledEH}];
[player] execvm "spikestrip.sqf";
SpikeStripSet = false;
player addAction["<img image='HG_SWSS\UI\money.paa' size='1.5'/><t color='#FF0000'>Give Money</t>",{HG_CURSOR_OBJECT = cursorObject; createDialog "HG_GiveMoney"},"",0,false,false,"",'(alive player) AND (IsPlayer CursorObject) AND (alive cursorObject) AND (player distance cursorObject < 2) AND !dialog'];
