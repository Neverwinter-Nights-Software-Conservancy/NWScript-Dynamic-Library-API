//::///////////////////////////////////////////////
//:: NW_I0_HENCHMAN
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   This is the include file for the
   henchmen who can join the player.

   ASSUMPTION: All these functions
   are meant to be ran by the henchman.
   OBJECT_SELF is assumed to be the henchman.

   RULES: Henchman are dialog controlled only!
   No locals/globals should be set outside of the
   henchman's own dialog file!
*/
//:://////////////////////////////////////////////
//:: Created By:  Brent
//:: Created On:  February 2002
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Modified By: Francois Guimond
//:: Modified On: Jan 25, 2003
//:: Converted to a dynamic library.
//:://////////////////////////////////////////////

#include "_nw_i0_henc_sym"

// * ---------
// * CONSTANTS
// * ---------

     // * CHAPTER INDEX
     /*
        0 = Prelude
        1 = Chapter 1
        2 = Chapter 2
        3 = Chapter 3
        4 = Chapter 4
        5 = Chapter 1 End, if necessary
        6 = Chapter 2 End, if necessary
     */

    //  * Tag Declaration
    string sDaelinTag = "NW_HEN_DAE";
        // * Personal Item Named = NW_HEN_DAEPERS
        // * Chapter 1 Quest Item =  NW_HEN_DAE1QT  ; reward NW_HEN_DAE1RW
        // * Chapter 2 Quest Item =  NW_HEN_DAE2QT  ; reward NW_HEN_DAE2RW
        // * Chapter 3 Quest Item =  NW_HEN_DAE3QT  ; reward NW_HEN_DAE3RW
    string sSharwynTag = "NW_HEN_SHA";
    string sLinuTag  =  "NW_HEN_LIN" ;
    string sGallowTag =  "NW_HEN_GAL" ;
    string sGrimTag    =   "NW_HEN_GRI";
    string sBoddyTag    =  "NW_HEN_BOD";

    // * Integers
    int INT_NUM_HENCHMEN = 6;
    int INT_FUDGE = 3; // * used to help with figuring
                       // * out the filename to use
                       // * since the numbering for files
                       // * begins at 1 but the numbering
                       // * for levels begins at 4.

// * debug function for displaying strings. Returns the first pc in the area
object PC()
{
    return DynObject(SYM_NW_I0_HENCHMAN, SYM_PC);
}
//::///////////////////////////////////////////////
//:: GetDidDie
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Returns true if the player has died.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On:
//:://////////////////////////////////////////////
// * this is turned off again when the player talks to
// * his henchman after finding him again.
void SetDidDie(int bDie)
{
    PushInt(bDie);
    DynCommand(SYM_NW_I0_HENCHMAN, SYM_SET_DID_DIE);
}
int GetDidDie()
{
    return DynInt(SYM_NW_I0_HENCHMAN, SYM_GET_DID_DIE);
}

//::///////////////////////////////////////////////
//:: Set/GetBeenHired
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Henchmen can only be hired once, ever.
  This checks or sets the local on the henchmen
  that keeps track whether they've ever been hired.
  STORED: On Henchman
  RETURNS: Boolean
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On:
//:://////////////////////////////////////////////
void SetBeenHired(int bHired=TRUE, object oTarget=OBJECT_SELF)
{
    PushInt(bHired); PushObject(oTarget);
    DynCommand(SYM_NW_I0_HENCHMAN, SYM_SET_BEEN_HIRED);
}
int GetBeenHired(object oTarget=OBJECT_SELF)
{
    PushObject(oTarget);
    return DynInt(SYM_NW_I0_HENCHMAN, SYM_GET_BEEN_HIRED);
}
// * This local is on the player
// * it is true if this particular henchman
// * is working for the player
void SetWorkingForPlayer(object oPC)
{
    PushObject(oPC);
    DynCommand(SYM_NW_I0_HENCHMAN, SYM_SET_WORKING_FOR_PLAYER);
}
int GetWorkingForPlayer(object oPC)
{
    PushObject(oPC);
    return DynInt(SYM_NW_I0_HENCHMAN, SYM_GET_WORKING_FOR_PLAYER);
}
// * Had to fix NW_CH_CHECK_37 so that it checks
// * to see if the player is the former master of the henchman

object GetFormerMaster(object oHench = OBJECT_SELF)
{
    PushObject(oHench);
    return DynObject(SYM_NW_I0_HENCHMAN, SYM_GET_FORMER_MASTER);
}
void SetFormerMaster(object oPC, object oHench)
{
    PushObject(oPC); PushObject(oHench);
    DynCommand(SYM_NW_I0_HENCHMAN, SYM_SET_FORMER_MASTER);
}

