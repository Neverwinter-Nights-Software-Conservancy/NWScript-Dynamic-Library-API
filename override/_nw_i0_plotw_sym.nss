//::///////////////////////////////////////////////
//:: Dynamic Plot Wizard Library Symbols v1.0
//:: _nw_i0_plotw_sym.nss
//:: Copyright (c) 2003 Francois Guimond
//:://////////////////////////////////////////////
/*
    This file contains all the symbols used to
    communicate with dl_i0_plotwizard.
*/
//:://////////////////////////////////////////////
//:: Created By: Francois Guimond
//:: Created On: Jan 25, 2003
//:://////////////////////////////////////////////

// library symbol
string SYM_NW_I0_PLOTWIZARD = "dl_i0_plotwizard";

// void PWGiveExperienceParty(object oPC, int nExperience);
int SYM_PW_GIVE_EXPERIENCE_PARTY = 0x00;
// void PWSetMinLocalIntParty(object oPC, string sVarName, int nValue);
int SYM_PW_SET_MIN_LOCAL_INT_PARTY = 0x01;
// void PWSetMinLocalIntPartyPCSpeaker(string sVarName, int nValue);
int SYM_PW_SET_MIN_LOCAL_INT_PARTY_PC_SPEAKER = 0x02;
// void PWSetMinLocalIntAndJournalForItemAcquired(string sVarName, string sJournalTag, int nState, string sItemTag, int nExperience);
int SYM_PW_SET_MIN_LOCAL_INT_AND_JOURNAL_FOR_ITEM_ACQUIRED = 0x03;
// void PWSetMinLocalIntAndJournalForOpenerParty(string sVarName, string sJournalTag, int nState, int nExperience);
int SYM_PW_SET_MIN_LOCAL_INT_AND_JOURNAL_FOR_OPENER_PARTY = 0x04;

