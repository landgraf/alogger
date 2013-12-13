with alogger.internal.message_writers.filewriters;
use alogger.internal.message_writers.filewriters;
with alogger.internal.messages;
use alogger.internal.messages;
package body alogger.loggers is 

    not overriding
    procedure Log(Self : in out logger;
        Text : in String; Sev : in Severity_Level;
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null") is 
    begin
        if Self.worker'Terminated or else Self.Crashed then
            -- do not continue if worker is died
            return;
        end if;
        if Sev < Self.Severity then
            return;
        end if;
        declare
            M : Any_Message := new message;
        begin
            M.Set_Text(Text);
            M.Set_Severity(Severity_Level'Image(Sev));
            M.Set_File(File); 
            M.Set_Line(Line);
            M.Set_Enclosing_Entity(Entity);
            Self.buffer.put(M);
        end;
    exception
        when others => 
            Self.Crashed := True;
    end Log;

    not overriding
    procedure Debug(Self : in out logger; Message : in String; 
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null") is
    begin
        Self.Log(Message, debug, File, line, entity);
    end Debug; 

    not overriding
    procedure Info(Self : in out logger; Message : in String;
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null") is
    begin
        Self.Log(Message, info , File, line, entity);
    end info; 

    not overriding
    procedure Fatal(Self : in out logger; Message : in String;
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null") is
    begin
        Self.Log(Message, fatal, File, line, entity);
    end fatal; 

    not overriding
    procedure Error(Self : in out logger; Message : in String;
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null") is
    begin
        Self.Log(Message, error, File, line, entity);
    end Error; 

    not overriding
    procedure Warning(Self : in out logger; Message : in String;
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null") is
    begin
        Self.Log(Message, Warning, File, line, entity);
    end Warning; 

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
            result.severity := Severity;
            result.worker.start;
            return result;
        end create;
    end constructors;

    procedure Stop(Self : in out Any_Logger) is 
    begin
        Self.buffer.finish;
        Free_Ptr(Self);
    end Stop;

end alogger.loggers; 