//::///////////////////////////////////////////////
//:: Set/GetStoryVar
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  This variable keeps track of where in the 'chapter'
  story the player has made it so far.
  Since a henchman can only ever be hired by one player
  this is a local stored on the henchman.
  STORED: On Henchman
  RETURNS: Value
*/
//:://////////////////////////////////////////////
//:: Created By:  Brent
//:: Created On:
//:://////////////////////////////////////////////
void SetStoryVar(int nChapter, int nVal, object oTarget=OBJECT_SELF)
{
    PushInt(nChapter); PushInt(nVal); PushObject(oTarget);
    DynCommand(SYM_NW_I0_HENCHMAN, SYM_SET_STORY_VAR);
}

int GetStoryVar(int nChapter, object oTarget=OBJECT_SELF)
{
    PushInt(nChapter); PushObject(oTarget);
    return DynInt(SYM_NW_I0_HENCHMAN, SYM_GET_STORY_VAR);
}

//::///////////////////////////////////////////////
//:: Set/GetGreetingVar
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This variable keeps track of whether or
    not the player has talked to.
    STORED: On Player
    RETURNS: Boolean
*/
//:://////////////////////////////////////////////
//:: Created By:  Brent
//:: Created On:
//:://////////////////////////////////////////////
void SetGreetingVar(int nChapter, object oPC)
{
    PushInt(nChapter); PushObject(oPC);
    DynCommand(SYM_NW_I0_HENCHMAN, SYM_SET_GREETING_VAR);
}
int GetGreetingVar(int nChapter, object oPC)
{
    PushInt(nChapter); PushObject(oPC);
    return DynInt(SYM_NW_I0_HENCHMAN, SYM_GET_GREETING_VAR);
}

//::///////////////////////////////////////////////
//:: String Generation Functions
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   These functions return the various names
   of objects and stuff used by and checked by
   the henchman.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On:
//:://////////////////////////////////////////////
string STR_PersonalItem(object oThing=OBJECT_SELF)
{
    PushObject(oThing);
    return DynString(SYM_NW_I0_HENCHMAN, SYM_STR_PERSONAL_ITEM);
}
string STR_QuestItem(int nChapter, object oThing=OBJECT_SELF)
{
    PushInt(nChapter); PushObject(oThing);
    return DynString(SYM_NW_I0_HENCHMAN, SYM_STR_QUEST_ITEM);
}
string STR_RewardItem(int nChapter, object oThing=OBJECT_SELF)
{
    PushInt(nChapter); PushObject(oThing);
    return DynString(SYM_NW_I0_HENCHMAN, SYM_STR_REWARD_ITEM);
}
//::///////////////////////////////////////////////
//:: DestroyAllPersonalItems
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Will destroy any personal items that the player
  may be carrying.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On:
//:://////////////////////////////////////////////
void DestroyAllPersonalItems(object oPC)
{
    PushObject(oPC);
    DynCommand(SYM_NW_I0_HENCHMAN, SYM_DESTROY_ALL_PERSONAL_ITEMS);
}



//::///////////////////////////////////////////////
//:: Give/HasPersonalItem
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Every Henchman has a personal item that they
   use to recognize their previous master from other
   chapters (since no data can be transferred between
   modules).
   Will only give the item if the player does not
   already have it.

   NAMING: Personal Items must have the name
      <TAG OF HENCHMAN> + PERS
      i.e, Daelin's Personal item is
      NW_HEN_DAEPERS
   STORED: n/a
   RETURNS: Has returns BOOLEAN


*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On:
//:://////////////////////////////////////////////
void GivePersonalItem(object oPC, object oHench=OBJECT_SELF)
{
    PushObject(oPC); PushObject(oHench);
    DynCommand(SYM_NW_I0_HENCHMAN, SYM_GIVE_PERSONAL_ITEM);
}

//   JUNE 1 2002: it will now return true if you have either the personal
//   item or the chapter2 or chapter3 reward items.


