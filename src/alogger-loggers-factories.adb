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
with Ada.Text_IO; use Ada.Text_IO;
with alogger.logger_facilities_sets; use alogger.logger_facilities_sets;
package body alogger.loggers.factories is 
    procedure Init_Logger(Name : in String; Severity : in Severity_Level) 
    is
        result : any_logger;
    begin
        result := new logger(
            buffer => new message_buffer,
            facilities => new facilities_set
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

