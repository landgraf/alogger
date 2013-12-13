with Ada.Finalization; use Ada.Finalization;
with Ada.Calendar;
package alogger.internal.messages is 
    type message is new Limited_Controlled with private;
    type Any_Message is access all Message'Class; 

    not overriding
    procedure Set_Text(Self : in out Message; Text : in String); 

    not overriding
    procedure Set_Line(Self : in out Message; Line : in Natural); 

    not overriding
    procedure Set_File(Self : in out Message; File : in String); 

    not overriding
    procedure Set_Enclosing_Entity(Self : in out Message; Entity : in String); 

    not overriding
    procedure Set_Severity(Self : in out Message; Severity : in String);

    not overriding
    function To_String(Self : in out Message) return String;

    private
    type message is new Limited_Controlled with record
        Text : Unbounded_String := Null_Unbounded_String; 
        Severity : Unbounded_String := Null_Unbounded_String;
        T : Ada.Calendar.Time := Ada.Calendar.Clock; 
        File : Unbounded_String := Null_Unbounded_String; 
        Line : Natural := 0;
        Unit : Unbounded_String := Null_Unbounded_String; 
    end record;

end alogger.internal.messages; 