int HasPersonalItem(object oPC)
{
    PushObject(oPC);
    return DynInt(SYM_NW_I0_HENCHMAN, SYM_HAS_PERSONAL_ITEM);
}
//::///////////////////////////////////////////////
//:: StripAllPersonalItemsFromEveryone()
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Goes through all players in all areas and strips
   all personal henchmen items from them.
   It then adds the appropriate henchmen item back to them
   if they have a henchman, so that henchman can rejoin them
   in the 'end' modules.
   Where used: Chapter 1, Chapter 2, Chapter 3
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: April 9 2002
//:://////////////////////////////////////////////
void StripAllPersonalItemsFromEveryone()
{
    DynCommand(SYM_NW_I0_HENCHMAN, SYM_STRIP_ALL_PERSONAL_ITEMS_FROM_EVERYONE);
}
//::///////////////////////////////////////////////
//:: Level Up Functions
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  These functions check if henchmen is 'capable'
  of levelling up and also can level him up
  by swapping him with a different file (always
  one level less than the player).
  Can only level up if player is 2 or more levels
  higher than henchman.
  MIN = Level 4
  MAX = Level 14
  RETURNS: Boolean
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On:
//:://////////////////////////////////////////////
int GetCanLevelUp(object oPC, object meLevel = OBJECT_SELF)
{
    PushObject(oPC); PushObject(meLevel);
    return DynInt(SYM_NW_I0_HENCHMAN, SYM_GET_CAN_LEVEL_UP);
}
//::///////////////////////////////////////////////
//:: CopyLocals
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Copies locals from the 'earlier'
    level henchmen to the newer henchman.
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:
//:://////////////////////////////////////////////
void CopyLocals(object oSource, object oTarget)
{
    PushObject(oSource); PushObject(oTarget);
    DynCommand(SYM_NW_I0_HENCHMAN, SYM_COPY_LOCALS);
}
// * assumes that a succesful GetCanLevelUp has already
// * been tested.    Will level up character to one level
// * less than player.
// * meLevel defaults to object self unless another object is passed in
// * returns the new creature
object DoLevelUp(object oPC, object MeLevel = OBJECT_SELF)
{
    PushObject(oPC); PushObject(MeLevel);
    return DynObject(SYM_NW_I0_HENCHMAN, SYM_DO_LEVEL_UP);
}




//::///////////////////////////////////////////////
//:: Has/DestroyChapterQuestItem
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Checks if player has the chapter quest item
     The other function will destroy this item from
     the player.
*/
//:://////////////////////////////////////////////
//:: Created By:  Brent
//:: Created On:
//:://////////////////////////////////////////////
int HasChapterQuestItem(int nChapter, object oPC)
{
    PushInt(nChapter); PushObject(oPC);
    return DynInt(SYM_NW_I0_HENCHMAN, SYM_HAS_CHAPTER_QUEST_ITEM);
}

void DestroyChapterQuestItem(int nChapter, object oPC)
{
    PushInt(nChapter); PushObject(oPC);
    DynCommand(SYM_NW_I0_HENCHMAN, SYM_DESTROY_CHAPTER_QUEST_ITEM);
}

void DestroyChapterRewardItem(int nChapter, object oPC)
{
    PushInt(nChapter); PushObject(oPC);
    DynCommand(SYM_NW_I0_HENCHMAN, SYM_DESTROY_CHAPTER_REWARD_ITEM);
}
//* Change March 27 2002
// * Change February 14 2002:
// *  - Destroying Previous Chapter Reward Items
void GiveChapterRewardItem(int nChapter, object oPC)
{
    PushInt(nChapter); PushObject(oPC);
    DynCommand(SYM_NW_I0_HENCHMAN, SYM_GIVE_CHAPTER_REWARD_ITEM);
}

int HasChapterRewardItem(int nChapter, object oPC)
{
    PushInt(nChapter); PushObject(oPC);
    return DynInt(SYM_NW_I0_HENCHMAN, SYM_HAS_CHAPTER_REWARD_ITEM);
}

//::///////////////////////////////////////////////
//:: GetChapter/Area Functions
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Return integer for chapter (see key, above)
    Return 'tag' of area
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:
//:://////////////////////////////////////////////
int GetChapter()
{
    return DynInt(SYM_NW_I0_HENCHMAN, SYM_GET_CHAPTER);
}
string GetMyArea(object oThing=OBJECT_SELF)
{
    PushObject(oThing);
    return DynString(SYM_NW_I0_HENCHMAN, SYM_GET_MY_AREA);
}
// * returns true if this is an end module
int EndModule()
{
    return DynInt(SYM_NW_I0_HENCHMAN, SYM_END_MODULE);
}
// * Spawns appropriate henchman into C1e, C2e, or C4
void SpawnHenchman()
{
    DynCommand(SYM_NW_I0_HENCHMAN, SYM_SPAWN_HENCHMAN);
}
