//::///////////////////////////////////////////////
//::
//:: Designer Include File
//::
//:: NW_I0_PLOT.nss
//::
//:: Copyright (c) 2001 Bioware Corp.
//::
//::
//:://////////////////////////////////////////////
//::
//::
//:: This is a sample of design wrote
//:: functions that may need inclusion in multiple
//:: modules.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brent Knowles
//:: Created On: February 12, 2001
//::
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Modified By: Francois Guimond
//:: Modified On: Jan 25, 2003
//:: Converted to a dynamic library.
//:://////////////////////////////////////////////

#include "_nw_i0_plot_sym"

int DC_EASY = 0;
int DC_MEDIUM = 1;
int DC_HARD = 2;
// * this is used by some of the template scripts
// * 100 - this number is the chance of that dialog
// * appearing
int G_CLASSCHANCE = 70;


// * FUNCTION DECLARATIONS

int GetCanCastHealingSpells(object oPC) ;
int DoOnce();
void DebugSpeak(string s);
object GetMyMaster();
int IsRecall();
void DimensionHop(object oTarget);
int CanSeePlayer();
void EscapeArea(int bRun = TRUE, string sTag="NW_EXIT");
int HasItem(object oCreature, string s);
void TakeGold(int nAmount, object oGoldHolder, int bDestroy=TRUE);
object GetNearestPC();
void SetIsEnemy(object oTarget);
int AutoDC(int DC, int nSkill, object oTarget);
void AutoAlignG(int DC, object oTarget);
void AutoAlignE(int DC, object oTarget);
void DoGiveXP(string sJournalTag, int nPercentage, object oTarget, int QuestAlignment=ALIGNMENT_NEUTRAL);
void RewardXP(string sJournalTag, int nPercentage, object oTarget, int QuestAlignment=ALIGNMENT_NEUTRAL, int bAllParty=TRUE);
void RewardGP(int GP, object oTarget,int bAllParty=TRUE);
int CheckCharismaMiddle();
int CheckCharismaNormal();
int CheckCharismaLow();
int CheckCharismaHigh();
int CheckIntelligenceLow();
int CheckIntelligenceNormal();
int CheckIntelligenceNormal();
int CheckIntelligenceHigh();
int CheckWisdomHigh();
int GetWisdom(object oTarget);
int GetIntelligence(object oTarget);
int GetCharisma(object oTarget);
int GetNumItems(object oTarget,string sItem);
void GiveNumItems(object oTarget,string sItem,int nNumItems);
void TakeNumItems(object oTarget,string sItem,int nNumItems);
// * plays the correct character theme
// * assumes OBJECT_SELF is in the area
void PlayCharacterTheme(int nTheme);
// * plays the old theme for the area
// * assumes OBJECT_SELF is in the area
void PlayOldTheme();
int GetPLocalInt(object oPC,string sLocalName);
void SetPLocalInt(object oPC,string sLocalName, int nValue);
// * removes all negative effects
void RemoveEffects(object oDead);

// * plays the correct character theme
// * assumes OBJECT_SELF is in the area
void PlayCharacterTheme(int nTheme)
{
    PushInt(nTheme);
    DynCommand(SYM_NW_I0_PLOT, SYM_PLAY_CHARACTER_THEME);
}

// * plays the old theme for the area
// * assumes OBJECT_SELF is in the area
void PlayOldTheme()
{
    DynCommand(SYM_NW_I0_PLOT, SYM_PLAY_OLD_THEME);
}


//  Returns the adjusted Reaction for the purposes of store pricing.
float GetReactionAdjustment(object oTarget);
/*
    Adjusts all faction member's reputation visa via
    another faction.  Pass in a member from each
    faction.
*/
void AdjustFactionReputation(object oTargetCreature, object oMemberOfSourceFaction, int nAdjustment);
/*
    Makes the person teleport away and look like
    they are casting a spell.
*/
void EscapeViaTeleport(object oFleeing);

// * FUNCTION DEFINITIONS


int GetCanCastHealingSpells(object oPC)
{
    PushObject(oPC);
    return DynInt(SYM_NW_I0_PLOT, SYM_GET_CAN_CAST_HEALING_SPELLS);
}


int DoOnce()
{
    return DynInt(SYM_NW_I0_PLOT, SYM_DO_ONCE);
}

void DebugSpeak(string s)
{
    PushString(s);
    DynCommand(SYM_NW_I0_PLOT, SYM_DEBUG_SPEAK);
}
object GetMyMaster()
{
    return DynObject(SYM_NW_I0_PLOT, SYM_GET_MY_MASTER);
}



