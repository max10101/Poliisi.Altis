_allsounds = PSI_104Sounds + PSI_BackupSounds + PSI_CautionSounds + PSI_KilledSounds + PSI_PursuitSounds + PSI_RespondSounds + PSI_SuspectDownSounds + PSI_AmbientSounds;
while {IsServer} do {
sleep 6 + random 8;
[radio,SelectRandom _allsounds] remoteExec ["Say3D",0];
};