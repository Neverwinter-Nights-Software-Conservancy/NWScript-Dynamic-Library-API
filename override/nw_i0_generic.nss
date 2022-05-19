//::///////////////////////////////////////////////
//:: Generic Scripting Include v1.0
//:: NW_I0_GENERIC
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    ********************************************
    WARNING THIS SCRIPT IS CHANGED AT YOUR PERIL
    ********************************************

    This is the master generic script and currently
    handles all combat and some plot behavior
    within NWN. If this script is tampered
    with there is a chance of introducing game
    breaking bugs.  But other than that enjoy.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 20, 2001
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Modified By: Francois Guimond
//:: Modified On: Jan 25, 2003
//:: Converted to a dynamic library.
//:://////////////////////////////////////////////

#include "_nw_i0_gener_sym"

//GENERIC STRUCTURES

struct sEnemies
{
    int FIGHTERS;
    int FIGHTER_LEVELS;
    int CLERICS;
    int CLERIC_LEVELS;
    int MAGES;
    int MAGE_LEVELS;
    int MONSTERS;
    int MONTERS_LEVELS;
    int TOTAL;
    int TOTAL_LEVELS;
};

struct sSpellSelect
{
    int RANGED;
    int MELEE;
    object GROUP_TARGET;
    object MOB_TARGET;
    object MELEE_TOUGHEST;
    object TOUGHEST_TARGET;
    int ENEMY_HD;
    int ALLIED_HD;
};

//Flee and move constants
int NW_GENERIC_FLEE_EXIT_FLEE = 0;
int NW_GENERIC_FLEE_EXIT_RETURN = 1;
int NW_GENERIC_FLEE_TELEPORT_FLEE = 2;
int NW_GENERIC_FLEE_TELEPORT_RETURN = 3;

//Shout constants
int NW_GENERIC_SHOUT_I_WAS_ATTACKED = 1;    // NOT USED
int NW_GENERIC_SHOUT_I_AM_DEAD = 12;        //IN OnDeath Script
int NW_GENERIC_SHOUT_BACK_UP_NEEDED = 13;   //IN TalentMeleeAttacked
int NW_GENERIC_SHOUT_BLOCKER = 2;

//Master Constants
int NW_FLAG_SPECIAL_CONVERSATION        = 0x00000001;
int NW_FLAG_SHOUT_ATTACK_MY_TARGET      = 0x00000002;
int NW_FLAG_STEALTH                     = 0x00000004;
int NW_FLAG_SEARCH                      = 0x00000008;
int NW_FLAG_SET_WARNINGS                = 0x00000010;
int NW_FLAG_ESCAPE_RETURN               = 0x00000020; //Failed
int NW_FLAG_ESCAPE_LEAVE                = 0x00000040;
int NW_FLAG_TELEPORT_RETURN             = 0x00000080; //Failed
int NW_FLAG_TELEPORT_LEAVE              = 0x00000100;
int NW_FLAG_PERCIEVE_EVENT              = 0x00000200;
int NW_FLAG_ATTACK_EVENT                = 0x00000400;
int NW_FLAG_DAMAGED_EVENT               = 0x00000800;
int NW_FLAG_SPELL_CAST_AT_EVENT         = 0x00001000;
int NW_FLAG_DISTURBED_EVENT             = 0x00002000;
int NW_FLAG_END_COMBAT_ROUND_EVENT      = 0x00004000;
int NW_FLAG_ON_DIALOGUE_EVENT           = 0x00008000;
int NW_FLAG_RESTED_EVENT                = 0x00010000;
int NW_FLAG_DEATH_EVENT                 = 0x00020000;
int NW_FLAG_SPECIAL_COMBAT_CONVERSATION = 0x00040000;
int NW_FLAG_AMBIENT_ANIMATIONS          = 0x00080000;
int NW_FLAG_HEARTBEAT_EVENT             = 0x00100000;
int NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS = 0x00200000;
int NW_FLAG_DAY_NIGHT_POSTING           = 0x00400000;
int NW_FLAG_AMBIENT_ANIMATIONS_AVIAN    = 0x00800000;
int NW_FLAG_APPEAR_SPAWN_IN_ANIMATION   = 0x01000000;
int NW_FLAG_SLEEPING_AT_NIGHT           = 0x02000000;
int NW_FLAG_FAST_BUFF_ENEMY             = 0x04000000;

//Behavior Constants
int NW_FLAG_BEHAVIOR_SPECIAL       = 0x00000001;
int NW_FLAG_BEHAVIOR_CARNIVORE     = 0x00000002; //Will always attack regardless of faction
int NW_FLAG_BEHAVIOR_OMNIVORE      = 0x00000004; //Will only attack if approached
int NW_FLAG_BEHAVIOR_HERBIVORE     = 0x00000008; //Will never attack.  Will alway flee.

//Talent Type Constants
int NW_TALENT_PROTECT = 1;
int NW_TALENT_ENHANCE = 2;

//PRIVATE FUNCTION DECLARATIONS

