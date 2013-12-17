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
with alogger.internal.message_buffers; 
use alogger.internal.message_buffers; 
with alogger.internal.message_workers; 
use alogger.internal.message_workers; 
with alogger.internal.message_writers;
use alogger.internal.message_writers;
with Ada.Unchecked_Deallocation; 
with alogger.logger_facilities; use alogger.logger_facilities;
with alogger.configs;
with System; use System;
package alogger.loggers is 
    type severity_level is (trace, debug, info, warning, error, fatal, off);
    --  OFF     The highest possible rank and is intended 
    --      to turn off logging.
    --  FATAL   Severe errors that cause premature termination. 
    --      Expect these to be immediately visible on a status console.
    --  ERROR   Other runtime errors or unexpected conditions. 
    --      Expect these to be immediately visible on a status console.
    --  WARN    Use of deprecated APIs, poor use of API, 'almost' errors, 
    --      other runtime situations that are undesirable or unexpected, 
    --      but not necessarily "wrong". 
    --      Expect these to be immediately visible on a status console.
    --  INFO    Interesting runtime events (startup/shutdown). 
    --      Expect these to be immediately visible on a console,
    --      so be conservative and keep to a minimum.
    --  DEBUG   Detailed information on the flow through the system. 
    --      Expect these to be written to logs only.
    --  TRACE   Most detailed information. 
    --      Expect these to be written to logs only.

    type logger(buffer : any_buffer; writer : any_writer) is
        tagged limited private;
    type any_logger is access all logger'Class;


    not overriding
    procedure Attach_Facility (Self : in out logger;
        Facility : in out Logger_Facility'Class);

    not overriding
    function "="(Left : in logger; Right : in Logger) return Boolean
        is (Left'Address = Right'Address); 

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

    not overriding
    procedure off(Self : in out logger; Message : in String;
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null");

    not overriding
    procedure trace(Self : in out logger; Message : in String;
        File : in String := "null"; Line : in Natural := 0; 
        Entity : in String := "null");

    not overriding
    procedure Set_Config(Self : in out logger; Name : in String);

    procedure Stop(Self : in out any_Logger);

private
    type logger(buffer : any_buffer; writer : any_writer) is
            tagged limited record
        severity : severity_level := info; 
        worker : any_worker := new message_worker(buffer, writer); 
        crashed : Boolean := False;
        config : alogger.configs.config;
    end record;
    procedure Free_Ptr is new Ada.Unchecked_Deallocation(Name => Any_Logger, 
        Object => Logger'Class); 
end alogger.loggers; 

