//////////////////////////////////////////////////////////////////
//
//  Plot Wizard Header file
//
//  Copyright (c) 2002 BioWare Corp.
//
//////////////////////////////////////////////////////////////////
//
//  nw_i0_plotwizard
//
//  Declarations and definitions of functions used by the
//  Plot Wizard
//
//////////////////////////////////////////////////////////////////
//
//  Created By: Sydney Tang
//  Created On: 2002-08-21
//
//////////////////////////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Modified By: Francois Guimond
//:: Modified On: Jan 25, 2003
//:: Converted to a dynamic library.
//:://////////////////////////////////////////////

#include "_nw_i0_plotw_sym"

//////////////////////////////////////////////////////////////////
// Function prototypes

// Give the specified amount of experience to everyone in oPC's party.
void PWGiveExperienceParty(object oPC, int nExperience);

// Set the local integer variable sVarName to nValue
// for all players in oPC's party.
//void PWSetLocalIntParty(object oPC, string sVarName, int nValue);

// Set the local integer variable sVarName to nValue
// for all players in oPC's party.
// If the local int is already greater than nValue, do nothing.
void PWSetMinLocalIntParty(object oPC, string sVarName, int nValue);

// Set the local integer variable sVarName to nValue
// for all players in the PC Speaker's party.
// This function should only be called from a Conversation action script.
//void PWSetLocalIntPartyPCSpeaker(string sVarName, int nValue);

// Set the local integer variable sVarName to nValue
// for all players in the PC Speaker's party.
// If the local int is already greater than nValue, do nothing.
void PWSetMinLocalIntPartyPCSpeaker(string sVarName, int nValue);

void PWSetMinLocalIntAndJournalForItemAcquired(string sVarName, string sJournalTag, int nState, string sItemTag, int nExperience);

void PWSetMinLocalIntAndJournalForOpenerParty(string sVarName, string sJournalTag, int nState, int nExperience);

//////////////////////////////////////////////////////////////////
// Function definitions

void PWGiveExperienceParty(object oPC, int nExperience)
{
    PushObject(oPC); PushInt(nExperience);
    DynCommand(SYM_NW_I0_PLOTWIZARD, SYM_PW_GIVE_EXPERIENCE_PARTY);
}
/*
void PWSetLocalIntParty(object oPC, string sVarName, int nValue)
{
  object oPartyMember = GetFirstFactionMember(oPC, TRUE);
  while (oPartyMember != OBJECT_INVALID)
  {
    SetLocalInt(oPartyMember, sVarName, nValue);
    oPartyMember = GetNextFactionMember(oPC, TRUE);
  }
}

void PWSetLocalIntPartyPCSpeaker(string sVarName, int nValue)
{
  PWSetLocalIntParty(GetPCSpeaker(), sVarName, nValue);
}
*/
void PWSetMinLocalIntParty(object oPC, string sVarName, int nValue)
{
    PushObject(oPC); PushString(sVarName); PushInt(nValue);
    DynCommand(SYM_NW_I0_PLOTWIZARD, SYM_PW_SET_MIN_LOCAL_INT_PARTY);
}

void PWSetMinLocalIntPartyPCSpeaker(string sVarName, int nValue)
{
    PushString(sVarName); PushInt(nValue);
    DynCommand(SYM_NW_I0_PLOTWIZARD, SYM_PW_SET_MIN_LOCAL_INT_PARTY_PC_SPEAKER);
}

void PWSetMinLocalIntAndJournalForItemAcquired(string sVarName, string sJournalTag, int nState, string sItemTag, int nExperience)
{
    PushString(sVarName); PushString(sJournalTag); PushInt(nState); PushString(sItemTag); PushInt(nExperience);
    DynCommand(SYM_NW_I0_PLOTWIZARD, SYM_PW_SET_MIN_LOCAL_INT_AND_JOURNAL_FOR_ITEM_ACQUIRED);
}

void PWSetMinLocalIntAndJournalForOpenerParty(string sVarName, string sJournalTag, int nState, int nExperience)
{
    PushString(sVarName); PushString(sJournalTag); PushInt(nState); PushInt(nExperience);
    DynCommand(SYM_NW_I0_PLOTWIZARD, SYM_PW_SET_MIN_LOCAL_INT_AND_JOURNAL_FOR_OPENER_PARTY);
}