//Checks the target for a specific EFFECT_TYPE constant value
int GetHasEffect(int nEffectType, object oTarget = OBJECT_SELF);
//Adds all three of the class levels together.  Used before GetHitDice became available
int GetCharacterLevel(object oTarget);
//Returns the number of persons who are considered friendly to the the target.
int CheckFriendlyFireOnTarget(object oTarget, float fDistance = 5.0);
//Returns the number of enemies on a target.
int CheckEnemyGroupingOnTarget(object oTarget, float fDistance = 5.0);
//Find a single target who is an enemy with 30m of self
object FindSingleRangedTarget();
//Calculate the number of people currently attacking self.
int GetNumberOfMeleeAttackers();
//Calculate the number of people attacking self from beyond 5m
int GetNumberOfRangedAttackers();
//Determine the percentage of HP object-self has left
int GetPercentageHPLoss(object oWounded);
//Determine the number of targets within 20m that are of the specified racial-type
int GetRacialTypeCount(int nRacial_Type);
//Returns the nearest object that can be seen, then checks for the nearest heard target.
object GetNearestSeenOrHeardEnemy();
//Sets a local variable for the last spell used
void SetLastGenericSpellCast(int nSpell);
//Returns a SPELL_ constant for the last spell used
int GetLastGenericSpellCast();
//Compares the current spell with the last one cast
int CompareLastSpellCast(int nSpell);
//If using ambient sleep this will remove the effect
void RemoveAmbientSleep();
//Does a check to determine if the NPC has an attempted spell or attack target
int GetIsFighting(object oFighting);
//Searches for the nearest locked object to the master
object GetLockedObject(object oMaster);
//Equip the weapon appropriate to enemy and position
void EquipAppropriateWeapons(object oTarget);
//Returns the henchmen to a commandable state of grace
void ResetHenchmenState();
//Returns true if self is a henchmen
int AssociateCheck(object oCheck);
//Returns true if the object has any posts or waypoints to walk
int GetIsPostOrWalking(object oWalker = OBJECT_SELF);
//Prints a log string with the ID of the passed in talent.
void DubugPrintTalentID(talent tTalent);
//Inserts a debug print string into the log.
void MyPrintString(string sString);


//DETERMINE COMBAT ROUND SUB FUNCTIONS

int BashDoorCheck(object oIntruder = OBJECT_INVALID);
int DetermineClassToUse();
struct sEnemies DetermineEnemies();
string GetMostDangerousClass(struct sEnemies sCount);
int GetMatchCompatibility(talent tUse, string sClass, int nType);
int MatchCombatProtections(talent tUse);
int MatchSpellProtections(talent tUse);
int MatchElementalProtections(talent tUse);
talent StartProtectionLoop();
int GetAttackCompatibility(talent tUse, int nClass);
int MatchReflexAttacks(talent tUse);
int MatchFortAttacks(talent tUse);
object GetRangedAttackGroup(int bAllowFriendlyFire = FALSE);
object GetToughestMeleeAttacker();
object GetToughestAttacker();
struct sSpellSelect AnalyzeCombatSituation();
int GetAlliedHD();
int GetEnemyHD();
talent StartAttackLoop();
int VerifyDisarm(talent tUse, object oTarget);
int VerifyCombatMeleeTalent(talent tUse, object oTarget);
int UniversalSpellMatch(talent tUse);

//CURRENT TALENT FUNCTIONS
int TalentUseProtectionOnSelf();
int TalentUseProtectionOthers();
int TalentEnhanceOthers();
int TalentUseEnhancementOnSelf();
int TalentMeleeAttacked(object oIntruder = OBJECT_INVALID);
int TalentRangedAttackers(object oIntruder = OBJECT_INVALID);
int TalentRangedEnemies(object oIntruder = OBJECT_INVALID);
int TalentSummonAllies();
int TalentHealingSelf(); //Use spells and potions
int TalentHeal(int nForce = FALSE); //User spells only on others and self
int TalentMeleeAttack(object oIntruder = OBJECT_INVALID);
int TalentSneakAttack();
int TalentFlee(object oIntruder = OBJECT_INVALID);
int TalentUseTurning();
int TalentPersistentAbilities();
int TalentAdvancedBuff(float fDistance);
int TalentBuffSelf();  //Used for Potions of Enhancement and Protection
int TalentSeeInvisible();
int TalentCureCondition();
int TalentDragonCombat(object oIntruder = OBJECT_INVALID);
int TalentBardSong();
int TalentAdvancedProtectSelf();
int TalentSpellAttack(object oIntruder);


//CORE AI FUNCTIONS
void DetermineCombatRound(object oIntruder = OBJECT_INVALID, int nAI_Difficulty = 10);
void SetListeningPatterns();
void RespondToShout(object oShouter, int nShoutIndex, object oIntruder = OBJECT_INVALID);
void RunCircuit(int nTens, int nNum, int nRun = FALSE, float fPause = 1.0);
void WalkWayPoints(int nRun = FALSE, float fPause = 1.0);
void RunNextCircuit(int nRun = FALSE, float fPause = 1.0);
int CheckWayPoints(object oWalker = OBJECT_SELF);

//PLOT FUNCTIONS
void SetNPCWarningStatus(int nStatus = TRUE);
int GetNPCWarningStatus();
void SetSummonHelpIfAttacked();
void CreateSignPostNPC(string sTag, location lLocal);
void ActivateFleeToExit();
int GetFleeToExit();

