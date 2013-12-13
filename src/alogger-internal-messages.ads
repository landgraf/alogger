with Ada.Finalization; use Ada.Finalization;
with Ada.Calendar;
package alogger.internal.messages is 
    type message is new Limited_Controlled with private;
    type Any_Message is access all Message'Class; 

    not overriding
    procedure Set_Text(Self : in out Message; Text : in String); 

    not overriding
    function To_String(Self : in out Message) return String;

    private
    type message is new Limited_Controlled with record
        Text : Unbounded_String := Null_Unbounded_String; 
        Severity : Unbounded_String := Null_Unbounded_String;
        T : Ada.Calendar.Time := Ada.Calendar.Clock; 
        File : Unbounded_String := Null_Unbounded_String; 
        Unit : Unbounded_String := Null_Unbounded_String; 
    end record;

end alogger.internal.messages; 

