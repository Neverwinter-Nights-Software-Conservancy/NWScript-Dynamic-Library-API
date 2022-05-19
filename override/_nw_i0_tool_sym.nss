//::///////////////////////////////////////////////
//:: Dynamic Tool Library Symbols v1.0
//:: _nw_i0_tool_sym.nss
//:: Copyright (c) 2003 Francois Guimond
//:://////////////////////////////////////////////
/*
    This file contains all the symbols used to
    communicate with dl_i0_tool.
*/
//:://////////////////////////////////////////////
//:: Created By: Francois Guimond
//:: Created On: Jan 25, 2003
//:://////////////////////////////////////////////

// library symbol
string SYM_NW_I0_TOOL = "dl_i0_tool";

// int HasItem(object oCreature, string s);
int SYM_HAS_ITEM = 0x00;
// void TakeGold(int nAmount, object oGoldHolder, int bDestroy=TRUE);
int SYM_TAKE_GOLD = 0x01;
// int HasGold(int nAmount, object oGoldHolder);
int SYM_HAS_GOLD = 0x02;
// int AutoDC(int DC, int nSkill, object oTarget);
int SYM_AUTO_DC = 0x03;
// void DoGiveXP(string sJournalTag, int nPercentage, object oTarget, int QuestAlignment=ALIGNMENT_NEUTRAL);
int SYM_DO_GIVE_XP = 0x04;
// void RewardPartyGP(int GP, object oTarget,int bAllParty=TRUE);
int SYM_REWARD_PARTY_GP = 0x05;
// void RewardPartyXP(int XP, object oTarget,int bAllParty=TRUE);
int SYM_REWARD_PARTY_XP = 0x06;
// int CheckPartyForItem(object oMember, string sItem);
int SYM_CHECK_PARTY_FOR_ITEM = 0x07;

