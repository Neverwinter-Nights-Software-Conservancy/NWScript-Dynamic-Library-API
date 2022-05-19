//::///////////////////////////////////////////////
//:: Generic Associate Commands
//:: FileName
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is a wrapper route all associate
    behavior through some common routines.
*/
//:://////////////////////////////////////////////
//:: Created By:  Brent
//:: Created On:  October 22, 2001
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Modified By: Francois Guimond
//:: Modified On: Jan 25, 2003
//:: Converted to a dynamic library.
//:://////////////////////////////////////////////

#include "_nw_i0_assoc_sym"
#include "nw_i0_generic"

// * Function Declarations
void SpeakQuickChat(string sVoice);
void DebugSTR(string s);
int IsBusy();
void SetIsBusy(int bIsBusy);
void DetermineAssociateCombatRound();
void OpenNearestLock();
void DoFollowMaster();
void GetBehind();

// * Function Implementation


void DebugSTR(string s)
{
    PushString(s);
    DynCommand(SYM_NW_I0_ASSOC, SYM_DEBUG_STR);
}


void DetermineAssociateCombatRound()
{
    DynCommand(SYM_NW_I0_ASSOC, SYM_DETERMINE_ASSOCIATE_COMBAT_ROUND);
}

//::///////////////////////////////////////////////
//:: OpenNearestLock
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Will try to unlock the lock.

    ------------
    Interaction:
    ------------
    Will check in User Defined in 3 seconds to see
    if lockpick was succesful, otherwise
    will say a I failed message
*/
//:://////////////////////////////////////////////
//:: Created By:    Brent
//:: Created On:    October 23, 2001
//:://////////////////////////////////////////////

void OpenNearestLock()
{
    DynCommand(SYM_NW_I0_ASSOC, SYM_OPEN_NEAREST_LOCK);
}

//::///////////////////////////////////////////////
//:: DoFollowMaster
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Follows the master.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

void DoFollowMaster()
{
    DynCommand(SYM_NW_I0_ASSOC, SYM_DO_FOLLOW_MASTER);
}

//::///////////////////////////////////////////////
//:: Name
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does not
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

int IsBusy()
{
    return DynInt(SYM_NW_I0_ASSOC, SYM_IS_BUSY);
}

//::///////////////////////////////////////////////
//:: SetIsBusy
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Certain operations (like unlocking objects)
    will put a henchman into a busy state.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

void SetIsBusy(int bIsBusy)
{
    PushInt(bIsBusy);
    DynCommand(SYM_NW_I0_ASSOC, SYM_SET_IS_BUSY);
}

//::///////////////////////////////////////////////
//:: Name
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

void SpeakQuickChat(string sVoice)
{
    PushString(sVoice);
    DynCommand(SYM_NW_I0_ASSOC, SYM_SPEAK_QUICK_CHAT);
}

//::///////////////////////////////////////////////
//:: GetBehind
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Moves behind the creature.
*/
//:://////////////////////////////////////////////
//:: Created By: Aidan
//:: Created On: Winter 2001
//:://////////////////////////////////////////////

void GetBehind()
{
    DynCommand(SYM_NW_I0_ASSOC, SYM_GET_BEHIND);
}// end of Script