//MASTER LOCAL FUNCTIONS
void SetSpawnInCondition(int nCondition, int bValid = TRUE);
int GetSpawnInCondition(int nCondition);
void SetSpawnInLocals(int nCondition);

//ASSOCIATE MASTER VARIABLE FUNCTIONS
void SetAssociateState(int nCondition, int bValid = TRUE);
int GetAssociateState(int nCondition);

//ASSOCIATE FUNCTIONS
int GetAssociateCRMax();
int GetAssociateHealMaster();
float GetFollowDistance();
void CheckIsUnlocked(object oLastObject);
void SetAssociateStartLocation();
location GetAssociateStartLocation();

//AMBIENT ANIMATION COMMANDS
void PlayMobileAmbientAnimations();
void PlayImmobileAmbientAnimations();

//BEHAVIOR LOCAL FUNCTIONS
void SetBehaviorState(int nCondition, int bValid = TRUE);
int GetBehaviorState(int nCondition);
void DetermineSpecialBehavior(object oIntruder = OBJECT_INVALID);

//::///////////////////////////////////////////////
//:: Master Local Get and Set
//:: FileName
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All On Spawn in conditions in the game are now
    being stored within one local.  The get and set
    changed or checks the condition of this one
    Hex local.  The NW_FLAG_XXX variables above
    allow for the user of these functions throughout
    the generic scripts.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 14, 2001
//:://////////////////////////////////////////////

void SetSpawnInCondition(int nCondition, int bValid = TRUE)
{
    PushInt(nCondition); PushInt(bValid);
    DynCommand(SYM_NW_I0_GENERIC, SYM_SET_SPAWN_IN_CONDITION);
}

int GetSpawnInCondition(int nCondition)
{
    PushInt(nCondition);
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_SPAWN_IN_CONDITION);
}

void SetSpawnInLocals(int nCondition)
{
    PushInt(nCondition);
    DynCommand(SYM_NW_I0_GENERIC, SYM_SET_SPAWN_IN_LOCALS);
}

//::///////////////////////////////////////////////
//:: DetermineCombatRound
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function is the master function for the
    generic include and is called from the main
    script.  This function is used in lieu of
    any actual scripting.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

void DetermineCombatRound(object oIntruder = OBJECT_INVALID, int nAI_Difficulty = 10)
{
    PushObject(oIntruder); PushInt(nAI_Difficulty);
    DynCommand(SYM_NW_I0_GENERIC, SYM_DETERMINE_COMBAT_ROUND);
}

//::///////////////////////////////////////////////
//:: SetListeningPatterns
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sets the correct listen checks on the NPC by
    determining what talents they possess or what
    class they use.

    This is also a good place to set up all of
    the sleep and appear disappear animations for
    various models.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 24, 2001
//:://////////////////////////////////////////////

void SetListeningPatterns()
{
    DynCommand(SYM_NW_I0_GENERIC, SYM_SET_LISTENING_PATTERNS);
}

//::///////////////////////////////////////////////
//:: Respond To Shouts
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Allows the listener to react in a manner
    consistant with the given shout but only to one
    combat shout per round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 25, 2001
//:://////////////////////////////////////////////

//NOTE ABOUT COMMONERS
/*
    Commoners are universal cowards.  If you attack anyone they will flee for 4 seconds away from the attacker.
    However to make the commoners into a mob, make a single commoner at least 10th level of the same faction.
    If that higher level commoner is attacked or killed then the commoners will attack the attacker.  They will disperse again
    after some of them are killed.  Should NOT make multi-class creatures using commoners.
*/
//NOTE ABOUT BLOCKERS
/*
    It should be noted that the Generic Script for On Dialogue attempts to get a local set on the shouter by itself.
    This object represents the LastOpenedBy object.  It is this object that becomes the oIntruder within this function.
*/

//NOTE ABOUT INTRUDERS
/*
    The intruder object is for cases where a placable needs to pass a LastOpenedBy Object or a AttackMyAttacker
    needs to make his attacker the enemy of everyone.
*/

void RespondToShout(object oShouter, int nShoutIndex, object oIntruder = OBJECT_INVALID)
{
    PushObject(oShouter); PushInt(nShoutIndex); PushObject(oIntruder);
    DynCommand(SYM_NW_I0_GENERIC, SYM_RESPOND_TO_SHOUT);
}

//::///////////////////////////////////////////////
//:: Set and Get NPC Warning Status
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function sets a local int on OBJECT_SELF
    which will be checked in the On Attack, On
    Damaged and On Disturbed scripts to check if
    the offending poarty was a PC and was friendly.
    The Get will return the status of the local.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
//:://////////////////////////////////////////////

void SetNPCWarningStatus(int nStatus = TRUE)
{
    PushInt(nStatus);
    DynCommand(SYM_NW_I0_GENERIC, SYM_SET_NPC_WARNING_STATUS);
}

int GetNPCWarningStatus()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_NPC_WARNING_STATUS);
}

//::///////////////////////////////////////////////
//:: Set SummonHelpIfAttacked
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function works in tandem with an encounter
    to spawn in guards to fight for the attacked
    NPC.  MAKE SURE THE ENCOUNTER TAG IS SET TO:

             "ENC_" + NPC TAG
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
//:://////////////////////////////////////////////

