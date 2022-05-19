//::///////////////////////////////////////////////
//:: Dynamic Generic Scripting Library v1.0
//:: dl_i0_generic.nss
//:: Copyright (c) 2003 Francois Guimond
//:://////////////////////////////////////////////
/*
    This file performs all the static calls to the
    generic library from the dynamic library
    interface.
*/
//:://////////////////////////////////////////////
//:: Created By: Francois Guimond
//:: Created On: Jan 25, 2003
//:://////////////////////////////////////////////

#include "dl_i0_core"
#include "_nw_i0_generic"

void main()
{

    struct sEnemies sEnemies;
    struct sSpellSelect sSpellSelect;

    switch (PopInt())
    {

        // int GetHasEffect(int nEffectType, object oTarget = OBJECT_SELF);
        case 0x00: PushInt(GetHasEffect(PopInt(), PopObject())); break;

        // int GetCharacterLevel(object oTarget);
        case 0x01: PushInt(GetCharacterLevel(PopObject())); break;

        // int CheckFriendlyFireOnTarget(object oTarget, float fDistance = 5.0);
        case 0x02: PushInt(CheckFriendlyFireOnTarget(PopObject(), PopFloat())); break;

        // int CheckEnemyGroupingOnTarget(object oTarget, float fDistance = 5.0);
        case 0x03: PushInt(CheckEnemyGroupingOnTarget(PopObject(), PopFloat())); break;

        // object FindSingleRangedTarget();
        case 0x04: PushObject(FindSingleRangedTarget()); break;

        // int GetNumberOfMeleeAttackers();
        case 0x05: PushInt(GetNumberOfMeleeAttackers()); break;

        // int GetNumberOfRangedAttackers();
        case 0x06: PushInt(GetNumberOfRangedAttackers()); break;

        // int GetPercentageHPLoss(object oWounded);
        case 0x07: PushInt(GetPercentageHPLoss(PopObject())); break;

        // int GetRacialTypeCount(int nRacial_Type);
        case 0x08: PushInt(GetRacialTypeCount(PopInt())); break;

        // object GetNearestSeenOrHeardEnemy();
        case 0x09: PushObject(GetNearestSeenOrHeardEnemy()); break;

        // void SetLastGenericSpellCast(int nSpell);
        case 0x0A: SetLastGenericSpellCast(PopInt()); break;

        // int GetLastGenericSpellCast();
        case 0x0B: PushInt(GetLastGenericSpellCast()); break;

        // int CompareLastSpellCast(int nSpell);
        case 0x0C: PushInt(CompareLastSpellCast(PopInt())); break;

        // void RemoveAmbientSleep();
        case 0x0D: RemoveAmbientSleep(); break;

        // int GetIsFighting(object oFighting);
        case 0x0E: PushInt(GetIsFighting(PopObject())); break;

        // object GetLockedObject(object oMaster);
        case 0x0F: PushObject(GetLockedObject(PopObject())); break;

        // void EquipAppropriateWeapons(object oTarget);
        case 0x10: EquipAppropriateWeapons(PopObject()); break;

        // void ResetHenchmenState();
        case 0x11: ResetHenchmenState(); break;

        // int AssociateCheck(object oCheck);
        case 0x12: PushInt(AssociateCheck(PopObject())); break;

        // int GetIsPostOrWalking(object oWalker = OBJECT_SELF);
        case 0x13: PushInt(GetIsPostOrWalking(PopObject())); break;

        // void DubugPrintTalentID(talent tTalent);
        case 0x14: DubugPrintTalentID(PopTalent()); break;

        // void MyPrintString(string sString);
        case 0x15: MyPrintString(PopString()); break;

        // int BashDoorCheck(object oIntruder = OBJECT_INVALID);
        case 0x16: PushInt(BashDoorCheck(PopObject())); break;

        // int DetermineClassToUse();
        case 0x17: PushInt(DetermineClassToUse()); break;

        // struct sEnemies DetermineEnemies();
        case 0x18:
            sEnemies = DetermineEnemies();
            PushInt(sEnemies.FIGHTERS);
            PushInt(sEnemies.FIGHTER_LEVELS);
            PushInt(sEnemies.CLERICS);
            PushInt(sEnemies.CLERIC_LEVELS);
            PushInt(sEnemies.MAGES);
            PushInt(sEnemies.MAGE_LEVELS);
            PushInt(sEnemies.MONSTERS);
            PushInt(sEnemies.MONTERS_LEVELS);
            PushInt(sEnemies.TOTAL);
            PushInt(sEnemies.TOTAL_LEVELS);
            break;

        // string GetMostDangerousClass(struct sEnemies sCount);
        case 0x19:
            sEnemies.TOTAL_LEVELS = PopInt();
            sEnemies.TOTAL = PopInt();
            sEnemies.MONTERS_LEVELS = PopInt();
            sEnemies.MONSTERS = PopInt();
            sEnemies.MAGE_LEVELS = PopInt();
            sEnemies.MAGES = PopInt();
            sEnemies.CLERIC_LEVELS = PopInt();
            sEnemies.CLERICS = PopInt();
            sEnemies.FIGHTER_LEVELS = PopInt();
            sEnemies.FIGHTERS = PopInt();
            PushString(GetMostDangerousClass(sEnemies));
            break;

        // int GetMatchCompatibility(talent tUse, string sClass, int nType);
        case 0x1A: PushInt(GetMatchCompatibility(PopTalent(), PopString(), PopInt())); break;

        // int MatchCombatProtections(talent tUse);
        case 0x1B: PushInt(MatchCombatProtections(PopTalent())); break;

        // int MatchSpellProtections(talent tUse);
        case 0x1C: PushInt(MatchSpellProtections(PopTalent())); break;

        // int MatchElementalProtections(talent tUse);
        case 0x1D: PushInt(MatchElementalProtections(PopTalent())); break;

        // talent StartProtectionLoop();
        case 0x1E: PushTalent(StartProtectionLoop()); break;
/*
        // int GetAttackCompatibility(talent tUse, int nClass);
        case 0x1F: PushInt(GetAttackCompatibility(PopTalent(), PopInt())); break;

        // int MatchReflexAttacks(talent tUse);
        case 0x20: PushInt(MatchReflexAttacks(PopTalent())); break;

        // int MatchFortAttacks(talent tUse);
        case 0x21: PushInt(MatchFortAttacks(PopTalent())); break;

        // object GetRangedAttackGroup(int bAllowFriendlyFire = FALSE);
        case 0x22: PushObject(GetRangedAttackGroup(PopInt())); break;

        // object GetToughestMeleeAttacker();
        case 0x23: PushObject(GetToughestMeleeAttacker()); break;

        // object GetToughestAttacker();
        case 0x24: PushObject(GetToughestAttacker()); break;

        // struct sSpellSelect AnalyzeCombatSituation();
        case 0x25:
            sSpellSelect = AnalyzeCombatSituation();
            PushInt(sSpellSelect.RANGED);
            PushInt(sSpellSelect.MELEE);
            PushObject(sSpellSelect.GROUP_TARGET);
            PushObject(sSpellSelect.MOB_TARGET);
            PushObject(sSpellSelect.MELEE_TOUGHEST);
            PushObject(sSpellSelect.TOUGHEST_TARGET);
            PushInt(sSpellSelect.ENEMY_HD);
            PushInt(sSpellSelect.ALLIED_HD);
            break;

        // int GetAlliedHD();
        case 0x26: PushInt(GetAlliedHD()); break;

        // int GetEnemyHD();
        case 0x27: PushInt(GetEnemyHD()); break;

        // talent StartAttackLoop();
        case 0x28: PushTalent(StartAttackLoop()); break;
*/
        // int VerifyDisarm(talent tUse, object oTarget);
        case 0x29: PushInt(VerifyDisarm(PopTalent(), PopObject())); break;

        // int VerifyCombatMeleeTalent(talent tUse, object oTarget);
        case 0x2A: PushInt(VerifyCombatMeleeTalent(PopTalent(), PopObject())); break;
/*
        // int UniversalSpellMatch(talent tUse);
        case 0x2B: PushInt(UniversalSpellMatch(PopTalent())); break;
*/
        // int TalentUseProtectionOnSelf();
        case 0x2C: PushInt(TalentUseProtectionOnSelf()); break;

        // int TalentUseProtectionOthers();
        case 0x2D: PushInt(TalentUseProtectionOthers()); break;

        // int TalentEnhanceOthers();
        case 0x2E: PushInt(TalentEnhanceOthers()); break;

        // int TalentUseEnhancementOnSelf();
        case 0x2F: PushInt(TalentUseEnhancementOnSelf()); break;

        // int TalentMeleeAttacked(object oIntruder = OBJECT_INVALID);
        case 0x30: PushInt(TalentMeleeAttacked(PopObject())); break;

        // int TalentRangedAttackers(object oIntruder = OBJECT_INVALID);
        case 0x31: PushInt(TalentRangedAttackers(PopObject())); break;

        // int TalentRangedEnemies(object oIntruder = OBJECT_INVALID);
        case 0x32: PushInt(TalentRangedEnemies(PopObject()));

        // int TalentSummonAllies();
        case 0x33: PushInt(TalentSummonAllies()); break;

        // int TalentHealingSelf();
        case 0x34: PushInt(TalentHealingSelf()); break;

        // int TalentHeal(int nForce = FALSE);
        case 0x35: PushInt(TalentHeal(PopInt())); break;

        // int TalentMeleeAttack(object oIntruder = OBJECT_INVALID);
        case 0x36: PushInt(TalentMeleeAttack(PopObject())); break;

        // int TalentSneakAttack();
        case 0x37: PushInt(TalentSneakAttack()); break;

        // int TalentFlee(object oIntruder = OBJECT_INVALID);
        case 0x38: PushInt(TalentFlee(PopObject())); break;

        // int TalentUseTurning();
        case 0x39: PushInt(TalentUseTurning()); break;

        // int TalentPersistentAbilities();
        case 0x3A: PushInt(TalentPersistentAbilities()); break;

        // int TalentAdvancedBuff(float fDistance);
        case 0x3B: PushInt(TalentAdvancedBuff(PopFloat())); break;

        // int TalentBuffSelf();
        case 0x3C: PushInt(TalentBuffSelf()); break;

        // int TalentSeeInvisible();
        case 0x3D: PushInt(TalentSeeInvisible()); break;

        // int TalentCureCondition();
        case 0x3E: PushInt(TalentCureCondition()); break;

        // int TalentDragonCombat(object oIntruder = OBJECT_INVALID);
        case 0x3F: PushInt(TalentDragonCombat(PopObject())); break;

        // int TalentBardSong();
        case 0x40: PushInt(TalentBardSong()); break;

        // int TalentAdvancedProtectSelf();
        case 0x41: PushInt(TalentAdvancedProtectSelf()); break;

        // int TalentSpellAttack(object oIntruder);
        case 0x42: PushInt(TalentSpellAttack(PopObject())); break;

        // void DetermineCombatRound(object oIntruder = OBJECT_INVALID, int nAI_Difficulty = 10);
        case 0x43: DetermineCombatRound(PopObject(), PopInt()); break;

        // void SetListeningPatterns();
        case 0x44: SetListeningPatterns(); break;

        // void RespondToShout(object oShouter, int nShoutIndex, object oIntruder = OBJECT_INVALID);
        case 0x45: RespondToShout(PopObject(), PopInt(), PopObject()); break;

        // void RunCircuit(int nTens, int nNum, int nRun = FALSE, float fPause = 1.0);
        case 0x46: RunCircuit(PopInt(), PopInt(), PopInt(), PopFloat()); break;

        // void WalkWayPoints(int nRun = FALSE, float fPause = 1.0);
        case 0x47: WalkWayPoints(PopInt(), PopFloat()); break;

        // void RunNextCircuit(int nRun = FALSE, float fPause = 1.0);
        case 0x48: RunNextCircuit(PopInt(), PopFloat()); break;

        // int CheckWayPoints(object oWalker = OBJECT_SELF);
        case 0x49: PushInt(CheckWayPoints(PopObject())); break;

        // void SetNPCWarningStatus(int nStatus = TRUE);
        case 0x4A: SetNPCWarningStatus(PopInt()); break;

        // int GetNPCWarningStatus();
        case 0x4B: PushInt(GetNPCWarningStatus()); break;

        // void SetSummonHelpIfAttacked();
        case 0x4C: SetSummonHelpIfAttacked(); break;

        // void CreateSignPostNPC(string sTag, location lLocal);
        case 0x4D: CreateSignPostNPC(PopString(), PopLocation());

        // void ActivateFleeToExit();
        case 0x4E: ActivateFleeToExit(); break;

        // int GetFleeToExit();
        case 0x4F: PushInt(GetFleeToExit()); break;

        // void SetSpawnInCondition(int nCondition, int bValid = TRUE);
        case 0x50: SetSpawnInCondition(PopInt(), PopInt());

        // int GetSpawnInCondition(int nCondition);
        case 0x51: PushInt(GetSpawnInCondition(PopInt())); break;

        // void SetSpawnInLocals(int nCondition);
        case 0x52: SetSpawnInLocals(PopInt()); break;

        // void SetAssociateState(int nCondition, int bValid = TRUE);
        case 0x53: SetAssociateState(PopInt(), PopInt()); break;

        // int GetAssociateState(int nCondition);
        case 0x54: PushInt(GetAssociateState(PopInt())); break;

        // int GetAssociateCRMax();
        case 0x55: PushInt(GetAssociateCRMax()); break;

        // int GetAssociateHealMaster();
        case 0x56: PushInt(GetAssociateHealMaster()); break;

        // float GetFollowDistance();
        case 0x57: PushFloat(GetFollowDistance()); break;

        // void CheckIsUnlocked(object oLastObject);
        case 0x58: CheckIsUnlocked(PopObject()); break;

        // void SetAssociateStartLocation();
        case 0x59: SetAssociateStartLocation(); break;

        // location GetAssociateStartLocation();
        case 0x5A: PushLocation(GetAssociateStartLocation()); break;

        // void PlayMobileAmbientAnimations();
        case 0x5B: PlayMobileAmbientAnimations(); break;

        // void PlayImmobileAmbientAnimations();
        case 0x5C: PlayImmobileAmbientAnimations(); break;

        // void SetBehaviorState(int nCondition, int bValid = TRUE);
        case 0x5D: SetBehaviorState(PopInt(), PopInt()); break;

        // int GetBehaviorState(int nCondition);
        case 0x5E: PushInt(GetBehaviorState(PopInt())); break;

        // void DetermineSpecialBehavior(object oIntruder = OBJECT_INVALID);
        case 0x5F: DetermineSpecialBehavior(PopObject()); break;

        // void ExitAOESpellArea(object oAOEObject);
        case 0x60: ExitAOESpellArea(PopObject()); break;

    }

}

