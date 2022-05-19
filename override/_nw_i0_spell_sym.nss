//::///////////////////////////////////////////////
//:: Dynamic Spells Library Symbols v1.0
//:: _nw_i0_spell_sym.nss
//:: Copyright (c) 2003 Francois Guimond
//:://////////////////////////////////////////////
/*
    This file contains all the symbols used to
    communicate with dl_i0_spells.
*/
//:://////////////////////////////////////////////
//:: Created By: Francois Guimond
//:: Created On: Jan 25, 2003
//:://////////////////////////////////////////////

// library symbol
string SYM_NW_I0_SPELLS = "dl_i0_spells";

// void TrapDoElectricalDamage(int ngDamageMaster, int nSaveDC, int nSecondary);
int SYM_TRAP_DO_ELECTRICAL_DAMAGE = 0x00;
// int MyResistSpell(object oCaster, object oTarget, float fDelay = 0.0);
int SYM_MY_RESIST_SPELL = 0x01;
// int MySavingThrow(int nSavingThrow, object oTarget, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus = OBJECT_SELF, float fDelay = 0.0);
int SYM_MY_SAVING_THROW = 0x02;
// effect CreateProtectionFromAlignmentLink(int nAlignment, int nPower = 1);
int SYM_CREATE_PROTECTION_FROM_ALIGNMENT_LINK = 0x03;
// effect CreateDoomEffectsLink();
int SYM_CREATE_DOOM_EFFECTS_LINK = 0x04;
// void RemoveSpellEffects(int nSpell_ID, object oCaster, object oTarget);
int SYM_REMOVE_SPELL_EFFECTS = 0x05;
// void RemoveSpecificEffect(int nEffectTypeID, object oTarget);
int SYM_REMOVE_SPECIFIC_EFFECT = 0x06;
// float GetSpellEffectDelay(location SpellTargetLocation, object oTarget);
int SYM_GET_SPELL_EFFECT_DELAY = 0x07;
// float GetRandomDelay(float fMinimumTime = 0.4, float MaximumTime = 1.1);
int SYM_GET_RANDOM_DELAY = 0x08;
// int GetScaledDuration(int nActualDuration, object oTarget);
int SYM_GET_SCALED_DURATION = 0x09;
// effect GetScaledEffect(effect eStandard, object oTarget);
int SYM_GET_SCALED_EFFECT = 0x0A;
// int RemoveProtections(int nSpell_ID, object oTarget, int nCount);
int SYM_REMOVE_PROTECTIONS = 0x0B;
// int GetSpellBreachProtection(int nLastChecked);
int SYM_GET_SPELL_BREACH_PROTECTION = 0x0C;
// void AssignAOEDebugString(string sString);
int SYM_ASSIGN_AOE_DEBUG_STRING = 0x0D;
// void PlayDragonBattleCry();
int SYM_PLAY_DRAGON_BATTLE_CRY = 0x0E;
// int AmIAHumanoid(object oTarget);
int SYM_AM_I_A_HUMANOID = 0x0F;

// void spellsCure(int nDamage, int nMaxExtraDamage, int nMaximized, int vfx_impactHurt, int vfx_impactHeal, int nSpellID);
int SYM_SPELLS_CURE = 0x10;
// void DoSpellBreach(object oTarget, int nTotal, int nSR);
int SYM_DO_SPELL_BREACH = 0x11;
// int GetDragonFearDC(int nAge);
int SYM_GET_DRAGON_FEAR_DC = 0x12;
// int CalcNumberOfAttacks();
int SYM_CALC_NUMBER_OF_ATTACKS = 0x13;
// void RemoveTempHitPoints();
int SYM_REMOVE_TEMP_HIT_POINTS = 0x14;
// void RemoveEffectsFromSpell(object oTarget, int SpellID);
int SYM_REMOVE_EFFECTS_FROM_SPELL = 0x15;
// float GetSpellEffectDelay(location SpellTargetLocation, object oTarget);
int SYM_GET_SPELL_EFFECTS_DELAY = 0x16;

