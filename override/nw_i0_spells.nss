//::///////////////////////////////////////////////
//:: Spells Include
//:: NW_I0_SPELLS
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 2, 2002
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Modified By: Francois Guimond
//:: Modified On: Jan 25, 2003
//:: Converted to a dynamic library.
//:://////////////////////////////////////////////

#include "_nw_i0_spell_sym"

// BRENT: Added a function for doing electrical traps
void TrapDoElectricalDamage(int ngDamageMaster, int nSaveDC, int nSecondary);

//Used to route the resist magic checks into this function to check for spell countering by SR, Globes or Mantles.
int MyResistSpell(object oCaster, object oTarget, float fDelay = 0.0);
//Used to route the saving throws through this function to check for spell countering by a saving throw.
int MySavingThrow(int nSavingThrow, object oTarget, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus = OBJECT_SELF, float fDelay = 0.0);
//Will pass back a linked effect for all the protection from alignment spells.  The power represents the multiplier of strength.
//That is instead of +3 AC and +2 Saves a  power of 2 will yield +6 AC and +4 Saves.
effect CreateProtectionFromAlignmentLink(int nAlignment, int nPower = 1);
//Will pass back a linked effect for all of the doom effects.
effect CreateDoomEffectsLink();
//Searchs through a persons effects and removes those from a particular spell by a particular caster.
void RemoveSpellEffects(int nSpell_ID, object oCaster, object oTarget);
//Searchs through a persons effects and removes all those of a specific type.
void RemoveSpecificEffect(int nEffectTypeID, object oTarget);
//Returns the time in seconds that the effect should be delayed before application.
float GetSpellEffectDelay(location SpellTargetLocation, object oTarget);
//This allows the application of a random delay to effects based on time parameters passed in.  Min default = 0.4, Max default = 1.1
float GetRandomDelay(float fMinimumTime = 0.4, float MaximumTime = 1.1);
// Get Difficulty Duration
int GetScaledDuration(int nActualDuration, object oTarget);
// Get Scaled Effect
effect GetScaledEffect(effect eStandard, object oTarget);
//Remove all spell protections of a specific type
int RemoveProtections(int nSpell_ID, object oTarget, int nCount);
//
int GetSpellBreachProtection(int nLastChecked);
//Assigns a debug string to the Area of Effect Creator
void AssignAOEDebugString(string sString);
//Plays a random dragon battlecry based on age.
void PlayDragonBattleCry();
// * Returns true if Target is a humanoid
int AmIAHumanoid(object oTarget);


// * Returns true if Target is a humanoid
int AmIAHumanoid(object oTarget)
{
    PushObject(oTarget);
    return DynInt(SYM_NW_I0_SPELLS, SYM_AM_I_A_HUMANOID);
}

//::///////////////////////////////////////////////
//:: spellsCure
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Used by the 'cure' series of spells.
    Will do max heal/damage if at normal or low
    difficulty.
    Random rolls occur at higher difficulties.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

void spellsCure(int nDamage, int nMaxExtraDamage, int nMaximized, int vfx_impactHurt, int vfx_impactHeal, int nSpellID)
{
    PushInt(nDamage); PushInt(nMaxExtraDamage); PushInt(nMaximized); PushInt(vfx_impactHurt); PushInt(vfx_impactHeal); PushInt(nSpellID);
    DynCommand(SYM_NW_I0_SPELLS, SYM_SPELLS_CURE);
}

//::///////////////////////////////////////////////
//:: DoSpelLBreach
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Performs a spell breach up to nTotal spells
    are removed and nSR spell resistance is
    lowered.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 2002
//:://////////////////////////////////////////////

void DoSpellBreach(object oTarget, int nTotal, int nSR)
{
    PushObject(oTarget); PushInt(nTotal); PushInt(nSR);
    DynCommand(SYM_NW_I0_SPELLS, SYM_DO_SPELL_BREACH);
}

//::///////////////////////////////////////////////
//:: GetDragonFearDC
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Adding a function, we were using two different
    sets of numbers before. Standardizing it to be
    closer to 3e.
    nAge - hit dice
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: Sep 13, 2002
//:://////////////////////////////////////////////
int GetDragonFearDC(int nAge)
{
    PushInt(nAge);
    return DynInt(SYM_NW_I0_SPELLS, SYM_GET_DRAGON_FEAR_DC);
}

// Kovi function: calculates the appropriate base number of attacks
// for spells that increase this (tensers, divine power)
int CalcNumberOfAttacks()
{
    return DynInt(SYM_NW_I0_SPELLS, SYM_CALC_NUMBER_OF_ATTACKS);
}

// Kovi Function: gets rids of temporary hit points so that they will not stack
void RemoveTempHitPoints()
{
    DynCommand(SYM_NW_I0_SPELLS, SYM_REMOVE_TEMP_HIT_POINTS);
}

// * Kovi. removes any effects from this type of spell
// * i.e., used in Mage Armor to remove any previous
// * mage armors
void RemoveEffectsFromSpell(object oTarget, int SpellID)
{
    PushObject(oTarget); PushInt(SpellID);
    DynCommand(SYM_NW_I0_SPELLS, SYM_REMOVE_EFFECTS_FROM_SPELL);
}

int MyResistSpell(object oCaster, object oTarget, float fDelay = 0.0)
{
    PushObject(oCaster); PushObject(oTarget); PushFloat(fDelay);
    return DynInt(SYM_NW_I0_SPELLS, SYM_MY_RESIST_SPELL);
}

int MySavingThrow(int nSavingThrow, object oTarget, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus = OBJECT_SELF, float fDelay = 0.0)
{
    PushInt(nSavingThrow); PushObject(oTarget); PushInt(nDC); PushInt(nSaveType); PushObject(oSaveVersus); PushFloat(fDelay);
    return DynInt(SYM_NW_I0_SPELLS, SYM_MY_SAVING_THROW);
}