//Presently Does not work with the current implementation of encounter trigger
void SetSummonHelpIfAttacked()
{
    DynCommand(SYM_NW_I0_GENERIC, SYM_SET_SUMMON_HELP_IF_ATTACKED);
}

//************************************************************************************************************************************
//************************************************************************************************************************************
//
// ESCAPE FUNCTIONS
//
//************************************************************************************************************************************
//************************************************************************************************************************************

//::///////////////////////////////////////////////
//:: Set, Get Activate,Flee to Exit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The target object flees to the specified
    way point and then destroys itself, to be
    respawned at a later point.  For unkillable
    sign post characters who are not meant to fight
    back.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
//:://////////////////////////////////////////////

//This function is used only because ActionDoCommand can only accept void functions
void CreateSignPostNPC(string sTag, location lLocal)
{
    PushString(sTag); PushLocation(lLocal);
    DynCommand(SYM_NW_I0_GENERIC, SYM_CREATE_SIGN_POST_NPC);
}

void ActivateFleeToExit()
{
    DynCommand(SYM_NW_I0_GENERIC, SYM_ACTIVATE_FLEE_TO_EXIT);
}

int GetFleeToExit()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_FLEE_TO_EXIT);
}

//************************************************************************************************************************************
//************************************************************************************************************************************
//
//WAY POINT WALK FUNCTIONS
//
//************************************************************************************************************************************
//************************************************************************************************************************************

//::///////////////////////////////////////////////
//:: Walk Way Point Path
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Allows specified person walk a waypoint path
*/
//:://////////////////////////////////////////////
//:: Created By: Aidan Scanlan
//:: Created On: July 10, 2001
//:://////////////////////////////////////////////

void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)  //Run first circuit
{
    PushInt(nRun); PushFloat(fPause);
    DynCommand(SYM_NW_I0_GENERIC, SYM_WALK_WAY_POINTS);
}

void RunNextCircuit(int nRun = FALSE, float fPause = 1.0)
{
    PushInt(nRun); PushFloat(fPause);
    DynCommand(SYM_NW_I0_GENERIC, SYM_RUN_NEXT_CIRCUIT);
}

//::///////////////////////////////////////////////
//:: Run Circuit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calculates the proper path to follow along a
    predetermined set of way points
*/
//:://////////////////////////////////////////////
//:: Created By: Aidan Scanlan
//:: Created On: July 10, 2001
//:://////////////////////////////////////////////

void RunCircuit(int nTens, int nNum, int nRun = FALSE, float fPause = 1.0)
{
    PushInt(nTens); PushInt(nNum); PushInt(nRun); PushFloat(fPause);
    DynCommand(SYM_NW_I0_GENERIC, SYM_RUN_CIRCUIT);
}

//::///////////////////////////////////////////////
//:: Check Walkways
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function checks the passed in object to
    see if they are supposed to be walking to
    day or night postings.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 26, 2002
//:://////////////////////////////////////////////

int CheckWayPoints(object oWalker = OBJECT_SELF)
{
    PushObject(oWalker);
    return DynInt(SYM_NW_I0_GENERIC, SYM_CHECK_WAY_POINTS);
}


//:://///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//:: Talent checks and use functions
//:: Copyright (c) 2001 Bioware Corp.
//:://///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
    This is a series of functions that check
    if a particular type of talent is available and
    if so then use that talent.
*/
//:://///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// PROTECT SELF
int TalentUseProtectionOnSelf()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_USE_PROTECTION_ON_SELF);
}

//PROTECT PARTY
int TalentUseProtectionOthers()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_USE_PROTECTION_OTHERS);
}

// ENHANCE OTHERS
int TalentEnhanceOthers()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_ENHANCE_OTHERS);
}

// ENHANCE SELF
int TalentUseEnhancementOnSelf()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_USE_ENHANCEMENT_ON_SELF);
}

// SPELL CASTER MELEE ATTACKED
int TalentMeleeAttacked(object oIntruder = OBJECT_INVALID)
{
    PushObject(oIntruder);
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_MELEE_ATTACKED);
}

// SPELL CASTER RANGED ATTACKED
int TalentRangedAttackers(object oIntruder = OBJECT_INVALID)
{
    PushObject(oIntruder);
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_RANGED_ATTACKERS);
}

// SPELL CASTER WITH RANGED ENEMIES
int TalentRangedEnemies(object oIntruder = OBJECT_INVALID)
{
    PushObject(oIntruder);
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_RANGED_ENEMIES);
}
    /*
        ISSUE 1: The check in this function to use a random ability after failing to use best will fail in the following
        case.  The creature is unable to affect the target with the spell and has only 1 spell of that type.  This can
        be eliminated with a check in the else to the effect of :

            else if(!CompareLastSpellCast(GetIdFromTalent(tUse)))

        This check was not put in in version 1.0 due to time constraints.
        May cause an AI loop in some Mages with limited spell selection.
    */
int TalentSpellAttack(object oIntruder)
{
    PushObject(oIntruder);
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_SPELL_ATTACK);
}


// SUMMON ALLIES
int TalentSummonAllies()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_SUMMON_ALLIES);
}

