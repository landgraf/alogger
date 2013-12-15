with alogger.internal.messages;
use alogger.internal.messages;
with Ada.Text_IO; use Ada.Text_IO;
package body alogger.loggers is 

    not overriding
    procedure Log(Self : in out logger;
        Text : in String; Sev : in Severity_Level;
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null") is 

        DELIM : constant Unbounded_String := To_Unbounded_String("::");
        Keys : constant array (1..3) of Unbounded_String :=
            (File & DELIM & Entity, DELIM & Entity, File & DELIM );
        overridden : Boolean := False;
        Severity : Severity_Level := Self.Severity;
    begin
        if Self.worker'Terminated or else Self.Crashed then
            -- do not continue if worker is died
            return;
        end if;
        --  Check if severity overridden by configuration file(-s)
        --  Check it only if log level is less then verbosity 
        if Sev < Severity then
            if Self.config.Is_Open then
                for k of keys loop
                    if self.config.has_key(to_string(k)) then
                        try:
                        declare
                        begin
                            severity :=
                                Severity_Level'Value(self.config.get_value(to_string(k)));
                            Overridden := True;
                            exit when Sev > Severity;
                        exception 
                            when others => null;
                        end try;
                    end if;
                end loop;
                --  if overridden severity is too low -> exiting
                if Sev < Severity then
                    return;
                end if;
            end if; 
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


    procedure Stop(Self : in out Any_Logger) is 
    begin
        Self.buffer.finish;
        Free_Ptr(Self);
    end Stop;

    not overriding
    procedure Set_Config(Self : in out logger; Name : in String) is 
        Result : Unbounded_String := Null_Unbounded_String;
    begin
        self.config.open(name, result); 
        if result /= Null_Unbounded_String then
            raise PROGRAM_ERROR with To_String(Result);
        end if;
    end Set_Config;

end alogger.loggers; 

