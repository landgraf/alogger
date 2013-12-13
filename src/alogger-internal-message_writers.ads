with Ada.Finalization; use Ada.Finalization; 
with alogger.internal.messages; use alogger.internal.messages;
package alogger.internal.message_writers is 
    type writer is abstract new Limited_Controlled with private;
    type any_writer is access all writer'Class; 

    not overriding
    procedure Write (Self : in out writer; Message : in out Any_Message) is abstract;

    not overriding
    procedure Init (Self : in out writer) is abstract;
    -- Open files, prepare network connections etc.
private
    type writer is abstract new Limited_Controlled with record
        Initialized : Boolean := False;
    end record;


end alogger.internal.message_writers; 

