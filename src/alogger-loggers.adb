------------------------------------------------------------------------------
--                              Ada Logging framework                       --
--                                                                          --
--        Copyright (C) 2013, Pavel Zhukov <pavel at zhukoff dot net>       --
--                                                                          --
--  This library is free software;  you can redistribute it and/or modify   --
--  it under terms of the  GNU General Public License  as published by the  --
--  Free Software  Foundation;  either version 3,  or (at your  option) any --
--  later version. This library is distributed in the hope that it will be  --
--  useful, but WITHOUT ANY WARRANTY;  without even the implied warranty of --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                    --
--                                                                          --
--  As a special exception under Section 7 of GPL version 3, you are        --
--  granted additional permissions described in the GCC Runtime Library     --
--  Exception, version 3.1, as published by the Free Software Foundation.   --
--                                                                          --
--  You should have received a copy of the GNU General Public License and   --
--  a copy of the GCC Runtime Library Exception along with this program;    --
--  see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see   --
--  <http://www.gnu.org/licenses/>.                                         --
--                                                                          --
--  As a special exception, if other files instantiate generics from this   --
--  unit, or you link this unit with other files to produce an executable,  --
--  this  unit  does not  by itself cause  the resulting executable to be   --
--  covered by the GNU General Public License. This exception does not      --
--  however invalidate any other reasons why the executable file  might be  --
--  covered by the  GNU Public License.                                     --
------------------------------------------------------------------------------
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
    procedure off(Self : in out logger; Message : in String;
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null") is
    begin
        Self.log(message, off, file, line, entity);
    end off;

    not overriding
    procedure trace(Self : in out logger; Message : in String;
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null") is 
    begin
        self.log(message, trace, file, line, entity); 
    end trace;

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

    not overriding
    procedure Attach_Facility (Self : in out logger;
        Facility : in out Logger_Facility'Class) is 
    begin
        Self.Facilities.attach(facility);
    end Attach_Facility;
end alogger.loggers; 