// HEAL SELF WITH POTIONS AND SPELLS
int TalentHealingSelf()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_HEALING_SELF);
}

// HEAL ALL ALLIES
int TalentHeal(int nForce = FALSE)
{
    PushInt(nForce);
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_HEAL);
}

// MELEE ATTACK OTHERS
/*
    ISSUE 1: Talent Melee Attack should set the Last Spell Used to 0 so that melee casters can use
    a single special ability.
*/

int TalentMeleeAttack(object oIntruder = OBJECT_INVALID)
{
    PushObject(oIntruder);
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_MELEE_ATTACK);
}

// SNEAK ATTACK OTHERS
int TalentSneakAttack()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_SNEAK_ATTACK);
}

// FLEE COMBAT AND HOSTILES
int TalentFlee(object oIntruder = OBJECT_INVALID)
{
    PushObject(oIntruder);
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_FLEE);
}

// TURN UNDEAD
int TalentUseTurning()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_USE_TURNING);
}

// ACTIVATE AURAS
int TalentPersistentAbilities()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_PERSISTENT_ABILITIES);
}

// FAST BUFF SELF
int TalentAdvancedBuff(float fDistance)
{
    PushFloat(fDistance);
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_ADVANCED_BUFF);
}

// USE POTIONS
int TalentBuffSelf()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_BUFF_SELF);
}

// USE SPELLS TO DEFEAT INVISIBLE CREATURES
// THIS TALENT IS NOT USED
int TalentSeeInvisible()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_SEE_INVISIBLE);
}

// CURE DISEASE, POISON ETC
int TalentCureCondition()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_CURE_CONDITION);
}

// DRAGON COMBAT
int TalentDragonCombat(object oIntruder = OBJECT_INVALID)
{
    PushObject(oIntruder);
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_DRAGON_COMBAT);
}

// BARD SONG
int TalentBardSong()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_BARD_SONG);
}

//************************************************************************************************************************************
//************************************************************************************************************************************
//************************************************************************************************************************************
// VERSION 2.0 TALENTS
//************************************************************************************************************************************
//************************************************************************************************************************************
//************************************************************************************************************************************

// ADVANCED PROTECT SELF Talent 2.0
// This will use the class specific defensive spells first and leave the rest for the normal defensive AI

int TalentAdvancedProtectSelf()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_TALENT_ADVANCED_PROTECT_SELF);
}

//************************************************************************************************************************************
//************************************************************************************************************************************
//************************************************************************************************************************************
// PRIVATE FUNCTIONS
//************************************************************************************************************************************
//************************************************************************************************************************************
//************************************************************************************************************************************

//This is experimental and has not been looked at closely.
void ExitAOESpellArea(object oAOEObject)
{
    PushObject(oAOEObject);
    DynCommand(SYM_NW_I0_GENERIC, SYM_EXIT_AOE_SPELL_AREA);
}


//::///////////////////////////////////////////////
//:: Get Character Levels
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Returns the combined class levels of the
    target.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 22, 2001
//:://////////////////////////////////////////////

int GetCharacterLevel(object oTarget)
{
    PushObject(oTarget);
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_CHARACTER_LEVEL);
}

//::///////////////////////////////////////////////
//:: Get Has Effect
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks to see if the target has a given
    spell effect
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 26, 2001
//:://////////////////////////////////////////////
int GetHasEffect(int nEffectType, object oTarget = OBJECT_SELF)
{
    PushInt(nEffectType); PushObject(oTarget);
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_HAS_EFFECT);
}

//::///////////////////////////////////////////////
//:: Check Friendly Fire on Target
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Takes a target object and a radius and
    returns how many targets of the caster's faction
    are in that zone.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On:  , 2001
//:://////////////////////////////////////////////

int CheckFriendlyFireOnTarget(object oTarget, float fDistance = 5.0)
{
    PushObject(oTarget); PushFloat(fDistance);
    return DynInt(SYM_NW_I0_GENERIC, SYM_CHECK_FRIENDLY_FIRE_ON_TARGET);
}

//::///////////////////////////////////////////////
//:: Check For Enemies Around Target
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Takes a target object and a radius and
    returns how many targets of the enemy faction
    are in that zone.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////
int CheckEnemyGroupingOnTarget(object oTarget, float fDistance = 5.0)
{
    PushObject(oTarget); PushFloat(fDistance);
    return DynInt(SYM_NW_I0_GENERIC, SYM_CHECK_ENEMY_GROUPING_ON_TARGET);
}

//::///////////////////////////////////////////////
//:: Find Single Ranged Target
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Seeks out an enemy more than 5m away and alone
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: October 5, 2001
//:://////////////////////////////////////////////

object FindSingleRangedTarget()
{
    return DynObject(SYM_NW_I0_GENERIC, SYM_FIND_SINGLE_RANGED_TARGET);
}

//::///////////////////////////////////////////////
//:: GetNumberOfMeleeAttackers
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check how many enemies are within 5m of the
    target object.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 11, 2001
//:://////////////////////////////////////////////
int GetNumberOfMeleeAttackers()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_NUMBER_OF_MELEE_ATTACKERS);
}

