//::///////////////////////////////////////////////
//:: NW_O2_CONINCLUDE.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  This include file handles the random treasure
  distribution for treasure from creatures and containers

 [ ] Documented
*/
//:://////////////////////////////////////////////
//:: Created By:  Brent, Andrew
//:: Created On:  November - May
//:://////////////////////////////////////////////
// :: MODS
// April 23 2002: Removed animal parts. They were silly.
// May 6 2002: Added Undead to the EXCLUSION treasure list (they drop nothing now)
//  - redistributed treasure (to lessen amoun   t of armor and increase 'class specific treasure'
//  - Rangers with heavy armor prof. will be treated as Fighters else as Barbarians
//  - Gave wizards, druids and monk their own function
// MAY 29 2002: Removed the heal potion from treasure
//              Moved nymph cloak +4 to treasure bracket 6
//              Added Monk Enhancement items to random treasure
//:://////////////////////////////////////////////
//:: Modified By: Francois Guimond
//:: Modified On: Jan 25, 2003
//:: Converted to a dynamic library.
//:://////////////////////////////////////////////

#include "_nw_o2_conin_sym"

// * ---------
// * CONSTANTS
// * ---------


// * tweaking constants

    // * SIX LEVEL RANGES
    int RANGE_1_MIN = 0;
    int RANGE_1_MAX = 5;
    int RANGE_2_MIN = 6;
    int RANGE_2_MAX = 8;

    int RANGE_3_MIN = 9;
    int RANGE_3_MAX = 10;

    int RANGE_4_MIN = 11;
    int RANGE_4_MAX = 13;

    int RANGE_5_MIN = 14;
    int RANGE_5_MAX = 16;

    int RANGE_6_MIN = 17;
    int RANGE_6_MAX = 100;

    // * NUMBER OF ITEMS APPEARING
    int NUMBER_LOW_ONE   = 100; int NUMBER_MED_ONE    = 60; int NUMBER_HIGH_ONE   = 40;  int NUMBER_BOSS_ONE = 100;
    int NUMBER_LOW_TWO   = 0;   int NUMBER_MED_TWO    = 30; int NUMBER_HIGH_TWO   = 40;  int NUMBER_BOSS_TWO = 0;
    int NUMBER_LOW_THREE = 0;   int NUMBER_MED_THREE  = 10; int NUMBER_HIGH_THREE = 20;  int NUMBER_BOSS_THREE = 0;

    int NUMBER_BOOK_ONE = 75;
    int NUMBER_BOOK_TWO = 20;
    int NUMBER_BOOK_THREE = 5;

    // * AMOUNT OF GOLD BY VALUE
    float LOW_MOD_GOLD = 0.5;   float MEDIUM_MOD_GOLD = 1.0; float HIGH_MOD_GOLD = 3.0;
    // * FREQUENCY OF ITEM TYPE APPEARING BY TREASURE TYPE
    int LOW_PROB_BOOK    = 1;  int MEDIUM_PROB_BOOK =   1;  int HIGH_PROB_BOOK =1;
    int LOW_PROB_ANIMAL  = 0;  int MEDIUM_PROB_ANIMAL = 0;  int HIGH_PROB_ANIMAL = 0;
    int LOW_PROB_JUNK    = 2;  int MEDIUM_PROB_JUNK =    1;  int HIGH_PROB_JUNK = 1;
    int LOW_PROB_GOLD = 43;    int MEDIUM_PROB_GOLD =   38; int HIGH_PROB_GOLD = 15;
    int LOW_PROB_GEM  = 9;     int MEDIUM_PROB_GEM =    15; int HIGH_PROB_GEM = 15;
    int LOW_PROB_JEWEL = 4;    int MEDIUM_PROB_JEWEL =  6; int HIGH_PROB_JEWEL = 15;
    int LOW_PROB_ARCANE = 3;   int MEDIUM_PROB_ARCANE = 3; int HIGH_PROB_ARCANE = 3;
    int LOW_PROB_DIVINE = 3;   int MEDIUM_PROB_DIVINE = 3;  int HIGH_PROB_DIVINE = 3;
    int LOW_PROB_AMMO = 10;    int MEDIUM_PROB_AMMO =   5;  int HIGH_PROB_AMMO  =   3;
    int LOW_PROB_KIT = 5;      int MEDIUM_PROB_KIT =    5;  int HIGH_PROB_KIT   =   5;
    int LOW_PROB_POTION =17;   int MEDIUM_PROB_POTION = 20; int HIGH_PROB_POTION=   9;
    int LOW_PROB_TABLE2 = 3;   int MEDIUM_PROB_TABLE2 = 3; int HIGH_PROB_TABLE2=   30;


// * readability constants

