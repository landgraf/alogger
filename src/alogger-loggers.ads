with alogger.internal.message_buffers; 
use alogger.internal.message_buffers; 
with alogger.internal.message_workers; 
use alogger.internal.message_workers; 
with alogger.internal.message_writers;
use alogger.internal.message_writers;
with Ada.Unchecked_Deallocation; 
package alogger.loggers is 
    type severity_level is (info, debug, warning, error, fatal);
    type logger(buffer : any_buffer; writer : any_writer) is
        tagged limited private;
    type any_logger is access all logger'Class;

    not overriding
    procedure Log(Self : in out logger;
        Text : in String; Sev : in Severity_Level;
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null");

    not overriding
    procedure Debug(Self : in out logger; Message : in String; 
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null");
    
    not overriding
    procedure Error(Self : in out logger; Message : in String;
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null");

    not overriding
    procedure Info(Self : in out logger; Message : in String;
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null");

    not overriding
    procedure Fatal(Self : in out logger; Message : in String;
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null");

    not overriding
    procedure Warning(Self : in out logger; Message : in String;
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null");

    procedure Stop(Self : in out any_Logger);

    package constructors is 
        function Create(
            Name : String;
            Severity : severity_level
            ) return any_logger;
    end constructors;

private
    type logger(buffer : any_buffer; writer : any_writer) is
            tagged limited record
        severity : severity_level := info; 
        worker : any_worker := new message_worker(buffer, writer); 
        crashed : Boolean := False;
    end record;
    procedure Free_Ptr is new Ada.Unchecked_Deallocation(Name => Any_Logger, 
        Object => Logger'Class); 

end alogger.loggers; 