//::///////////////////////////////////////////////
//:: GetNumberOfRangedAttackers
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check how many enemies are attacking the
    target from as distance
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 12, 2001
//:://////////////////////////////////////////////
int GetNumberOfRangedAttackers()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_NUMBER_OF_RANGED_ATTACKERS);
}

//::///////////////////////////////////////////////
//:: Get Percentage of HP Loss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Returns a number between 0 and 1.0 that gives
    a representation of how wounded the target is.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 18, 2001
//:://////////////////////////////////////////////

int GetPercentageHPLoss(object oWounded)
{
    PushObject(oWounded);
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_PERCENTAGE_HP_LOSS);
}

//::///////////////////////////////////////////////
//:: Get Racial Type Count
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Counts and returns the number of a certain
    racial type within a certain radius.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 18, 2001
//:://////////////////////////////////////////////

int GetRacialTypeCount(int nRacial_Type)
{
    PushInt(nRacial_Type);
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_RACIAL_TYPE_COUNT);
}

//::///////////////////////////////////////////////
//:: Get Enemy Creature Seen or Heard
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function finds an enemy that can be seen
    first and if that fails an enemy that can be
    heard only.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 28, 2002
//:://////////////////////////////////////////////

object GetNearestSeenOrHeardEnemy()
{
    return DynObject(SYM_NW_I0_GENERIC, SYM_GET_NEAREST_SEEN_OR_HEARD_ENEMY);
}

//::///////////////////////////////////////////////
//:: Get / Set Compare Last Spell Cast
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gets the local int off of the character
    determining what the Last Spell Cast was.

    Sets the local int on of the character
    storing what the Last Spell Cast was.

    Compares whether the local is the same as the
    currently selected spell.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 27, 2002
//:://////////////////////////////////////////////

int GetLastGenericSpellCast()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_LAST_GENERIC_SPELL_CAST);
}

void SetLastGenericSpellCast(int nSpell)
{
    PushInt(nSpell);
    DynCommand(SYM_NW_I0_GENERIC, SYM_SET_LAST_GENERIC_SPELL_CAST);
}

int CompareLastSpellCast(int nSpell)
{
    PushInt(nSpell);
    return DynInt(SYM_NW_I0_GENERIC, SYM_COMPARE_LAST_SPELL_CAST);
}

//::///////////////////////////////////////////////
//:: Remove Ambient Sleep
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks if the NPC has sleep on them because
    of ambient animations. Sleeping creatures
    must make a DC 15 listen check.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 27, 2002
//:://////////////////////////////////////////////

void RemoveAmbientSleep()
{
    DynCommand(SYM_NW_I0_GENERIC, SYM_REMOVE_AMBIENT_SLEEP);
}

//::///////////////////////////////////////////////
//:: GetIsFighting
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks if the passed object has an Attempted
    Attack or Spell Target
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: March 13, 2002
//:://////////////////////////////////////////////
int GetIsFighting(object oFighting)
{
    PushObject(oFighting);
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_IS_FIGHTING);
}

//::///////////////////////////////////////////////
//:: Get Locked Object
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Finds the closest locked object to the object
    passed in up to a maximum of 10 objects.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: March 15, 2002
//:://////////////////////////////////////////////

object GetLockedObject(object oMaster)
{
    PushObject(oMaster);
    return DynObject(SYM_NW_I0_GENERIC, SYM_GET_LOCKED_OBJECT);
}

//::///////////////////////////////////////////////
//:: Equip Appropriate Weapons
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Makes the user get his best weapons.  If the
    user is a Henchmen then he checks the player
    preference.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 2, 2002
//:://////////////////////////////////////////////

void EquipAppropriateWeapons(object oTarget)
{
    PushObject(oTarget);
    DynCommand(SYM_NW_I0_GENERIC, SYM_EQUIP_APPROPRIATE_WEAPONS);
}

int AssociateCheck(object oCheck)
{
    PushObject(oCheck);
    return DynInt(SYM_NW_I0_GENERIC, SYM_ASSOCIATE_CHECK);
}

//::///////////////////////////////////////////////
//:: Verify Disarm
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks that the melee talent being used
    is Disarm and if so then if the target has a
    weapon.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

int VerifyDisarm(talent tUse, object oTarget)
{
    PushTalent(tUse); PushObject(oTarget);
    return DynInt(SYM_NW_I0_GENERIC, SYM_VERIFY_DISARM);
}

//::///////////////////////////////////////////////
//:: Verify Melee Talent Use
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Makes sure that certain talents are not used
    on Elementals, Undead or Constructs
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 23, 2002
//:://////////////////////////////////////////////
int VerifyCombatMeleeTalent(talent tUse, object oTarget)
{
    PushTalent(tUse); PushObject(oTarget);
    return DynInt(SYM_NW_I0_GENERIC, SYM_VERIFY_COMBAT_MELEE_TALENT);
}

//:://////////////////////////////////////////////////////////////////////////////////////////////
//:: Associate Include Functions
//:: NW_I0_ASSOCIATE
//:: Copyright (c) 2001 Bioware Corp.
//:://///////////////////////////////////////////////////////////////////////////////////////////
/*
    Determines and stores the behavior of the
    associates used by the PC
*/
//:://///////////////////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: November 16, 2001
//:://///////////////////////////////////////////////////////////////////////////////////////////

