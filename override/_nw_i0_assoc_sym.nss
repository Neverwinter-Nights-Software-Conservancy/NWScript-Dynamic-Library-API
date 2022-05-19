//::///////////////////////////////////////////////
//:: Dynamic Generic Associate Library Symbols v1.0
//:: _nw_i0_assoc_sym.nss
//:: Copyright (c) 2003 Francois Guimond
//:://////////////////////////////////////////////
/*
    This file contains all the symbols used to
    communicate with dl_i0_assoc.
*/
//:://////////////////////////////////////////////
//:: Created By: Francois Guimond
//:: Created On: Jan 25, 2003
//:://////////////////////////////////////////////

// library symbol
string SYM_NW_I0_ASSOC = "dl_i0_assoc";

// void SpeakQuickChat(string sVoice);
int SYM_SPEAK_QUICK_CHAT = 0x00;
// void DebugSTR(string s);
int SYM_DEBUG_STR = 0x01;
// int IsBusy();
int SYM_IS_BUSY = 0x02;
// void SetIsBusy(int bIsBusy);
int SYM_SET_IS_BUSY = 0x03;
// void DetermineAssociateCombatRound();
int SYM_DETERMINE_ASSOCIATE_COMBAT_ROUND = 0x04;
// void OpenNearestLock();
int SYM_OPEN_NEAREST_LOCK = 0x05;
// void DoFollowMaster();
int SYM_DO_FOLLOW_MASTER = 0x06;
// void GetBehind();
int SYM_GET_BEHIND = 0x07;