//::///////////////////////////////////////////////
//:: IsRecall
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Attempts  to transport the player
    back to closest Temple of Tyr using
    a Recall Stone.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
int IsRecall()
{
    return DynInt(SYM_NW_I0_PLOT, SYM_IS_RECALL);
}

//::///////////////////////////////////////////////
//:: DimensionHop
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Will move the character from one point to oTarget
     with a flashy graphic.
     Original Use: Dryads in M3Q3, SnowGlobe
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: January 10, 2002
//:://////////////////////////////////////////////

void DimensionHop(object oTarget)
{
    PushObject(oTarget);
    DynCommand(SYM_NW_I0_PLOT, SYM_DIMENSION_HOP);
}



//::///////////////////////////////////////////////
//:: CanSeePlayer
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Returns true if OBJECT_SELF can see the player
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

int CanSeePlayer()
{
    return DynInt(SYM_NW_I0_PLOT, SYM_CAN_SEE_PLAYER);
}
//::///////////////////////////////////////////////
//:: EscapeArea()
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Runs object to nearest waypoint with tag
  "NW_EXIT".  This tag can be overridden.
  You can also specify whether to run or not.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: December 2001
//:://////////////////////////////////////////////
void EscapeArea(int bRun = TRUE, string sTag="NW_EXIT")
{
    PushInt(bRun); PushString(sTag);
    DynCommand(SYM_NW_I0_PLOT, SYM_ESCAPE_AREA);
}

//::///////////////////////////////////////////////
//:: HasItem
//:: Copyright (c) 2001 Bioware Corp.
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
    return DynInt(SYM_NW_I0_PLOT, SYM_HAS_ITEM);
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
    DynCommand(SYM_NW_I0_PLOT, SYM_TAKE_GOLD);
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
    return DynInt(SYM_NW_I0_PLOT, SYM_HAS_GOLD);
}

//:: GetNearestPC
//////////////////////////////////////////////////
//
//  GetNearestPC
//
//////////////////////////////////////////////////
//
//
// Returns the PC closes to the object calling
// the function.
//
//////////////////////////////////////////////////
//
//  Created By: Brent
//  Created On: May 16, 2001
//
//////////////////////////////////////////////////
object GetNearestPC()
{
    return DynObject(SYM_NW_I0_PLOT, SYM_GET_NEAREST_PC);
}


//:: SetIsEnemy
//////////////////////////////////////////////////
//
//  [Function Name]
//
//////////////////////////////////////////////////
//
//
// [A description of the function.  This should contain any
// special ranges on input values]
//
//////////////////////////////////////////////////
//
//  Created By:
//  Created On:
//
//////////////////////////////////////////////////
void SetIsEnemy(object oTarget)
{
    PushObject(oTarget);
    DynCommand(SYM_NW_I0_PLOT, SYM_SET_IS_ENEMY);
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
    return DynInt(SYM_NW_I0_PLOT, SYM_AUTO_DC);
}

///////////////////////////////////////////////////////////////////////////////
//
//  AutoAlignG(int DC, object oTarget)
//
///////////////////////////////////////////////////////////////////////////////
//  Adjusts the alignment of the object towards good, relative to the
//  degree indicated.
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 13, 2001
///////////////////////////////////////////////////////////////////////////////
void AutoAlignG(int DC, object oTarget)
{
    PushInt(DC); PushObject(oTarget);
    DynCommand(SYM_NW_I0_PLOT, SYM_AUTO_ALIGN_G);
}
///////////////////////////////////////////////////////////////////////////////
//
//  AutoAlignE
//
///////////////////////////////////////////////////////////////////////////////
//  Adjusts the alignment of the object towards evil, relative to the
//  degree indicated.
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 13, 2001
///////////////////////////////////////////////////////////////////////////////
void AutoAlignE(int DC, object oTarget)
{
    PushInt(DC); PushObject(oTarget);
    DynCommand(SYM_NW_I0_PLOT, SYM_AUTO_ALIGN_E);
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
    DynCommand(SYM_NW_I0_PLOT, SYM_DO_GIVE_XP);
}
///////////////////////////////////////////////////////////////////////////////
//
//  RewardXP
//
///////////////////////////////////////////////////////////////////////////////
//  Gives each player the reward, scaled 1.25 times if of the correct alignment
//  and 0.75 times if of the wrong alignment.  Neutral always get the
//  1.0 times reward.
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 13, 2001
///////////////////////////////////////////////////////////////////////////////
void RewardXP(string sJournalTag, int nPercentage, object oTarget, int QuestAlignment=ALIGNMENT_NEUTRAL, int bAllParty=TRUE)
{
    PushString(sJournalTag); PushInt(nPercentage); PushObject(oTarget); PushInt(QuestAlignment); PushInt(bAllParty);
    DynCommand(SYM_NW_I0_PLOT, SYM_REWARD_XP);
}


