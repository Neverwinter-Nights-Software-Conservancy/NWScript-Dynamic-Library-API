//::///////////////////////////////////////////////
//:: Dynamic Spells Library v1.0
//:: dl_i0_spells.nss
//:: Copyright (c) 2003 Francois Guimond
//:://////////////////////////////////////////////
/*
    This file performs all the static calls to the
    spells library from the dynamic library
    interface.
*/
//:://////////////////////////////////////////////
//:: Created By: Francois Guimond
//:: Created On: Jan 25, 2003
//:://////////////////////////////////////////////

#include "dl_i0_core"
#include "_nw_i0_spells"

void main()
{

    switch (PopInt())
    {

        // void TrapDoElectricalDamage(int ngDamageMaster, int nSaveDC, int nSecondary);
        case 0x00: TrapDoElectricalDamage(PopInt(), PopInt(), PopInt()); break;

        // int MyResistSpell(object oCaster, object oTarget, float fDelay = 0.0);
        case 0x01: PushInt(MyResistSpell(PopObject(), PopObject(), PopFloat())); break;

        // int MySavingThrow(int nSavingThrow, object oTarget, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus = OBJECT_SELF, float fDelay = 0.0);
        case 0x02: PushInt(MySavingThrow(PopInt(), PopObject(), PopInt(), PopInt(), PopObject(), PopFloat())); break;
/*
        // effect CreateProtectionFromAlignmentLink(int nAlignment, int nPower = 1);
        case 0x03: PushEffect(CreateProtectionFromAlignmentLink(PopInt(), PopInt())); break;

        // effect CreateDoomEffectsLink();
        case 0x04: PushEffect(CreateDoomEffectsLink()); break;
*/
        // void RemoveSpellEffects(int nSpell_ID, object oCaster, object oTarget);
        case 0x05: RemoveSpellEffects(PopInt(), PopObject(), PopObject()); break;

        // void RemoveSpecificEffect(int nEffectTypeID, object oTarget);
        case 0x06: RemoveSpecificEffect(PopInt(), PopObject()); break;

        // float GetSpellEffectDelay(location SpellTargetLocation, object oTarget);
        case 0x07: PushFloat(GetSpellEffectDelay(PopLocation(), PopObject())); break;

        // float GetRandomDelay(float fMinimumTime = 0.4, float MaximumTime = 1.1);
        case 0x08: PushFloat(GetRandomDelay(PopFloat(), PopFloat())); break;

        // int GetScaledDuration(int nActualDuration, object oTarget);
        case 0x09: PushInt(GetScaledDuration(PopInt(), PopObject())); break;
/*
        // effect GetScaledEffect(effect eStandard, object oTarget);
        case 0x0A: PushEffect(GetScaledEffect(PopEffect(), PopObject())); break;
*/
        // int RemoveProtections(int nSpell_ID, object oTarget, int nCount);
        case 0x0B: PushInt(RemoveProtections(PopInt(), PopObject(), PopInt())); break;

        // int GetSpellBreachProtection(int nLastChecked);
        case 0x0C: PushInt(GetSpellBreachProtection(PopInt())); break;

        // void AssignAOEDebugString(string sString);
        case 0x0D: AssignAOEDebugString(PopString()); break;

        // void PlayDragonBattleCry();
        case 0x0E: PlayDragonBattleCry(); break;

        // int AmIAHumanoid(object oTarget);
        case 0x0F: PushInt(AmIAHumanoid(PopObject())); break;

        // void spellsCure(int nDamage, int nMaxExtraDamage, int nMaximized, int vfx_impactHurt, int vfx_impactHeal, int nSpellID);
        case 0x10: spellsCure(PopInt(), PopInt(), PopInt(), PopInt(), PopInt(), PopInt()); break;

        // void DoSpellBreach(object oTarget, int nTotal, int nSR);
        case 0x11: DoSpellBreach(PopObject(), PopInt(), PopInt()); break;

        // int GetDragonFearDC(int nAge);
        case 0x12: PushInt(GetDragonFearDC(PopInt())); break;

        // int CalcNumberOfAttacks();
        case 0x13: PushInt(CalcNumberOfAttacks()); break;

        // void RemoveTempHitPoints();
        case 0x14: RemoveTempHitPoints(); break;

        // void RemoveEffectsFromSpell(object oTarget, int SpellID);
        case 0x15: RemoveEffectsFromSpell(PopObject(), PopInt()); break;

        // float GetSpellEffectDelay(location SpellTargetLocation, object oTarget);
        case 0x16: PushFloat(GetSpellEffectDelay(PopLocation(), PopObject())); break;

    }

}

