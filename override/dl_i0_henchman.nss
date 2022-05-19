//::///////////////////////////////////////////////
//:: Dynamic Henchman Library v1.0
//:: dl_i0_henchman.nss
//:: Copyright (c) 2003 Francois Guimond
//:://////////////////////////////////////////////
/*
    This file performs all the static calls to the
    henchman library from the dynamic library
    interface.
*/
//:://////////////////////////////////////////////
//:: Created By: Francois Guimond
//:: Created On: Jan 25, 2003
//:://////////////////////////////////////////////

#include "dl_i0_core"
#include "_nw_i0_henchman"

void main()
{

    switch (PopInt())
    {

        // object PC();
        case 0x00: PushObject(PC()); break;

        // void SetDidDie(int bDie);
        case 0x01: SetDidDie(PopInt()); break;

        // int GetDidDie();
        case 0x02: PushInt(GetDidDie()); break;

        // void SetBeenHired(int bHired=TRUE, object oTarget=OBJECT_SELF);
        case 0x03: SetBeenHired(PopInt(), PopObject()); break;

        // int GetBeenHired(object oTarget=OBJECT_SELF);
        case 0x04: PushInt(GetBeenHired(PopObject())); break;

        // void SetWorkingForPlayer(object oPC);
        case 0x05: SetWorkingForPlayer(PopObject()); break;

        // int GetWorkingForPlayer(object oPC);
        case 0x06: PushInt(GetWorkingForPlayer(PopObject())); break;

        // object GetFormerMaster(object oHench = OBJECT_SELF);
        case 0x07: PushObject(GetFormerMaster(PopObject())); break;

        // void SetFormerMaster(object oPC, object oHench);
        case 0x08: SetFormerMaster(PopObject(), PopObject()); break;

        // void SetStoryVar(int nChapter, int nVal, object oTarget=OBJECT_SELF);
        case 0x09: SetStoryVar(PopInt(), PopInt(), PopObject()); break;

        // int GetStoryVar(int nChapter, object oTarget=OBJECT_SELF);
        case 0x0A: PushInt(GetStoryVar(PopInt(), PopObject())); break;

        // void SetGreetingVar(int nChapter, object oPC);
        case 0x0B: SetGreetingVar(PopInt(), PopObject()); break;

        // int GetGreetingVar(int nChapter, object oPC);
        case 0x0C: PushInt(GetGreetingVar(PopInt(), PopObject())); break;

        // string STR_PersonalItem(object oThing=OBJECT_SELF);
        case 0x0D: PushString(STR_PersonalItem(PopObject())); break;

        // string STR_QuestItem(int nChapter, object oThing=OBJECT_SELF);
        case 0x0E: PushString(STR_QuestItem(PopInt(), PopObject())); break;

        // string STR_RewardItem(int nChapter, object oThing=OBJECT_SELF);
        case 0x0F: PushString(STR_RewardItem(PopInt(), PopObject())); break;

        // void DestroyAllPersonalItems(object oPC);
        case 0x10: DestroyAllPersonalItems(PopObject()); break;

        // void GivePersonalItem(object oPC, object oHench=OBJECT_SELF);
        case 0x11: GivePersonalItem(PopObject(), PopObject()); break;

        // int HasPersonalItem(object oPC);
        case 0x12: PushInt(HasPersonalItem(PopObject())); break;

        // void StripAllPersonalItemsFromEveryone();
        case 0x13: StripAllPersonalItemsFromEveryone(); break;

        // int GetCanLevelUp(object oPC, object meLevel = OBJECT_SELF);
        case 0x14: PushInt(GetCanLevelUp(PopObject(), PopObject())); break;

        // void CopyLocals(object oSource, object oTarget);
        case 0x15: CopyLocals(PopObject(), PopObject()); break;

        // object DoLevelUp(object oPC, object MeLevel = OBJECT_SELF);
        case 0x16: PushObject(DoLevelUp(PopObject(), PopObject())); break;

        // int HasChapterQuestItem(int nChapter, object oPC);
        case 0x17: PushInt(HasChapterQuestItem(PopInt(), PopObject())); break;

        // void DestroyChapterQuestItem(int nChapter, object oPC);
        case 0x18: DestroyChapterQuestItem(PopInt(), PopObject()); break;

        // void DestroyChapterRewardItem(int nChapter, object oPC);
        case 0x19: DestroyChapterRewardItem(PopInt(), PopObject()); break;

        // void GiveChapterRewardItem(int nChapter, object oPC);
        case 0x1A: GiveChapterRewardItem(PopInt(), PopObject()); break;

        // int HasChapterRewardItem(int nChapter, object oPC);
        case 0x1B: PushInt(HasChapterRewardItem(PopInt(), PopObject())); break;

        // int GetChapter();
        case 0x1C: PushInt(GetChapter()); break;

        // string GetMyArea(object oThing=OBJECT_SELF);
        case 0x1D: PushString(GetMyArea(PopObject())); break;

        // int EndModule();
        case 0x1E: PushInt(EndModule()); break;

        // void SpawnHenchman();
        case 0x1F: SpawnHenchman(); break;

    }

}