effect CreateProtectionFromAlignmentLink(int nAlignment, int nPower = 1)
{
    int nFinal = nPower * 2;
    effect eAC = EffectACIncrease(nFinal, AC_DEFLECTION_BONUS);
    eAC = VersusAlignmentEffect(eAC, ALIGNMENT_ALL, nAlignment);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, nFinal);
    eSave = VersusAlignmentEffect(eSave,ALIGNMENT_ALL, nAlignment);
    effect eImmune = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    eImmune = VersusAlignmentEffect(eImmune,ALIGNMENT_ALL, nAlignment);
    effect eDur;
    if(nAlignment == ALIGNMENT_EVIL)
    {
        eDur = EffectVisualEffect(VFX_DUR_PROTECTION_GOOD_MINOR);
    }
    else if(nAlignment == ALIGNMENT_GOOD)
    {
        eDur = EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MINOR);
    }

    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eImmune, eSave);
    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);
    return eLink;
}

effect CreateDoomEffectsLink()
{
    //Declare major variables
    effect eSaves = EffectSavingThrowDecrease(SAVING_THROW_ALL, 2);
    effect eAttack = EffectAttackDecrease(2);
    effect eDamage = EffectDamageDecrease(2);
    effect eSkill = EffectSkillDecrease(SKILL_ALL_SKILLS, 2);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    effect eLink = EffectLinkEffects(eAttack, eDamage);
    eLink = EffectLinkEffects(eLink, eSaves);
    eLink = EffectLinkEffects(eLink, eSkill);
    eLink = EffectLinkEffects(eLink, eDur);

    return eLink;
}

void RemoveSpellEffects(int nSpell_ID, object oCaster, object oTarget)
{
    PushInt(nSpell_ID); PushObject(oCaster); PushObject(oTarget);
    DynCommand(SYM_NW_I0_SPELLS, SYM_REMOVE_SPELL_EFFECTS);
}

void RemoveSpecificEffect(int nEffectTypeID, object oTarget)
{
    PushInt(nEffectTypeID); PushObject(oTarget);
    DynCommand(SYM_NW_I0_SPELLS, SYM_REMOVE_SPECIFIC_EFFECT);
}

float GetSpellEffectDelay(location SpellTargetLocation, object oTarget)
{
    PushLocation(SpellTargetLocation); PushObject(oTarget);
    return DynFloat(SYM_NW_I0_SPELLS, SYM_GET_SPELL_EFFECTS_DELAY);
}

float GetRandomDelay(float fMinimumTime = 0.4, float MaximumTime = 1.1)
{
    PushFloat(fMinimumTime); PushFloat(MaximumTime);
    return DynFloat(SYM_NW_I0_SPELLS, SYM_GET_RANDOM_DELAY);
}

int GetScaledDuration(int nActualDuration, object oTarget)
{
    PushInt(nActualDuration); PushObject(oTarget);
    return DynInt(SYM_NW_I0_SPELLS, SYM_GET_SCALED_DURATION);
}

effect GetScaledEffect(effect eStandard, object oTarget)
{
    int nDiff = GetGameDifficulty();
    effect eNew = eStandard;
    object oMaster = GetMaster(oTarget);
    if(GetIsPC(oTarget) || (GetIsObjectValid(oMaster) && GetIsPC(oMaster)))
    {
        if(GetEffectType(eStandard) == EFFECT_TYPE_FRIGHTENED && nDiff == GAME_DIFFICULTY_VERY_EASY)
        {
            eNew = EffectAttackDecrease(-2);
            return eNew;
        }
        if(GetEffectType(eStandard) == EFFECT_TYPE_FRIGHTENED && nDiff == GAME_DIFFICULTY_EASY)
        {
            eNew = EffectAttackDecrease(-4);
            return eNew;
        }
        if(nDiff == GAME_DIFFICULTY_VERY_EASY &&
            (GetEffectType(eStandard) == EFFECT_TYPE_PARALYZE ||
             GetEffectType(eStandard) == EFFECT_TYPE_STUNNED ||
             GetEffectType(eStandard) == EFFECT_TYPE_CONFUSED))
        {
            eNew = EffectDazed();
            return eNew;
        }
        else if(GetEffectType(eStandard) == EFFECT_TYPE_CHARMED || GetEffectType(eStandard) == EFFECT_TYPE_DOMINATED)
        {
            eNew = EffectDazed();
            return eNew;
        }
    }
    return eNew;
}

int RemoveProtections(int nSpell_ID, object oTarget, int nCount)
{
    PushInt(nSpell_ID); PushObject(oTarget); PushInt(nCount);
    return DynInt(SYM_NW_I0_SPELLS, SYM_REMOVE_PROTECTIONS);
}

int GetSpellBreachProtection(int nLastChecked)
{
    PushInt(nLastChecked);
    return DynInt(SYM_NW_I0_SPELLS, SYM_GET_SPELL_BREACH_PROTECTION);
}

void AssignAOEDebugString(string sString)
{
    PushString(sString);
    DynCommand(SYM_NW_I0_SPELLS, SYM_ASSIGN_AOE_DEBUG_STRING);
}

void PlayDragonBattleCry()
{
    DynCommand(SYM_NW_I0_SPELLS, SYM_PLAY_DRAGON_BATTLE_CRY);
}

void TrapDoElectricalDamage(int ngDamageMaster, int nSaveDC, int nSecondary)
{
    PushInt(ngDamageMaster); PushInt(nSaveDC); PushInt(nSecondary);
    DynCommand(SYM_NW_I0_SPELLS, SYM_TRAP_DO_ELECTRICAL_DAMAGE);
}