//Distance
int NW_ASC_DISTANCE_2_METERS =   0x00000001;
int NW_ASC_DISTANCE_4_METERS =   0x00000002;
int NW_ASC_DISTANCE_6_METERS =   0x00000004;
//Heal when
int NW_ASC_HEAL_AT_75 =          0x00000008;
int NW_ASC_HEAL_AT_50 =          0x00000010;
int NW_ASC_HEAL_AT_25 =          0x00000020;
//Auto AI
int NW_ASC_AGGRESSIVE_BUFF =     0x00000040;
int NW_ASC_AGGRESSIVE_SEARCH =   0x00000080;
int NW_ASC_AGGRESSIVE_STEALTH =  0x00000100;
//Open Locks on master fail
int NW_ASC_RETRY_OPEN_LOCKS =    0x00000200;
//Casting power
int NW_ASC_OVERKIll_CASTING =    0x00000400; // GetMax Spell
int NW_ASC_POWER_CASTING =       0x00000800; // Get Double CR or max 4 casting
int NW_ASC_SCALED_CASTING =      0x00001000; // CR + 4;

int NW_ASC_USE_CUSTOM_DIALOGUE = 0x00002000;
int NW_ASC_DISARM_TRAPS =        0x00004000;
int NW_ASC_USE_RANGED_WEAPON   = 0x00008000;
int NW_ASC_MODE_DEFEND_MASTER =  0x04000000; //Guard Me Mode, Attack Nearest sets this to FALSE.
int NW_ASC_MODE_STAND_GROUND =   0x08000000; //The Henchman will ignore move to object in the heartbeat
                                             //If this is set to FALSE then they are in follow mode
int NW_ASC_MASTER_GONE =         0x10000000;
int NW_ASC_MASTER_REVOKED =      0x20000000;
int NW_ASC_IS_BUSY =             0x40000000; //Only busy if attempting to bash or pick a lock
int NW_ASC_HAVE_MASTER =         0x80000000; //Not actually used, here for system continuity

void SetAssociateState(int nCondition, int bValid = TRUE)
{
    PushInt(nCondition); PushInt(bValid);
    DynCommand(SYM_NW_I0_GENERIC, SYM_SET_ASSOCIATE_STATE);
}

int GetAssociateState(int nCondition)
{
    PushInt(nCondition);
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_ASSOCIATE_STATE);
}

//::///////////////////////////////////////////////
//:: Get CR Max for Talents
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the Spell CR to be used in the
    given situation
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 18, 2001
//:://////////////////////////////////////////////

int GetAssociateCRMax()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_ASSOCIATE_CR_MAX);
}

//::///////////////////////////////////////////////
//:: Should I Heal My Master
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the healing variable for the master
    and then asks if the master if below that level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 18, 2001
//:://////////////////////////////////////////////

int GetAssociateHealMaster()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_ASSOCIATE_HEAL_MASTER);
}

float GetFollowDistance()
{
    return DynFloat(SYM_NW_I0_GENERIC, SYM_GET_FOLLOW_DISTANCE);
}


//::///////////////////////////////////////////////
//:: Check if an item is locked
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks that an item was unlocked.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 19, 2001
//:://////////////////////////////////////////////

void CheckIsUnlocked(object oLastObject)
{
    PushObject(oLastObject);
    DynCommand(SYM_NW_I0_GENERIC, SYM_CHECK_IS_UNLOCKED);
}

//::///////////////////////////////////////////////
//:: Set and Get Associate Start Location
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watmaniuk
//:: Created On: Nov 21, 2001
//:://////////////////////////////////////////////

void SetAssociateStartLocation()
{
    DynCommand(SYM_NW_I0_GENERIC, SYM_SET_ASSOCIATE_START_LOCATION);
}

location GetAssociateStartLocation()
{
    return DynLocation(SYM_NW_I0_GENERIC, SYM_GET_ASSOCIATE_START_LOCATION);
}

//::///////////////////////////////////////////////
//:: Play Mobile Ambient Animations
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Used for spawned creatures to not look like
    zombies
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 23, 2001
//:://////////////////////////////////////////////

void PlayMobileAmbientAnimations()
{
    DynCommand(SYM_NW_I0_GENERIC, SYM_PLAY_MOBILE_AMBIENT_ANIMATIONS);
}

//::///////////////////////////////////////////////
//:: Play Immobile Ambient Animations
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Used for spawned creatures to not look like
    zombies
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 23, 2001
//:://////////////////////////////////////////////

void PlayImmobileAmbientAnimations()
{
    DynCommand(SYM_NW_I0_GENERIC, SYM_PLAY_IMMOBILE_AMBIENT_ANIMATIONS);
}

//::///////////////////////////////////////////////
//:: Check for Walkways
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function checks if the passed in object
    has waypoints using their tag.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: MAy 13, 2002