int    TREASURE_LOW = 1;
int    TREASURE_MEDIUM = 2;
int    TREASURE_HIGH = 3;
int    TREASURE_BOSS = 4;
int    TREASURE_BOOK = 5;


// * JUMP_LEVEL is used in a Specific item function
// * in the case where a generic item is called for within that function
// * it will create a generic item by adding JUMP_LEVEL to the character's
// * hit die for the purposes of the treasure evaluation.
// * May 2002: Lowered JUMP_LEVEL from 3 to 2

int JUMP_LEVEL = 2;


//* Declarations
    void CreateGenericExotic(object oTarget, object oAdventurer, int nModifier = 0);
    void CreateGenericMonkWeapon(object oTarget, object oAdventurer, int nModifier = 0);
    void CreateSpecificMonkWeapon(object oTarget, object oAdventurer, int nModifier = 0);
    void CreateGenericDruidWeapon(object oTarget, object oAdventurer, int nModifier = 0);
    void CreateSpecificDruidWeapon(object oTarget, object oAdventurer, int nModifier = 0);
    void CreateGenericWizardWeapon(object oTarget, object oAdventurer, int nModifier = 0);
    void CreateSpecificWizardWeapon(object oTarget, object oAdventurer, int nModifier = 0);
    int nDetermineClassToUse(object oCharacter);


// *
// * IMPLEMENTATION
// *

// * Comment the speakstring in to debug treasure generation
void dbSpeak(string s)
{
    PushString(s);
    DynCommand(SYM_NW_O2_CONINCLUDE, SYM_DB_SPEAK);
}

//* made this function to help with debugging
void dbCreateItemOnObject(string sItemTemplate, object oTarget = OBJECT_SELF, int nStackSize = 1)
{
    PushString(sItemTemplate); PushObject(oTarget); PushInt(nStackSize);
    DynCommand(SYM_NW_O2_CONINCLUDE, SYM_DB_CREATE_ITEM_ON_OBJECT);
}


// *
// * GET FUNCTIONS
// *

// * Returns the object that either last opened the container or destroyed it
object GetLastOpener()
{
    return DynObject(SYM_NW_O2_CONINCLUDE, SYM_GET_LAST_OPENER);
}

//::///////////////////////////////////////////////
//:: GetRange
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Returns true if nHD matches the correct
    level range for the indicated nCategory.
    (i.e., First to Fourth level characters
    are considered Range1)
*/
//:://////////////////////////////////////////////
//:: Created By:  Brent
//:: Created On:
//:://////////////////////////////////////////////
int GetRange(int nCategory, int nHD)
{
    PushInt(nCategory); PushInt(nHD);
    return DynInt(SYM_NW_O2_CONINCLUDE, SYM_GET_RANGE);
}

//::///////////////////////////////////////////////
//:: GetNumberOfItems
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Returns the number of items to create.
*/
//:://////////////////////////////////////////////
//:: Created By:  Brent
//:: Created On:
//:://////////////////////////////////////////////
int GetNumberOfItems(int nTreasureType)
{
    PushInt(nTreasureType);
    return DynInt(SYM_NW_O2_CONINCLUDE, SYM_GET_NUMBER_OF_ITEMS);
}


