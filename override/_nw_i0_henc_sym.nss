//::///////////////////////////////////////////////
//:: Dynamic Henchman Library Symbols v1.0
//:: _nw_i0_henc_sym.nss
//:: Copyright (c) 2003 Francois Guimond
//:://////////////////////////////////////////////
/*
    This file contains all the symbols used to
    communicate with dl_i0_henchman.
*/
//:://////////////////////////////////////////////
//:: Created By: Francois Guimond
//:: Created On: Jan 25, 2003
//:://////////////////////////////////////////////

// library symbol
string SYM_NW_I0_HENCHMAN = "dl_i0_henchman";

// object PC();
int SYM_PC = 0x00;
// void SetDidDie(int bDie);
int SYM_SET_DID_DIE = 0x01;
// int GetDidDie();
int SYM_GET_DID_DIE = 0x02;
// void SetBeenHired(int bHired=TRUE, object oTarget=OBJECT_SELF);
int SYM_SET_BEEN_HIRED = 0x03;
// int GetBeenHired(object oTarget=OBJECT_SELF);
int SYM_GET_BEEN_HIRED = 0x04;
// void SetWorkingForPlayer(object oPC);
int SYM_SET_WORKING_FOR_PLAYER = 0x05;
// int GetWorkingForPlayer(object oPC);
int SYM_GET_WORKING_FOR_PLAYER = 0x06;
// object GetFormerMaster(object oHench = OBJECT_SELF);
int SYM_GET_FORMER_MASTER = 0x07;
// void SetFormerMaster(object oPC, object oHench);
int SYM_SET_FORMER_MASTER = 0x08;
// void SetStoryVar(int nChapter, int nVal, object oTarget=OBJECT_SELF);
int SYM_SET_STORY_VAR = 0x09;
// int GetStoryVar(int nChapter, object oTarget=OBJECT_SELF);
int SYM_GET_STORY_VAR = 0x0A;
// void SetGreetingVar(int nChapter, object oPC);
int SYM_SET_GREETING_VAR = 0x0B;
// int GetGreetingVar(int nChapter, object oPC);
int SYM_GET_GREETING_VAR = 0x0C;
// string STR_PersonalItem(object oThing=OBJECT_SELF);
int SYM_STR_PERSONAL_ITEM = 0x0D;
// string STR_QuestItem(int nChapter, object oThing=OBJECT_SELF);
int SYM_STR_QUEST_ITEM = 0x0E;
// string STR_RewardItem(int nChapter, object oThing=OBJECT_SELF);
int SYM_STR_REWARD_ITEM = 0x0F;
// void DestroyAllPersonalItems(object oPC);
int SYM_DESTROY_ALL_PERSONAL_ITEMS = 0x10;
// void GivePersonalItem(object oPC, object oHench=OBJECT_SELF);
int SYM_GIVE_PERSONAL_ITEM = 0x11;
// int HasPersonalItem(object oPC);
int SYM_HAS_PERSONAL_ITEM = 0x12;
// void StripAllPersonalItemsFromEveryone();
int SYM_STRIP_ALL_PERSONAL_ITEMS_FROM_EVERYONE = 0x13;
// int GetCanLevelUp(object oPC, object meLevel = OBJECT_SELF);
int SYM_GET_CAN_LEVEL_UP = 0x14;
// void CopyLocals(object oSource, object oTarget);
int SYM_COPY_LOCALS = 0x15;
// object DoLevelUp(object oPC, object MeLevel = OBJECT_SELF);
int SYM_DO_LEVEL_UP = 0x16;
// int HasChapterQuestItem(int nChapter, object oPC);
int SYM_HAS_CHAPTER_QUEST_ITEM = 0x17;
// void DestroyChapterQuestItem(int nChapter, object oPC);
int SYM_DESTROY_CHAPTER_QUEST_ITEM = 0x18;
// void DestroyChapterRewardItem(int nChapter, object oPC);
int SYM_DESTROY_CHAPTER_REWARD_ITEM = 0x19;
// void GiveChapterRewardItem(int nChapter, object oPC);
int SYM_GIVE_CHAPTER_REWARD_ITEM = 0x1A;
// int HasChapterRewardItem(int nChapter, object oPC);
int SYM_HAS_CHAPTER_REWARD_ITEM = 0x1B;
// int GetChapter();
int SYM_GET_CHAPTER = 0x1C;
// string GetMyArea(object oThing=OBJECT_SELF);
int SYM_GET_MY_AREA = 0x1D;
// int EndModule();
int SYM_END_MODULE = 0x1E;
// void SpawnHenchman();
int SYM_SPAWN_HENCHMAN = 0x1F;

