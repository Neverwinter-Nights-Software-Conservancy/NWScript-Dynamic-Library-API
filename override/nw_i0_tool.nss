//::///////////////////////////////////////////////
//::
//:: Tools Include File
//::
//:: NW_I0_TOOL.nss
//::
//:: Copyright (c) 2002 Bioware Corp.
//::
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Neil Flynn with code from
//::             Brent Knowles
//:: Created On: February 12, 2001
//::
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Modified By: Francois Guimond
//:: Modified On: Jan 25, 2003
//:: Converted to a dynamic library.
//:://////////////////////////////////////////////

#include "_nw_i0_tool_sym"

int DC_EASY = 0;
int DC_MEDIUM = 1;
int DC_HARD = 2;
// * this is used by some of the template scripts
// * 100 - this number is the chance of that dialog
// * appearing
int G_CLASSCHANCE = 70;

//::///////////////////////////////////////////////
//:: HasItem
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
      A wrapper to simplify checking for an item.
*/
//:://////////////////////////////////////////////
//:: Created By:        Brent
//:: Created On:        November 2001
//:://////////////////////////////////////////////

int HasItem(object oCreature, string s)
{
    PushObject(oCreature); PushString(s);
    return DynInt(SYM_NW_I0_TOOL, SYM_HAS_ITEM);
}

//::///////////////////////////////////////////////
//:: Take Gold
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Takes nAmount of gold from the object speaking.
    By default, the gold is destroyed.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: November 2001
//:://////////////////////////////////////////////
void TakeGold(int nAmount, object oGoldHolder, int bDestroy=TRUE)
{
    PushInt(nAmount); PushObject(oGoldHolder); PushInt(bDestroy);
    DynCommand(SYM_NW_I0_TOOL, SYM_TAKE_GOLD);
}


//::///////////////////////////////////////////////
//:: HasGold
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks to see if the player has nAmount of gold
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
int HasGold(int nAmount, object oGoldHolder)
{
    PushInt(nAmount); PushObject(oGoldHolder);
    return DynInt(SYM_NW_I0_TOOL, SYM_HAS_GOLD);
}

///////////////////////////////////////////////////////////////////////////////
//
//  AutoDC
//
///////////////////////////////////////////////////////////////////////////////
//  Returns a pass value based on the object's level and the suggested DC
// December 20 2001: Changed so that the difficulty is determined by the
// NPC's Hit Dice
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 13 2001
///////////////////////////////////////////////////////////////////////////////
int AutoDC(int DC, int nSkill, object oTarget)
{
    PushInt(DC); PushInt(nSkill); PushObject(oTarget);
    return DynInt(SYM_NW_I0_TOOL, SYM_AUTO_DC);
}

//::///////////////////////////////////////////////
//:: DoGiveXP
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
      Gives the designated XP to the object
      using the design rules for XP
      distribution.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

void DoGiveXP(string sJournalTag, int nPercentage, object oTarget, int QuestAlignment=ALIGNMENT_NEUTRAL)
{
    PushString(sJournalTag); PushInt(nPercentage); PushObject(oTarget); PushInt(QuestAlignment);
    DynCommand(SYM_NW_I0_TOOL, SYM_DO_GIVE_XP);
}


///////////////////////////////////////////////////////////////////////////////
//
//  RewardPartyGP
//
///////////////////////////////////////////////////////////////////////////////
//  Gives the GP to (if bAllParty = TRUE) all party members.
//  Each players gets the GP value amount.
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 13, 2001
///////////////////////////////////////////////////////////////////////////////

void RewardPartyGP(int GP, object oTarget,int bAllParty=TRUE)
{
    PushInt(GP); PushObject(oTarget); PushInt(bAllParty);
    DynCommand(SYM_NW_I0_TOOL, SYM_REWARD_PARTY_GP);
}

///////////////////////////////////////////////////////////////////////////////
//
//  RewardPartyXP
//
///////////////////////////////////////////////////////////////////////////////
//  Gives the GP to (if bAllParty = TRUE) all party members.
//  Each players gets the GP value amount.
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 13, 2001
///////////////////////////////////////////////////////////////////////////////

void RewardPartyXP(int XP, object oTarget,int bAllParty=TRUE)
{
    PushInt(XP); PushObject(oTarget); PushInt(bAllParty);
    DynCommand(SYM_NW_I0_TOOL, SYM_REWARD_PARTY_XP);
}

///////////////////////////////////////////////////////////////////////////////
//
//  CheckPartyForItem
//
///////////////////////////////////////////////////////////////////////////////
//  Checks everyone in the party for an item
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 13, 2001
///////////////////////////////////////////////////////////////////////////////

int CheckPartyForItem(object oMember, string sItem)
{
    PushObject(oMember); PushString(sItem);
    return DynInt(SYM_NW_I0_TOOL, SYM_CHECK_PARTY_FOR_ITEM);
}
