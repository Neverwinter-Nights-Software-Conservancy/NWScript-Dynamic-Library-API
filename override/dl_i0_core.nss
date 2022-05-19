//::///////////////////////////////////////////////
//:: NWScript Dynamic Library API v1.0
//:: dl_i0_core.nss
//:: Copyright (c) 2003 Francois Guimond
//:://////////////////////////////////////////////
/*
    This file contains all common stack and
    dynamic call functions used in the NWScript
    Dynamic Library API.
*/
//:://////////////////////////////////////////////
//:: Created By: Francois Guimond
//:: Created On: Jan 25, 2003
//:://////////////////////////////////////////////

// FUNCTION PROTOTYPES

// Dynamic command call.
// s : library symbol
// i : function symbol
void     DynCommand  (string   s, int      i);

// Dynamic float call.
// s : library symbol
// i : function symbol
float    DynFloat    (string   s, int      i);
// Dynamic int call.
// s : library symbol
// i : function symbol
int      DynInt      (string   s, int      i);
// Dynamic location call.
// s : library symbol
// i : function symbol
location DynLocation (string   s, int      i);
// Dynamic object call.
// s : library symbol
// i : function symbol
object   DynObject   (string   s, int      i);
// Dynamic string call.
// s : library symbol
// i : function symbol
string   DynString   (string   s, int      i);
// Dynamic talent call.
// s : library symbol
// i : function symbol
talent   DynTalent   (string   s, int      i);
// Dynamic vector call.
// s : library symbol
// i : function symbol
vector   DynVector   (string   s, int      i);

// Pop a float from the stack.
float    PopFloat    (          );
// Pop an int from the stack.
int      PopInt      (          );
// Pop a location from the stack.
location PopLocation (          );
// Pop an object from the stack.
object   PopObject   (          );
// Pop a string from the stack.
string   PopString   (          );
// Pop a talent from the stack.
talent   PopTalent   (          );
// Pop a vector from the stack.
vector   PopVector   (          );

// Push a float on top of the stack.
void     PushFloat   (float    f);
// Push an int on top of the stack.
void     PushInt     (int      i);
// Push a location on top of the stack.
void     PushLocation(location l);
// Push an object on top of the stack.
void     PushObject  (object   o);
// Push a string on top of the stack.
void     PushString  (string   s);
// Push a talent on top of the stack.
void     PushTalent  (talent   t);
// Push a vector on top of the stack.
void     PushVector  (vector   v);

// FUNCTION IMPLEMENTATIONS

void DynCommand(string s, int i)
{
    PushInt(i);
    ExecuteScript(s, OBJECT_SELF);
}

float DynFloat(string s, int i)
{
    DynCommand(s, i);
    return PopFloat();
}

int DynInt(string s, int i)
{
    DynCommand(s, i);
    return PopInt();
}

location DynLocation(string s, int i)
{
    DynCommand(s, i);
    return PopLocation();
}

object DynObject(string s, int i)
{
    DynCommand(s, i);
    return PopObject();
}

string DynString(string s, int i)
{
    DynCommand(s, i);
    return PopString();
}

talent DynTalent(string s, int i)
{
    DynCommand(s, i);
    return PopTalent();
}

vector DynVector(string s, int i)
{
    DynCommand(s, i);
    return PopVector();
}

float PopFloat()
{
    int index = GetLocalInt(OBJECT_SELF, "DL_FLOATSTACK") - 1;
    string sVarName = "DL_FLOATSTACK_" + IntToString(index);
    float f = GetLocalFloat(OBJECT_SELF, sVarName);
    DeleteLocalFloat(OBJECT_SELF, sVarName);
    SetLocalInt(OBJECT_SELF, "DL_FLOATSTACK", index);
    return f;
}

int PopInt()
{
    int index = GetLocalInt(OBJECT_SELF, "DL_INTSTACK") - 1;
    string sVarName = "DL_INTSTACK_" + IntToString(index);
    int i = GetLocalInt(OBJECT_SELF, sVarName);
    DeleteLocalInt(OBJECT_SELF, sVarName);
    SetLocalInt(OBJECT_SELF, "DL_INTSTACK", index);
    return i;
}

