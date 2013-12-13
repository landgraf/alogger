with alogger.internal.message_buffers; 
use alogger.internal.message_buffers; 
with alogger.internal.message_workers; 
use alogger.internal.message_workers; 
with alogger.internal.message_writers;
use alogger.internal.message_writers;
package alogger.loggers is 
    type severity_level is (info, debug, warning, error, fatal);
    type logger(buffer : any_buffer; writer : any_writer) is
        tagged limited private;
    type any_logger is access all logger'Class;

    not overriding
    procedure Log(Self : in out logger;
        Text : in String; Sev : in Severity_Level);

    not overriding
    procedure Debug(Self : in out logger; Message : in String);

    not overriding
    procedure Stop(Self : in out Logger);

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
    end record;

end alogger.loggers; 