// *
// * TREASURE GENERATION FUNCTIONS
// *
    // *
    // * Non-Scaling Treasure
    // *
    void CreateBook(object oTarget)
    {
        PushObject(oTarget);
        DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_BOOK);
    }

    void CreateAnimalPart(object oTarget)
    {
        PushObject(oTarget);
        DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_ANIMAL_PART);
    }

    void CreateJunk(object oTarget)
    {
        PushObject(oTarget);
        DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_JUNK);
    }
    // *
    // * Scaling Treasure
    // *
    void CreateGold(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {
        PushObject(oTarget); PushObject(oAdventurer); PushInt(nTreasureType); PushInt(nModifier);
        DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_GOLD);
    }
    void CreateGem(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {
        PushObject(oTarget); PushObject(oAdventurer); PushInt(nTreasureType); PushInt(nModifier);
        DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_GEM);
    }
    void CreateJewel(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {
        PushObject(oTarget); PushObject(oAdventurer); PushInt(nTreasureType); PushInt(nModifier);
        DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_JEWEL);
    }
    // * returns the valid upper limit for any arcane spell scroll
    int TrimLevel(int nScroll, int nLevel)
    {
        PushInt(nScroll); PushInt(nLevel);
        return DynInt(SYM_NW_O2_CONINCLUDE, SYM_TRIM_LEVEL);
    }
    // * nModifier is to 'raise' the level of the oAdventurer
    void CreateArcaneScroll(object oTarget, object oAdventurer, int nModifier = 0)
    {
        PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
        DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_ARCANE_SCROLL);
    }

    void CreateDivineScroll(object oTarget, object oAdventurer, int nModifier=0)
    {
        PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
        DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_DIVINE_SCROLL);
    }
    void CreateAmmo(object oTarget, object oAdventurer, int nModifier=0)
    {
        PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
        DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_AMMO);
    }

    void CreateTrapKit(object oTarget, object oAdventurer, int nModifier = 0)
    {
        PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
        DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_TRAP_KIT);
    }
    void CreateHealingKit(object oTarget, object oAdventurer, int nModifier = 0)
    {
        PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
        DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_HEALING_KIT);
    }
    void CreateLockPick(object oTarget, object oAdventurer, int nModifier = 0)
    {
        PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
        DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_LOCK_PICK);
    }
    void CreateKit(object oTarget, object oAdventurer, int nModifier = 0)
    {
        PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
        DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_KIT);
    }

    void CreatePotion(object oTarget, object oAdventurer, int nModifier = 0)
    {
        PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
        DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_POTION);
    }
    //::///////////////////////////////////////////////
    //:: CreateTable2GenericItem
    //:: Copyright (c) 2002 Bioware Corp.
    //:://////////////////////////////////////////////
    /*
        Creates an item based upon the class of
        oAdventurer
    */
    //:://////////////////////////////////////////////
    //:: Created By:  Brent
    //:: Created On:
    //:://////////////////////////////////////////////
        void CreateGenericMiscItem(object oTarget, object oAdventurer, int nModifier=0)
        {
            PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_GENERIC_MISC_ITEM);
        }

         // * this function just returns an item that is more appropriate
         // * for this class. Only wizards, sorcerers, clerics, monks, rogues and bards get this
        void CreateGenericClassItem(object oTarget, object oAdventurer, int nSpecific =0)
        {
            PushObject(oTarget); PushObject(oAdventurer); PushInt(nSpecific);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_GENERIC_CLASS_ITEM);
        }
        void CreateGenericRodStaffWand(object oTarget, object oAdventurer, int nModifier = 0)
        {
            PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_GENERIC_ROD_STAFF_WAND);
        }

        void CreateGenericMonkWeapon(object oTarget, object oAdventurer, int nModifier = 0)
        {
            PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_GENERIC_MONK_WEAPON);
        }
        void CreateSpecificMonkWeapon(object oTarget, object oAdventurer, int nModifier = 0)
        {
            PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_SPECIFIC_MONK_WEAPON);
        }

        void CreateGenericDruidWeapon(object oTarget, object oAdventurer, int nModifier = 0)
        {
            PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_GENERIC_DRUID_WEAPON);
        }
        void CreateSpecificDruidWeapon(object oTarget, object oAdventurer, int nModifier = 0)
        {
            PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_SPECIFIC_DRUID_WEAPON);
        }

        void CreateGenericWizardWeapon(object oTarget, object oAdventurer, int nModifier = 0)
        {
            PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_GENERIC_WIZARD_WEAPON);
        }
        void CreateSpecificWizardWeapon(object oTarget, object oAdventurer, int nModifier = 0)
        {
            PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_SPECIFIC_WIZARD_WEAPON);
        }

        void CreateGenericSimple(object oTarget, object oAdventurer, int nModifier = 0)
        {
            PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_GENERIC_SIMPLE);
        }
        void CreateGenericMartial(object oTarget, object oAdventurer, int nModifier = 0)
        {
            PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_GENERIC_MARTIAL);
        }
        void CreateGenericExotic(object oTarget, object oAdventurer, int nModifier = 0)
        {
            PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_GENERIC_EXOTIC);
        }
        void CreateGenericLightArmor(object oTarget, object oAdventurer, int nModifier = 0)
        {
            PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_GENERIC_LIGHT_ARMOR);
        }
        void CreateGenericMediumArmor(object oTarget, object oAdventurer, int nModifier = 0)
        {
            PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_GENERIC_MEDIUM_ARMOR);
        }
        void CreateGenericHeavyArmor(object oTarget, object oAdventurer, int nModifier = 0)
        {
            PushObject(oTarget); PushObject(oAdventurer); PushInt(nModifier);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_GENERIC_HEAVY_ARMOR);
        }
        // *
        // * SPECIC TREASURE ITEMS (re: Named Items)
        // *
        void CreateSpecificMiscItem(object oTarget,object oAdventurer)
        {
            PushObject(oTarget); PushObject(oAdventurer);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_SPECIFIC_MISC_ITEM);
        }
        void CreateSpecificRodStaffWand(object oTarget, object oAdventurer)
        {
            PushObject(oTarget); PushObject(oAdventurer);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_SPECIFIC_ROD_STAFF_WAND);
        }


        void CreateSpecificSimple(object oTarget, object oAdventurer)
        {
            PushObject(oTarget); PushObject(oAdventurer);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_SPECIFIC_SIMPLE);
        }
        void CreateSpecificMartial(object oTarget, object oAdventurer)
        {
            PushObject(oTarget); PushObject(oAdventurer);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_SPECIFIC_MARTIAL);
        }
        void CreateSpecificExotic(object oTarget, object oAdventurer)
        {
            PushObject(oTarget); PushObject(oAdventurer);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_SPECIFIC_EXOTIC);
        }
        void CreateSpecificLightArmor(object oTarget, object oAdventurer)
        {
            PushObject(oTarget); PushObject(oAdventurer);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_SPECIFIC_LIGHT_ARMOR);
        }
        void CreateSpecificMediumArmor(object oTarget, object oAdventurer)
        {
            PushObject(oTarget); PushObject(oAdventurer);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_SPECIFIC_MEDIUM_ARMOR);
        }
        void CreateSpecificHeavyArmor(object oTarget, object oAdventurer)
        {
            PushObject(oTarget); PushObject(oAdventurer);
            DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_SPECIFIC_HEAVY_ARMOR);
        }
        // * if nSpecific is = 1 then spawn in 'named' items at the higher levels
    void CreateTable2Item(object oTarget, object oAdventurer, int nSpecific=0)
    {
        PushObject(oTarget); PushObject(oAdventurer); PushInt(nSpecific);
        DynCommand(SYM_NW_O2_CONINCLUDE, SYM_CREATE_TABLE_2_ITEM);
    }

