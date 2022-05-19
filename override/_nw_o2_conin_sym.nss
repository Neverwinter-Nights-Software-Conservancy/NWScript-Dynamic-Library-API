//::///////////////////////////////////////////////
//:: Dynamic Treasure Library Symbols v1.0
//:: _nw_o2_conin_sym.nss
//:: Copyright (c) 2003 Francois Guimond
//:://////////////////////////////////////////////
/*
    This file contains all the symbols used to
    communicate with dl_o2_coninclude.
*/
//:://////////////////////////////////////////////
//:: Created By: Francois Guimond
//:: Created On: Jan 25, 2003
//:://////////////////////////////////////////////

// library symbol
string SYM_NW_O2_CONINCLUDE = "dl_o2_coninclude";

// void dbSpeak(string s);
int SYM_DB_SPEAK = 0x00;
// void dbCreateItemOnObject(string sItemTemplate, object oTarget = OBJECT_SELF, int nStackSize = 1);
int SYM_DB_CREATE_ITEM_ON_OBJECT = 0x01;
// object GetLastOpener();
int SYM_GET_LAST_OPENER = 0x02;
// int GetRange(int nCategory, int nHD);
int SYM_GET_RANGE = 0x03;
// int GetNumberOfItems(int nTreasureType);
int SYM_GET_NUMBER_OF_ITEMS = 0x04;
// void CreateBook(object oTarget);
int SYM_CREATE_BOOK = 0x05;
// void CreateAnimalPart(object oTarget);
int SYM_CREATE_ANIMAL_PART = 0x06;
// void CreateJunk(object oTarget);
int SYM_CREATE_JUNK = 0x07;
// void CreateGold(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0);
int SYM_CREATE_GOLD = 0x08;
// void CreateGem(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0);
int SYM_CREATE_GEM = 0x09;
// void CreateJewel(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0);
int SYM_CREATE_JEWEL = 0x0A;
// int TrimLevel(int nScroll, int nLevel);
int SYM_TRIM_LEVEL = 0x0B;
// void CreateArcaneScroll(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_ARCANE_SCROLL = 0x0C;
// void CreateDivineScroll(object oTarget, object oAdventurer, int nModifier=0);
int SYM_CREATE_DIVINE_SCROLL = 0x0D;
// void CreateAmmo(object oTarget, object oAdventurer, int nModifier=0);
int SYM_CREATE_AMMO = 0x0E;
// void CreateTrapKit(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_TRAP_KIT = 0x0F;
// void CreateHealingKit(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_HEALING_KIT = 0x10;
// void CreateLockPick(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_LOCK_PICK = 0x11;
// void CreateKit(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_KIT = 0x12;
// void CreatePotion(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_POTION = 0x13;
// void CreateGenericMiscItem(object oTarget, object oAdventurer, int nModifier=0);
int SYM_CREATE_GENERIC_MISC_ITEM = 0x14;
// void CreateGenericClassItem(object oTarget, object oAdventurer, int nSpecific =0);
int SYM_CREATE_GENERIC_CLASS_ITEM = 0x15;
// void CreateGenericRodStaffWand(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_GENERIC_ROD_STAFF_WAND = 0x16;
// void CreateGenericMonkWeapon(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_GENERIC_MONK_WEAPON = 0x17;
// void CreateSpecificMonkWeapon(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_SPECIFIC_MONK_WEAPON = 0x18;
// void CreateGenericDruidWeapon(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_GENERIC_DRUID_WEAPON = 0x19;
// void CreateSpecificDruidWeapon(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_SPECIFIC_DRUID_WEAPON = 0x1A;
// void CreateGenericWizardWeapon(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_GENERIC_WIZARD_WEAPON = 0x1B;
// void CreateSpecificWizardWeapon(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_SPECIFIC_WIZARD_WEAPON = 0x1C;
// void CreateGenericSimple(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_GENERIC_SIMPLE = 0x1D;
// void CreateGenericMartial(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_GENERIC_MARTIAL = 0x1E;
// void CreateGenericExotic(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_GENERIC_EXOTIC = 0x1F;
// void CreateGenericLightArmor(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_GENERIC_LIGHT_ARMOR = 0x20;
// void CreateGenericMediumArmor(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_GENERIC_MEDIUM_ARMOR = 0x21;
// void CreateGenericHeavyArmor(object oTarget, object oAdventurer, int nModifier = 0);
int SYM_CREATE_GENERIC_HEAVY_ARMOR = 0x22;
// void CreateSpecificMiscItem(object oTarget,object oAdventurer);
int SYM_CREATE_SPECIFIC_MISC_ITEM = 0x23;
// void CreateSpecificRodStaffWand(object oTarget, object oAdventurer);
int SYM_CREATE_SPECIFIC_ROD_STAFF_WAND = 0x24;
// void CreateSpecificSimple(object oTarget, object oAdventurer);
int SYM_CREATE_SPECIFIC_SIMPLE = 0x25;
// void CreateSpecificMartial(object oTarget, object oAdventurer);
int SYM_CREATE_SPECIFIC_MARTIAL = 0x26;
// void CreateSpecificExotic(object oTarget, object oAdventurer);
int SYM_CREATE_SPECIFIC_EXOTIC = 0x27;
// void CreateSpecificLightArmor(object oTarget, object oAdventurer);
int SYM_CREATE_SPECIFIC_LIGHT_ARMOR = 0x28;
// void CreateSpecificMediumArmor(object oTarget, object oAdventurer);
int SYM_CREATE_SPECIFIC_MEDIUM_ARMOR = 0x29;
// void CreateSpecificHeavyArmor(object oTarget, object oAdventurer);
int SYM_CREATE_SPECIFIC_HEAVY_ARMOR = 0x2A;
// void CreateTable2Item(object oTarget, object oAdventurer, int nSpecific=0);
int SYM_CREATE_TABLE_2_ITEM = 0x2B;
// void GenerateTreasure(int nTreasureType, object oLastOpener, object oCreateOn);
int SYM_GENERATE_TREASURE = 0x2C;
// void GenerateLowTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID);
int SYM_GENERATE_LOW_TREASURE = 0x2D;
// void GenerateMediumTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID);
int SYM_GENERATE_MEDIUM_TREASURE = 0x2E;
// void GenerateHighTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID);
int SYM_GENERATE_HIGH_TREASURE = 0x2F;
// void GenerateBossTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID);
int SYM_GENERATE_BOSS_TREASURE = 0x30;
// void GenerateBookTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID);
int SYM_GENERATE_BOOK_TREASURE = 0x31;
// void GenerateNPCTreasure(int nTreasureValue=1, object oTreasureGetter=OBJECT_SELF, object oKiller=OBJECT_SELF);
int SYM_GENERATE_NPC_TREASURE = 0x32;
// void ShoutDisturbed();
int SYM_SHOUT_DISTURBED = 0x33;
// int nDetermineClassToUse(object oCharacter);
int SYM_N_DETERMINE_CLASS_TO_USE = 0x34;

