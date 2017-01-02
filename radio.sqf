_allsounds = PSI_104Sounds + PSI_BackupSounds + PSI_CautionSounds + PSI_KilledSounds + PSI_PursuitSounds + PSI_RespondSounds + PSI_SuspectDownSounds + PSI_AmbientSounds;
while {IsServer} do {
sleep 12 + random 16;
[radio,[SelectRandom _allsounds,10,1]] remoteExec ["Say3D",0];
};