///////////////////////////////////////////////////////////////////////////////
//
//  RewardGP
//
///////////////////////////////////////////////////////////////////////////////
//  Gives the GP to (if bAllParty = TRUE) all party members.
//  Each players gets the GP value amount.
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 13, 2001
///////////////////////////////////////////////////////////////////////////////

void RewardGP(int GP, object oTarget,int bAllParty=TRUE)
{
    PushInt(GP); PushObject(oTarget); PushInt(bAllParty);
    DynCommand(SYM_NW_I0_PLOT, SYM_REWARD_GP);
}


// *
// * Conversation Functions
// *

///////////////////////////////////////////////////////////////////////////////
//
//  CheckCharismaMiddle
//
///////////////////////////////////////////////////////////////////////////////
//  Returns TRUE if charisma is in the normal range.
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 13, 2001
///////////////////////////////////////////////////////////////////////////////
int CheckCharismaMiddle()
{
    return DynInt(SYM_NW_I0_PLOT, SYM_CHECK_CHARISMA_MIDDLE);
}

///////////////////////////////////////////////////////////////////////////////
//
//  CheckCharismaNormal
//
///////////////////////////////////////////////////////////////////////////////
//  Returns TRUE if charisma is in the normal range.
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 13, 2001
///////////////////////////////////////////////////////////////////////////////
int CheckCharismaNormal()
{
    return DynInt(SYM_NW_I0_PLOT, SYM_CHECK_CHARISMA_NORMAL);
}

///////////////////////////////////////////////////////////////////////////////
//
//  CheckCharismaLow
//
///////////////////////////////////////////////////////////////////////////////
//  Returns TRUE if charisma is in the low range.
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 13, 2001
///////////////////////////////////////////////////////////////////////////////
int CheckCharismaLow()
{
    return DynInt(SYM_NW_I0_PLOT, SYM_CHECK_CHARISMA_LOW);
}
///////////////////////////////////////////////////////////////////////////////
//
//  CheckCharismaHigh
//
///////////////////////////////////////////////////////////////////////////////
//  Returns TRUE if charisma is in the high range.
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 13, 2001
///////////////////////////////////////////////////////////////////////////////
int CheckCharismaHigh()
{
    return DynInt(SYM_NW_I0_PLOT, SYM_CHECK_CHARISMA_HIGH);
}
///////////////////////////////////////////////////////////////////////////////
//
//  CheckIntelligenceLow
//
///////////////////////////////////////////////////////////////////////////////
//  Returns TRUE if intelligence is in the low range
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 13, 2001
///////////////////////////////////////////////////////////////////////////////

int CheckIntelligenceLow()
{
    return DynInt(SYM_NW_I0_PLOT, SYM_CHECK_INTELLIGENCE_LOW);
}

///////////////////////////////////////////////////////////////////////////////
//
//  CheckIntelligenceNormal
//
///////////////////////////////////////////////////////////////////////////////
//  Returns TRUE if intelligence is in the normal range
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 13, 2001
///////////////////////////////////////////////////////////////////////////////
int CheckIntelligenceNormal()
{
    return DynInt(SYM_NW_I0_PLOT, SYM_CHECK_INTELLIGENCE_NORMAL);
}

//::///////////////////////////////////////////////
//:: CheckIntelligenceHigh
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

int CheckIntelligenceHigh()
{
    return DynInt(SYM_NW_I0_PLOT, SYM_CHECK_INTELLIGENCE_HIGH);
}
///////////////////////////////////////////////////////////////////////////////
//
//  CheckWisdomHigh
//
///////////////////////////////////////////////////////////////////////////////
//  Returns TRUE if wisdom is in the High range
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 13, 2001
///////////////////////////////////////////////////////////////////////////////
int CheckWisdomHigh()
{
    return DynInt(SYM_NW_I0_PLOT, SYM_CHECK_WISDOM_HIGH);
}

int GetWisdom(object oTarget)
{
    PushObject(oTarget);
    return DynInt(SYM_NW_I0_PLOT, SYM_GET_WISDOM);
}
int GetIntelligence(object oTarget)
{
    PushObject(oTarget);
    return DynInt(SYM_NW_I0_PLOT, SYM_GET_INTELLIGENCE);
}
int GetCharisma(object oTarget)
{
    PushObject(oTarget);
    return DynInt(SYM_NW_I0_PLOT, SYM_GET_CHARISMA);
}

