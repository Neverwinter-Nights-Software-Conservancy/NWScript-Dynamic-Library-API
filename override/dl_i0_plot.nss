//::///////////////////////////////////////////////
//:: Dynamic Plot Library v1.0
//:: dl_i0_plot.nss
//:: Copyright (c) 2003 Francois Guimond
//:://////////////////////////////////////////////
/*
    This file performs all the static calls to the
    plot library from the dynamic library
    interface.
*/
//:://////////////////////////////////////////////
//:: Created By: Francois Guimond
//:: Created On: Jan 25, 2003
//:://////////////////////////////////////////////

#include "dl_i0_core"
#include "_nw_i0_plot"

void main()
{

    switch (PopInt())
    {

        // int GetCanCastHealingSpells(object oPC) ;
        case 0x00: PushInt(GetCanCastHealingSpells(PopObject())); break;

        // int DoOnce();
        case 0x01: PushInt(DoOnce()); break;

        // void DebugSpeak(string s);
        case 0x02: DebugSpeak(PopString()); break;

        // object GetMyMaster();
        case 0x03: PushObject(GetMyMaster()); break;

        // int IsRecall();
        case 0x04: PushInt(IsRecall()); break;

        // void DimensionHop(object oTarget);
        case 0x05: DimensionHop(PopObject()); break;

        // int CanSeePlayer();
        case 0x06: PushInt(CanSeePlayer()); break;

        // void EscapeArea(int bRun = TRUE, string sTag="NW_EXIT");
        case 0x07: EscapeArea(PopInt(), PopString()); break;

        // int HasItem(object oCreature, string s);
        case 0x08: PushInt(HasItem(PopObject(), PopString())); break;

        // void TakeGold(int nAmount, object oGoldHolder, int bDestroy=TRUE);
        case 0x09: TakeGold(PopInt(), PopObject(), PopInt()); break;

        // object GetNearestPC();
        case 0x0A: PushObject(GetNearestPC()); break;

        // void SetIsEnemy(object oTarget);
        case 0x0B: SetIsEnemy(PopObject()); break;

        // int AutoDC(int DC, int nSkill, object oTarget);
        case 0x0C: PushInt(AutoDC(PopInt(), PopInt(), PopObject())); break;

        // void AutoAlignG(int DC, object oTarget);
        case 0x0D: AutoAlignG(PopInt(), PopObject()); break;

        // void AutoAlignE(int DC, object oTarget);
        case 0x0E: AutoAlignE(PopInt(), PopObject()); break;

        // void DoGiveXP(string sJournalTag, int nPercentage, object oTarget, int QuestAlignment=ALIGNMENT_NEUTRAL);
        case 0x0F: DoGiveXP(PopString(), PopInt(), PopObject(), PopInt()); break;

        // void RewardXP(string sJournalTag, int nPercentage, object oTarget, int QuestAlignment=ALIGNMENT_NEUTRAL, int bAllParty=TRUE);
        case 0x10: RewardXP(PopString(), PopInt(), PopObject(), PopInt(), PopInt()); break;

        // void RewardGP(int GP, object oTarget,int bAllParty=TRUE);
        case 0x11: RewardGP(PopInt(), PopObject(), PopInt()); break;

        // int CheckCharismaMiddle();
        case 0x12: PushInt(CheckCharismaMiddle()); break;

        // int CheckCharismaNormal();
        case 0x13: PushInt(CheckCharismaNormal()); break;

        // int CheckCharismaLow();
        case 0x14: PushInt(CheckCharismaLow()); break;

        // int CheckCharismaHigh();
        case 0x15: PushInt(CheckCharismaHigh()); break;

        // int CheckIntelligenceLow();
        case 0x16: PushInt(CheckIntelligenceLow()); break;

        // int CheckIntelligenceNormal();
        case 0x17: PushInt(CheckIntelligenceNormal()); break;

        // int CheckIntelligenceHigh();
        case 0x18: PushInt(CheckIntelligenceHigh()); break;

        // int CheckWisdomHigh();
        case 0x19: PushInt(CheckWisdomHigh()); break;

        // int GetWisdom(object oTarget);
        case 0x1A: PushInt(GetWisdom(PopObject())); break;

        // int GetIntelligence(object oTarget);
        case 0x1B: PushInt(GetIntelligence(PopObject())); break;

        // int GetCharisma(object oTarget);
        case 0x1C: PushInt(GetCharisma(PopObject())); break;

        // int GetNumItems(object oTarget,string sItem);
        case 0x1D: PushInt(GetNumItems(PopObject(), PopString())); break;

        // void GiveNumItems(object oTarget,string sItem,int nNumItems);
        case 0x1E: GiveNumItems(PopObject(), PopString(), PopInt()); break;

        // void TakeNumItems(object oTarget,string sItem,int nNumItems);
        case 0x1F: TakeNumItems(PopObject(), PopString(), PopInt()); break;

        // void PlayCharacterTheme(int nTheme);
        case 0x20: PlayCharacterTheme(PopInt()); break;

        // void PlayOldTheme();
        case 0x21: PlayOldTheme(); break;

        // int GetPLocalInt(object oPC,string sLocalName);
        case 0x22: PushInt(GetPLocalInt(PopObject(), PopString())); break;

        // void SetPLocalInt(object oPC,string sLocalName, int nValue);
        case 0x23: SetPLocalInt(PopObject(), PopString(), PopInt()); break;

        // void RemoveEffects(object oDead);
        case 0x24: RemoveEffects(PopObject()); break;

        // int HasGold(int nAmount, object oGoldHolder);
        case 0x25: PushInt(HasGold(PopInt(), PopObject())); break;

        // float GetReactionAdjustment(object oTarget);
        case 0x26: PushFloat(GetReactionAdjustment(PopObject())); break;

        // void AdjustFactionReputation(object oTargetCreature, object oMemberOfSourceFaction, int nAdjustment);
        case 0x27: AdjustFactionReputation(PopObject(), PopObject(), PopInt()); break;

        // void EscapeViaTeleport(object oFleeing);
        case 0x28: EscapeViaTeleport(PopObject()); break;

    }

}