//::///////////////////////////////////////////////
//:: GenerateTreasure
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Generate Treasure
   NOTE: When used by NPCs, the treasure is scaled
   to how powerful the NPC is.

   If used by containers, it is scaled by how
   powerful the PC is.

   PARAMETERS
   oLastOpener = The creature that opened the container
   oCreateOn = The place to put the treasure. If this is
    invalid then the treasure is placed on oLastOpener


*/
//:://////////////////////////////////////////////
//:: Created By:  Andrew
//:: Created On:
//:://////////////////////////////////////////////
void GenerateTreasure(int nTreasureType, object oLastOpener, object oCreateOn)
{
    PushInt(nTreasureType); PushObject(oLastOpener); PushObject(oCreateOn);
    DynCommand(SYM_NW_O2_CONINCLUDE, SYM_GENERATE_TREASURE);
}
void GenerateLowTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID)
{
    PushObject(oLastOpener); PushObject(oCreateOn);
    DynCommand(SYM_NW_O2_CONINCLUDE, SYM_GENERATE_LOW_TREASURE);
}
void GenerateMediumTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID)
{
    PushObject(oLastOpener); PushObject(oCreateOn);
    DynCommand(SYM_NW_O2_CONINCLUDE, SYM_GENERATE_MEDIUM_TREASURE);
}
void GenerateHighTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID)
{
    PushObject(oLastOpener); PushObject(oCreateOn);
    DynCommand(SYM_NW_O2_CONINCLUDE, SYM_GENERATE_HIGH_TREASURE);
}
void GenerateBossTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID)
{
    PushObject(oLastOpener); PushObject(oCreateOn);
    DynCommand(SYM_NW_O2_CONINCLUDE, SYM_GENERATE_BOSS_TREASURE);
}
void GenerateBookTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID)
{
    PushObject(oLastOpener); PushObject(oCreateOn);
    DynCommand(SYM_NW_O2_CONINCLUDE, SYM_GENERATE_BOOK_TREASURE);
}
//::///////////////////////////////////////////////
//:: GenerateNPCTreasure
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Preferrably called from OnSpawn scripts.
   Use the random treasure functions to generate
   appropriate treasure for the creature to drop.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: January 2002
//:://////////////////////////////////////////////

void GenerateNPCTreasure(int nTreasureValue=1, object oTreasureGetter=OBJECT_SELF, object oKiller=OBJECT_SELF)
{
    PushInt(nTreasureValue); PushObject(oTreasureGetter); PushObject(oKiller);
    DynCommand(SYM_NW_O2_CONINCLUDE, SYM_GENERATE_NPC_TREASURE);
}

// *
// * Theft Prevention
// *

//::///////////////////////////////////////////////
//:: ShoutDisturbed
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

// * Container shouts if disturbed
void ShoutDisturbed()
{
    DynCommand(SYM_NW_O2_CONINCLUDE, SYM_SHOUT_DISTURBED);
}


//::///////////////////////////////////////////////
//:: Determine Class to Use
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines which of a NPCs three classes to
    use in the random treasure system
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 4, 2002
//:://////////////////////////////////////////////

int nDetermineClassToUse(object oCharacter)
{
    PushObject(oCharacter);
    return DynInt(SYM_NW_O2_CONINCLUDE, SYM_N_DETERMINE_CLASS_TO_USE);
}



