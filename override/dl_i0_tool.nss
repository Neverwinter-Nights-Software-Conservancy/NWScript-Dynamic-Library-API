//::///////////////////////////////////////////////
//:: Dynamic Tool Library v1.0
//:: dl_i0_tool.nss
//:: Copyright (c) 2003 Francois Guimond
//:://////////////////////////////////////////////
/*
    This file performs all the static calls to the
    tool library from the dynamic library
    interface.
*/
//:://////////////////////////////////////////////
//:: Created By: Francois Guimond
//:: Created On: Jan 25, 2003
//:://////////////////////////////////////////////

#include "dl_i0_core"
#include "_nw_i0_tool"

void main()
{

    switch (PopInt())
    {

        // int HasItem(object oCreature, string s);
        case 0x00: PushInt(HasItem(PopObject(), PopString())); break;

        // void TakeGold(int nAmount, object oGoldHolder, int bDestroy=TRUE);
        case 0x01: TakeGold(PopInt(), PopObject(), PopInt()); break;

        // int HasGold(int nAmount, object oGoldHolder);
        case 0x02: PushInt(HasGold(PopInt(), PopObject())); break;

        // int AutoDC(int DC, int nSkill, object oTarget);
        case 0x03: PushInt(AutoDC(PopInt(), PopInt(), PopObject())); break;

        // void DoGiveXP(string sJournalTag, int nPercentage, object oTarget, int QuestAlignment=ALIGNMENT_NEUTRAL);
        case 0x04: DoGiveXP(PopString(), PopInt(), PopObject(), PopInt()); break;

        // void RewardPartyGP(int GP, object oTarget,int bAllParty=TRUE);
        case 0x05: RewardPartyGP(PopInt(), PopObject(), PopInt()); break;

        // void RewardPartyXP(int XP, object oTarget,int bAllParty=TRUE);
        case 0x06: RewardPartyXP(PopInt(), PopObject(), PopInt()); break;

        // int CheckPartyForItem(object oMember, string sItem);
        case 0x07: PushInt(CheckPartyForItem(PopObject(), PopString())); break;

    }

}