//:: GetNumItems
//////////////////////////////////////////////////
//
//  GetNumItems
//
//////////////////////////////////////////////////
//
//
// Returns the number of specified item in the
// target's inventory.
//
//////////////////////////////////////////////////
//
//  Created By: John
//  Created On: September 19, 2001
//
//////////////////////////////////////////////////
int GetNumItems(object oTarget,string sItem)
{
    PushObject(oTarget); PushString(sItem);
    return DynInt(SYM_NW_I0_PLOT, SYM_GET_NUM_ITEMS);
}

//:: GiveNumItems
//////////////////////////////////////////////////
//
//  GiveNumItems
//
//////////////////////////////////////////////////
//
//
// Gives the target the number of items specified.
//
//////////////////////////////////////////////////
//
//  Created By: John
//  Created On: September 19, 2001
//
//////////////////////////////////////////////////
void GiveNumItems(object oTarget,string sItem,int nNumItems)
{
    PushObject(oTarget); PushString(sItem); PushInt(nNumItems);
    DynCommand(SYM_NW_I0_PLOT, SYM_GIVE_NUM_ITEMS);
}

//:: TakeNumItems
//////////////////////////////////////////////////
//
//  TakeNumItems
//
//////////////////////////////////////////////////
//
//
// Takes the number of items specified from the target.
//
//////////////////////////////////////////////////
//
//  Created By: John
//  Created On: September 19, 2001
//
//////////////////////////////////////////////////
void TakeNumItems(object oTarget,string sItem,int nNumItems)
{
    PushObject(oTarget); PushString(sItem); PushInt(nNumItems);
    DynCommand(SYM_NW_I0_PLOT, SYM_TAKE_NUM_ITEMS);
}


///////////////////////////////////////////////////////////////////////////////
//
//  GetReactionAdjustment
//
///////////////////////////////////////////////////////////////////////////////
//  Returns the adjusted Reaction for the purposes of store pricing.
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 25, 2001
///////////////////////////////////////////////////////////////////////////////
 float GetReactionAdjustment(object oTarget)
{
    PushObject(oTarget);
    return DynFloat(SYM_NW_I0_PLOT, SYM_GET_REACTION_ADJUSTMENT);
}

//::///////////////////////////////////////////////
//:: AdjustFactionReputation
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Adjusts all faction member's reputation visa via
    another faction.  Pass in a member from each
    faction.
*/
//:://////////////////////////////////////////////
//:: Created By: Presotn Watamaniuk
//:: Created On: Nov 15, 2001
//:://////////////////////////////////////////////
void AdjustFactionReputation(object oTargetCreature, object oMemberOfSourceFaction, int nAdjustment)
{
    PushObject(oTargetCreature); PushObject(oMemberOfSourceFaction); PushInt(nAdjustment);
    DynCommand(SYM_NW_I0_PLOT, SYM_ADJUST_FACTION_REPUTATION);
}

//::///////////////////////////////////////////////
//:: Escape Via Teleport
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Makes the person teleport away and look like
    they are casting a spell.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: March 12, 2002
//:://////////////////////////////////////////////

void EscapeViaTeleport(object oFleeing)
{
    PushObject(oFleeing);
    DynCommand(SYM_NW_I0_PLOT, SYM_ESCAPE_VIA_TELEPORT);
}


//::///////////////////////////////////////////////
//:: GetP(arty)LocalInt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Scans through all players in the party, to
    treat them all as 'one person' for the purposes
    of most plots. Makes our plots more multiplayer friendly.
*/
//:://////////////////////////////////////////////
//:: Created By: John
//:: Created On:
//:://////////////////////////////////////////////
int GetPLocalInt(object oPC,string sLocalName)
{
    PushObject(oPC); PushString(sLocalName);
    return DynInt(SYM_NW_I0_PLOT, SYM_GET_P_LOCAL_INT);
}
//::///////////////////////////////////////////////
//:: SetP(arty)LocalInt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: John
//:: Created On:
//:://////////////////////////////////////////////
void SetPLocalInt(object oPC,string sLocalName, int nValue)
{
    PushObject(oPC); PushString(sLocalName); PushInt(nValue);
    DynCommand(SYM_NW_I0_PLOT, SYM_SET_P_LOCAL_INT);
}
// * removes all negative effects
void RemoveEffects(object oDead)
{
    PushObject(oDead);
    DynCommand(SYM_NW_I0_PLOT, SYM_REMOVE_EFFECTS);
}
