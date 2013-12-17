with Ada.Finalization; use Ada.Finalization;
with alogger.internal.messages; use alogger.internal.messages;
package alogger.logger_facilities is 
    type logger_facility is abstract new Limited_Controlled with private; 
    type any_logger_facility is access all logger_facility'Class;

    not overriding
    procedure Write(Self : in out logger_facility; Message : in Any_Message)
    is abstract;

    not overriding
    procedure Init (Self : in out logger_facility) is abstract; 

    private
    type logger_facility is abstract new Limited_Controlled with
        record
            Initialized : Boolean := False;
        end record;

end alogger.logger_facilities; 

