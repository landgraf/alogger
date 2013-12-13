with alogger.internal.message_writers.filewriters;
use alogger.internal.message_writers.filewriters;
with alogger.internal.messages;
use alogger.internal.messages;
package body alogger.loggers is 

    not overriding
    procedure Log(Self : in out logger;
        Text : in String; Sev : in Severity_Level) is 
    begin
        if Sev < Self.Severity then
            return;
        end if;
        declare
            M : Any_Message := new message;
        begin
            M.Set_Text(Text);
            Self.buffer.put(M);
        end;
    end Log;

    not overriding
    procedure Debug(Self : in out logger; Message : in String) is 
    begin
        Self.Log(Message, debug);
    end Debug; 

    package body constructors is 
        function Create(
            Name : String;
            Severity : severity_level
            ) return any_logger
        is
            result : any_logger;
        begin
            result := new logger(
                buffer => new message_buffer,
                writer => new filewriter(new String'(Name & ".log")) 
                );
            return result;
        end create;
    end constructors;

    not overriding
    procedure Stop(Self : in out Logger) is 
    begin
        Self.worker.Stop;
    end Stop;
end alogger.loggers; 