//:://////////////////////////////////////////////
/*
    if(GetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING))
    {
        DayWayString = "WP_";
        NightWayString = "WN_";
        DayPostString = "POST_";
        NightPostString = "NIGHT_";
    }
    else
    {
        DayWayString = "WP_";
        NightWayString = "WP_";
        DayPostString = "POST_";
        NightPostString = "POST_";
    }
*/
int GetIsPostOrWalking(object oWalker = OBJECT_SELF)
{
    PushObject(oWalker);
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_IS_POST_OR_WALKING);
}
//:://////////////////////////////////////////////////////////////////////////////////////////////
//:: Special Behavior Functions
//:: Copyright (c) 2001 Bioware Corp.
//:://///////////////////////////////////////////////////////////////////////////////////////////
/*
    These commands handle the setting and getting of the Behavioral Master
    If these special behaviors are used they will override the normal behavior expected
    the animals normal Neutral Faction.
*/
//:://///////////////////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Dec 10, 2001
//:://///////////////////////////////////////////////////////////////////////////////////////////
void SetBehaviorState(int nCondition, int bValid = TRUE)
{
    PushInt(nCondition); PushInt(bValid);
    DynCommand(SYM_NW_I0_GENERIC, SYM_SET_BEHAVIOR_STATE);
}

int GetBehaviorState(int nCondition)
{
    PushInt(nCondition);
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_BEHAVIOR_STATE);
}

//::///////////////////////////////////////////////
//:: Determine Special Behavior
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the special behavior used by the NPC.
    Generally all NPCs who you want to behave differently
    than the defualt behavior.
    For these behaviors, passing in a valid object will
    cause the creature to become hostile the the attacker.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Dec 14, 2001
//:://////////////////////////////////////////////

void DetermineSpecialBehavior(object oIntruder = OBJECT_INVALID)
{
    PushObject(oIntruder);
    DynCommand(SYM_NW_I0_GENERIC, SYM_DETERMINE_SPECIAL_BEHAVIOR);
}

//::///////////////////////////////////////////////
//:: Reset Henchmen
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sets the henchmen to commandable, deletes locals
    having to do with doors and clears actions
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 4, 2002
//:://////////////////////////////////////////////

void ResetHenchmenState()
{
    DynCommand(SYM_NW_I0_GENERIC, SYM_RESET_HENCHMEN_STATE);
}

//::///////////////////////////////////////////////
//:: Bash Doors
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Used in DetermineCombatRound to keep a
    henchmen bashing doors.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 4, 2002
//:://////////////////////////////////////////////

int BashDoorCheck(object oIntruder = OBJECT_INVALID)
{
    PushObject(oIntruder);
    return DynInt(SYM_NW_I0_GENERIC, SYM_BASH_DOOR_CHECK);
}

//::///////////////////////////////////////////////
//:: Determine Class to Use
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines which of a NPCs three classes to
    use in DetermineCombatRound
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 4, 2002
//:://////////////////////////////////////////////

int DetermineClassToUse()
{
    return DynInt(SYM_NW_I0_GENERIC, SYM_DETERMINE_CLASS_TO_USE);
}

//::///////////////////////////////////////////////
//:: Determine Enemies
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Uses four general categories to determine what
    kinds of enemies the NPC is facing.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 4, 2002
//:://////////////////////////////////////////////

struct sEnemies DetermineEnemies()
{
    struct sEnemies sEnemies;
    DynCommand(SYM_NW_I0_GENERIC, SYM_DETERMINE_ENEMIES);
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
    return sEnemies;
}

//::///////////////////////////////////////////////
//:: Get Most Dangerious Class
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Use the four archetypes to determine the
    most dangerous group type facing the NPC
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 4, 2002
//:://////////////////////////////////////////////

string GetMostDangerousClass(struct sEnemies sCount)
{
    struct sEnemies sEnemies = sCount;
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
    return DynString(SYM_NW_I0_GENERIC, SYM_GET_MOST_DANGEROUS_CLASS);
}

//::///////////////////////////////////////////////
//:: Protection Matching Functions
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    These three functions break protections into
    3 categories COMBAT, SPELL and ELEMENTAL
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 4, 2002
//:://////////////////////////////////////////////

int GetMatchCompatibility(talent tUse, string sClass, int nType)
{
    PushTalent(tUse); PushString(sClass); PushInt(nType);
    return DynInt(SYM_NW_I0_GENERIC, SYM_GET_MATCH_COMPATIBILITY);
}

int MatchCombatProtections(talent tUse)
{
    PushTalent(tUse);
    return DynInt(SYM_NW_I0_GENERIC, SYM_MATCH_COMBAT_PROTECTIONS);
}

int MatchSpellProtections(talent tUse)
{
    PushTalent(tUse);
    return DynInt(SYM_NW_I0_GENERIC, SYM_MATCH_SPELL_PROTECTIONS);
}

int MatchElementalProtections(talent tUse)
{
    PushTalent(tUse);
    return DynInt(SYM_NW_I0_GENERIC, SYM_MATCH_ELEMENTAL_PROTECTIONS);
}

talent StartProtectionLoop()
{
    return DynTalent(SYM_NW_I0_GENERIC, SYM_START_PROTECTION_LOOP);
}

void DubugPrintTalentID(talent tTalent)
{
    PushTalent(tTalent);
    DynCommand(SYM_NW_I0_GENERIC, SYM_DUBUG_PRINT_TALENT_ID);
}
void MyPrintString(string sString)
{
    PushString(sString);
    DynCommand(SYM_NW_I0_GENERIC, SYM_MY_PRINT_STRING);
}

