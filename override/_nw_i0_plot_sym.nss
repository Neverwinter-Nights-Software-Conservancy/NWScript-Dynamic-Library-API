//::///////////////////////////////////////////////
//:: Dynamic Plot Library Symbols v1.0
//:: _nw_i0_plot_sym.nss
//:: Copyright (c) 2003 Francois Guimond
//:://////////////////////////////////////////////
/*
    This file contains all the symbols used to
    communicate with dl_i0_plot.
*/
//:://////////////////////////////////////////////
//:: Created By: Francois Guimond
//:: Created On: Jan 25, 2003
//:://////////////////////////////////////////////

// library symbol
string SYM_NW_I0_PLOT = "dl_i0_plot";

// int GetCanCastHealingSpells(object oPC) ;
int SYM_GET_CAN_CAST_HEALING_SPELLS = 0x00;
// int DoOnce();
int SYM_DO_ONCE = 0x01;
// void DebugSpeak(string s);
int SYM_DEBUG_SPEAK = 0x02;
// object GetMyMaster();
int SYM_GET_MY_MASTER = 0x03;
// int IsRecall();
int SYM_IS_RECALL = 0x04;
// void DimensionHop(object oTarget);
int SYM_DIMENSION_HOP = 0x05;
// int CanSeePlayer();
int SYM_CAN_SEE_PLAYER = 0x06;
// void EscapeArea(int bRun = TRUE, string sTag="NW_EXIT");
int SYM_ESCAPE_AREA = 0x07;
// int HasItem(object oCreature, string s);
int SYM_HAS_ITEM = 0x08;
// void TakeGold(int nAmount, object oGoldHolder, int bDestroy=TRUE);
int SYM_TAKE_GOLD = 0x09;
// object GetNearestPC();
int SYM_GET_NEAREST_PC = 0x0A;
// void SetIsEnemy(object oTarget);
int SYM_SET_IS_ENEMY = 0x0B;
// int AutoDC(int DC, int nSkill, object oTarget);
int SYM_AUTO_DC = 0x0C;
// void AutoAlignG(int DC, object oTarget);
int SYM_AUTO_ALIGN_G = 0x0D;
// void AutoAlignE(int DC, object oTarget);
int SYM_AUTO_ALIGN_E = 0x0E;
// void DoGiveXP(string sJournalTag, int nPercentage, object oTarget, int QuestAlignment=ALIGNMENT_NEUTRAL);
int SYM_DO_GIVE_XP = 0x0F;
// void RewardXP(string sJournalTag, int nPercentage, object oTarget, int QuestAlignment=ALIGNMENT_NEUTRAL, int bAllParty=TRUE);
int SYM_REWARD_XP = 0x10;
// void RewardGP(int GP, object oTarget,int bAllParty=TRUE);
int SYM_REWARD_GP = 0x11;
// int CheckCharismaMiddle();
int SYM_CHECK_CHARISMA_MIDDLE = 0x12;
// int CheckCharismaNormal();
int SYM_CHECK_CHARISMA_NORMAL = 0x13;
// int CheckCharismaLow();
int SYM_CHECK_CHARISMA_LOW = 0x14;
// int CheckCharismaHigh();
int SYM_CHECK_CHARISMA_HIGH = 0x15;
// int CheckIntelligenceLow();
int SYM_CHECK_INTELLIGENCE_LOW = 0x16;
// int CheckIntelligenceNormal();
int SYM_CHECK_INTELLIGENCE_NORMAL = 0x17;
// int CheckIntelligenceHigh();
int SYM_CHECK_INTELLIGENCE_HIGH = 0x18;
// int CheckWisdomHigh();
int SYM_CHECK_WISDOM_HIGH = 0x19;
// int GetWisdom(object oTarget);
int SYM_GET_WISDOM = 0x1A;
// int GetIntelligence(object oTarget);
int SYM_GET_INTELLIGENCE = 0x1B;
// int GetCharisma(object oTarget);
int SYM_GET_CHARISMA = 0x1C;
// int GetNumItems(object oTarget,string sItem);
int SYM_GET_NUM_ITEMS = 0x1D;
// void GiveNumItems(object oTarget,string sItem,int nNumItems);
int SYM_GIVE_NUM_ITEMS = 0x1E;
// void TakeNumItems(object oTarget,string sItem,int nNumItems);
int SYM_TAKE_NUM_ITEMS = 0x1F;
// void PlayCharacterTheme(int nTheme);
int SYM_PLAY_CHARACTER_THEME = 0x20;
// void PlayOldTheme();
int SYM_PLAY_OLD_THEME = 0x21;
// int GetPLocalInt(object oPC,string sLocalName);
int SYM_GET_P_LOCAL_INT = 0x22;
// void SetPLocalInt(object oPC,string sLocalName, int nValue);
int SYM_SET_P_LOCAL_INT = 0x23;
// void RemoveEffects(object oDead);
int SYM_REMOVE_EFFECTS = 0x24;

// int HasGold(int nAmount, object oGoldHolder);
int SYM_HAS_GOLD = 0x25;
// float GetReactionAdjustment(object oTarget);
int SYM_GET_REACTION_ADJUSTMENT = 0x26;
// void AdjustFactionReputation(object oTargetCreature, object oMemberOfSourceFaction, int nAdjustment);
int SYM_ADJUST_FACTION_REPUTATION = 0x27;
// void EscapeViaTeleport(object oFleeing);
int SYM_ESCAPE_VIA_TELEPORT = 0x28;

