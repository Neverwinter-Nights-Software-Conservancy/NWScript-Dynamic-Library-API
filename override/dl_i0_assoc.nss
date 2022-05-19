//::///////////////////////////////////////////////
//:: Dynamic Generic Associate Library v1.0
//:: dl_i0_assoc.nss
//:: Copyright (c) 2003 Francois Guimond
//:://////////////////////////////////////////////
/*
    This file performs all the static calls to the
    generic associate library from the dynamic
    library interface.
*/
//:://////////////////////////////////////////////
//:: Created By: Francois Guimond
//:: Created On: Jan 25, 2003
//:://////////////////////////////////////////////

#include "dl_i0_core"
#include "_nw_i0_assoc"

void main()
{

    switch (PopInt())
    {

        // void SpeakQuickChat(string sVoice);
        case 0x00: SpeakQuickChat(PopString()); break;

        // void DebugSTR(string s);
        case 0x01: DebugSTR(PopString()); break;

        // int IsBusy();
        case 0x02: PushInt(IsBusy()); break;

        // void SetIsBusy(int bIsBusy);
        case 0x03: SetIsBusy(PopInt()); break;

        // void DetermineAssociateCombatRound();
        case 0x04: DetermineAssociateCombatRound(); break;

        // void OpenNearestLock();
        case 0x05: OpenNearestLock(); break;

        // void DoFollowMaster();
        case 0x06: DoFollowMaster(); break;

        // void GetBehind();
        case 0x07: GetBehind(); break;

    }

}

