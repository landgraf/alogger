with alogger.internal.message_writers.filewriters;
use alogger.internal.message_writers.filewriters;
with Ada.Text_IO; use Ada.Text_IO;
package body alogger.loggers.factories is 
    procedure Init_Logger(Name : in String; Severity : in Severity_Level) 
    is
        result : any_logger;
    begin
        result := new logger(
            buffer => new message_buffer,
            writer => new filewriter(new String'(Name & ".log")) 
            );
        result.severity := Severity;
        result.worker.start;
        application_loggers.Put(Name, result);
    end Init_Logger; 

    function Get_Logger(Name : in String)
        return alogger.loggers.any_logger is 
    begin
        if application_loggers.has_logger(Name) then
            return application_loggers.get(name);
        else
            return null;
        end if;
    end Get_Logger; 

    protected body application_loggers is 
        procedure Put(Name : in String; Logger : in any_logger) is
            Key : Unbounded_String := To_Unbounded_String(Name);
        begin
            handler.Insert(Key, Logger);
        end Put;
        function Get(Name : in String) return Any_Logger is
            Key : Unbounded_String := To_Unbounded_String(Name);
        begin
            return handler.element(Key);
        end Get;

        function Has_Logger(Name : in String) return Boolean is
            Key : Unbounded_String := To_Unbounded_String(Name);
        begin
            return handler.contains(Key);
        end Has_Logger;

    end application_loggers; 

end alogger.loggers.factories; 

