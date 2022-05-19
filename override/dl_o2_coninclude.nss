//::///////////////////////////////////////////////
//:: Dynamic Treasure Library v1.0
//:: dl_i0_coninclude.nss
//:: Copyright (c) 2003 Francois Guimond
//:://////////////////////////////////////////////
/*
    This file performs all the static calls to the
    treasure library from the dynamic library
    interface.
*/
//:://////////////////////////////////////////////
//:: Created By: Francois Guimond
//:: Created On: Jan 25, 2003
//:://////////////////////////////////////////////

#include "dl_i0_core"
#include "_nw_o2_coninclud"

void main()
{

    switch (PopInt())
    {

        // void dbSpeak(string s);
        case 0x00: dbSpeak(PopString()); break;

        // void dbCreateItemOnObject(string sItemTemplate, object oTarget = OBJECT_SELF, int nStackSize = 1);
        case 0x01: dbCreateItemOnObject(PopString(), PopObject(), PopInt()); break;

        // object GetLastOpener();
        case 0x02: PushObject(GetLastOpener()); break;

        // int GetRange(int nCategory, int nHD);
        case 0x03: PushInt(GetRange(PopInt(), PopInt())); break;

        // int GetNumberOfItems(int nTreasureType);
        case 0x04: PushInt(GetNumberOfItems(PopInt())); break;

        // void CreateBook(object oTarget);
        case 0x05: CreateBook(PopObject());

        // void CreateAnimalPart(object oTarget);
        case 0x06: CreateAnimalPart(PopObject());

        // void CreateJunk(object oTarget);
        case 0x07: CreateJunk(PopObject()); break;

        // void CreateGold(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0);
        case 0x08: CreateGold(PopObject(), PopObject(), PopInt(), PopInt()); break;

        // void CreateGem(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0);
        case 0x09: CreateGem(PopObject(), PopObject(), PopInt(), PopInt()); break;

        // void CreateJewel(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0);
        case 0x0A: CreateJewel(PopObject(), PopObject(), PopInt(), PopInt()); break;

        // int TrimLevel(int nScroll, int nLevel);
        case 0x0B: PushInt(TrimLevel(PopInt(), PopInt())); break;

        // void CreateArcaneScroll(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x0C: CreateArcaneScroll(PopObject(), PopObject(), PopInt()); break;

        // void CreateDivineScroll(object oTarget, object oAdventurer, int nModifier=0);
        case 0x0D: CreateDivineScroll(PopObject(), PopObject(), PopInt()); break;

        // void CreateAmmo(object oTarget, object oAdventurer, int nModifier=0);
        case 0x0E: CreateAmmo(PopObject(), PopObject(), PopInt()); break;

        // void CreateTrapKit(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x0F: CreateTrapKit(PopObject(), PopObject(), PopInt()); break;

        // void CreateHealingKit(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x10: CreateHealingKit(PopObject(), PopObject(), PopInt()); break;

        // void CreateLockPick(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x11: CreateLockPick(PopObject(), PopObject(), PopInt()); break;

        // void CreateKit(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x12: CreateKit(PopObject(), PopObject(), PopInt()); break;

        // void CreatePotion(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x13: CreatePotion(PopObject(), PopObject(), PopInt()); break;

        // void CreateGenericMiscItem(object oTarget, object oAdventurer, int nModifier=0);
        case 0x14: CreateGenericMiscItem(PopObject(), PopObject(), PopInt()); break;

        // void CreateGenericClassItem(object oTarget, object oAdventurer, int nSpecific =0);
        case 0x15: CreateGenericClassItem(PopObject(), PopObject(), PopInt()); break;

        // void CreateGenericRodStaffWand(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x16: CreateGenericRodStaffWand(PopObject(), PopObject(), PopInt()); break;

        // void CreateGenericMonkWeapon(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x17: CreateGenericMonkWeapon(PopObject(), PopObject(), PopInt()); break;

        // void CreateSpecificMonkWeapon(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x18: CreateSpecificMonkWeapon(PopObject(), PopObject(), PopInt()); break;

        // void CreateGenericDruidWeapon(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x19: CreateGenericDruidWeapon(PopObject(), PopObject(), PopInt()); break;

        // void CreateSpecificDruidWeapon(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x1A: CreateSpecificDruidWeapon(PopObject(), PopObject(), PopInt()); break;

        // void CreateGenericWizardWeapon(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x1B: CreateGenericWizardWeapon(PopObject(), PopObject(), PopInt()); break;

        // void CreateSpecificWizardWeapon(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x1C: CreateSpecificWizardWeapon(PopObject(), PopObject(), PopInt()); break;

        // void CreateGenericSimple(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x1D: CreateGenericSimple(PopObject(), PopObject(), PopInt()); break;

        // void CreateGenericMartial(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x1E: CreateGenericMartial(PopObject(), PopObject(), PopInt()); break;

        // void CreateGenericExotic(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x1F: CreateGenericExotic(PopObject(), PopObject(), PopInt()); break;

        // void CreateGenericLightArmor(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x20: CreateGenericLightArmor(PopObject(), PopObject(), PopInt()); break;

        // void CreateGenericMediumArmor(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x21: CreateGenericMediumArmor(PopObject(), PopObject(), PopInt()); break;

        // void CreateGenericHeavyArmor(object oTarget, object oAdventurer, int nModifier = 0);
        case 0x22: CreateGenericHeavyArmor(PopObject(), PopObject(), PopInt()); break;

        // void CreateSpecificMiscItem(object oTarget,object oAdventurer);
        case 0x23: CreateSpecificMiscItem(PopObject(), PopObject()); break;

        // void CreateSpecificRodStaffWand(object oTarget, object oAdventurer);
        case 0x24: CreateSpecificRodStaffWand(PopObject(), PopObject()); break;

        // void CreateSpecificSimple(object oTarget, object oAdventurer);
        case 0x25: CreateSpecificSimple(PopObject(), PopObject()); break;

        // void CreateSpecificMartial(object oTarget, object oAdventurer);
        case 0x26: CreateSpecificMartial(PopObject(), PopObject()); break;

        // void CreateSpecificExotic(object oTarget, object oAdventurer);
        case 0x27: CreateSpecificExotic(PopObject(), PopObject()); break;

        // void CreateSpecificLightArmor(object oTarget, object oAdventurer);
        case 0x28: CreateSpecificLightArmor(PopObject(), PopObject()); break;

        // void CreateSpecificMediumArmor(object oTarget, object oAdventurer);
        case 0x29: CreateSpecificMediumArmor(PopObject(), PopObject()); break;

        // void CreateSpecificHeavyArmor(object oTarget, object oAdventurer);
        case 0x2A: CreateSpecificHeavyArmor(PopObject(), PopObject()); break;

        // void CreateTable2Item(object oTarget, object oAdventurer, int nSpecific=0);
        case 0x2B: CreateTable2Item(PopObject(), PopObject(), PopInt()); break;

        // void GenerateTreasure(int nTreasureType, object oLastOpener, object oCreateOn);
        case 0x2C: GenerateTreasure(PopInt(), PopObject(), PopObject()); break;

        // void GenerateLowTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID);
        case 0x2D: GenerateLowTreasure(PopObject(), PopObject()); break;

        // void GenerateMediumTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID);
        case 0x2E: GenerateMediumTreasure(PopObject(), PopObject()); break;

        // void GenerateHighTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID);
        case 0x2F: GenerateHighTreasure(PopObject(), PopObject()); break;

        // void GenerateBossTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID);
        case 0x30: GenerateBossTreasure(PopObject(), PopObject()); break;

        // void GenerateBookTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID);
        case 0x31: GenerateBookTreasure(PopObject(), PopObject()); break;

        // void GenerateNPCTreasure(int nTreasureValue=1, object oTreasureGetter=OBJECT_SELF, object oKiller=OBJECT_SELF);
        case 0x32: GenerateNPCTreasure(PopInt(), PopObject(), PopObject()); break;

        // void ShoutDisturbed();
        case 0x33: ShoutDisturbed(); break;

        // int nDetermineClassToUse(object oCharacter);
        case 0x34: PushInt(nDetermineClassToUse(PopObject())); break;

    }

}