location PopLocation()
{
    int index = GetLocalInt(OBJECT_SELF, "DL_LOCATIONSTACK") - 1;
    string sVarName = "DL_LOCATIONSTACK_" + IntToString(index);
    location l = GetLocalLocation(OBJECT_SELF, sVarName);
    DeleteLocalLocation(OBJECT_SELF, sVarName);
    SetLocalInt(OBJECT_SELF, "DL_LOCATIONSTACK", index);
    return l;
}

object PopObject()
{
    int index = GetLocalInt(OBJECT_SELF, "DL_OBJECTSTACK") - 1;
    string sVarName = "DL_OBJECTSTACK_" + IntToString(index);
    object o = GetLocalObject(OBJECT_SELF, sVarName);
    DeleteLocalObject(OBJECT_SELF, sVarName);
    SetLocalInt(OBJECT_SELF, "DL_OBJECTSTACK", index);
    return o;
}

string PopString()
{
    int index = GetLocalInt(OBJECT_SELF, "DL_STRINGSTACK") - 1;
    string sVarName = "DL_STRINGSTACK_" + IntToString(index);
    string s = GetLocalString(OBJECT_SELF, sVarName);
    DeleteLocalString(OBJECT_SELF, sVarName);
    SetLocalInt(OBJECT_SELF, "DL_STRINGSTACK", index);
    return s;
}

talent PopTalent()
{
    talent t;
    switch (PopInt())
    {
        case TALENT_TYPE_FEAT:  t = TalentFeat (PopInt()); break;
        case TALENT_TYPE_SKILL: t = TalentSkill(PopInt()); break;
        case TALENT_TYPE_SPELL: t = TalentSpell(PopInt()); break;
    }
    return t;
}

vector PopVector()
{
    return Vector(PopFloat(), PopFloat(), PopFloat());
}

void PushFloat(float f)
{
    int index = GetLocalInt(OBJECT_SELF, "DL_FLOATSTACK");
    SetLocalFloat(OBJECT_SELF, "DL_FLOATSTACK_" + IntToString(index), f);
    SetLocalInt(OBJECT_SELF, "DL_FLOATSTACK", index + 1);
}

void PushInt(int i)
{
    int index = GetLocalInt(OBJECT_SELF, "DL_INTSTACK");
    SetLocalInt(OBJECT_SELF, "DL_INTSTACK_" + IntToString(index), i);
    SetLocalInt(OBJECT_SELF, "DL_INTSTACK", index + 1);
}

void PushLocation(location l)
{
    int index = GetLocalInt(OBJECT_SELF, "DL_LOCATIONSTACK");
    SetLocalLocation(OBJECT_SELF, "DL_LOCATIONSTACK_" + IntToString(index), l);
    SetLocalInt(OBJECT_SELF, "DL_LOCATIONSTACK", index + 1);
}

void PushObject(object o)
{
    int index = GetLocalInt(OBJECT_SELF, "DL_OBJECTSTACK");
    SetLocalObject(OBJECT_SELF, "DL_OBJECTSTACK_" + IntToString(index), o);
    SetLocalInt(OBJECT_SELF, "DL_OBJECTSTACK", index + 1);
}

void PushString(string s)
{
    int index = GetLocalInt(OBJECT_SELF, "DL_STRINGSTACK");
    SetLocalString(OBJECT_SELF, "DL_STRINGSTACK_" + IntToString(index), s);
    SetLocalInt(OBJECT_SELF, "DL_STRINGSTACK", index + 1);
}

void PushTalent(talent t)
{
    PushInt(GetIdFromTalent(t));
    PushInt(GetTypeFromTalent(t));
}

void PushVector(vector v)
{
    PushFloat(v.x);
    PushFloat(v.y);
    PushFloat(v.z);
}

