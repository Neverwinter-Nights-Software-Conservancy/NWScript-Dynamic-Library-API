//::///////////////////////////////////////////////
//:: Dynamic Plot Wizard Library v1.0
//:: dl_i0_plotwizard.nss
//:: Copyright (c) 2003 Francois Guimond
//:://////////////////////////////////////////////
/*
    This file performs all the static calls to the
    plot wizard library from the dynamic library
    interface.
*/
//:://////////////////////////////////////////////
//:: Created By: Francois Guimond
//:: Created On: Jan 25, 2003
//:://////////////////////////////////////////////

#include "dl_i0_core"
#include "_nw_i0_plotwizar"

void main()
{

    switch (PopInt())
    {

        // void PWGiveExperienceParty(object oPC, int nExperience);
        case 0x00: PWGiveExperienceParty(PopObject(), PopInt()); break;

        // void PWSetMinLocalIntParty(object oPC, string sVarName, int nValue);
        case 0x01: PWSetMinLocalIntParty(PopObject(), PopString(), PopInt()); break;

        // void PWSetMinLocalIntPartyPCSpeaker(string sVarName, int nValue);
        case 0x02: PWSetMinLocalIntPartyPCSpeaker(PopString(), PopInt()); break;

        // void PWSetMinLocalIntAndJournalForItemAcquired(string sVarName, string sJournalTag, int nState, string sItemTag, int nExperience);
        case 0x03: PWSetMinLocalIntAndJournalForItemAcquired(PopString(), PopString(), PopInt(), PopString(), PopInt()); break;

        // void PWSetMinLocalIntAndJournalForOpenerParty(string sVarName, string sJournalTag, int nState, int nExperience);
        case 0x04: PWSetMinLocalIntAndJournalForOpenerParty(PopString(), PopString(), PopInt(), PopInt()); break;

    }

}

