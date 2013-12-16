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
with Ada.Containers.Ordered_Maps; use Ada.Containers;

package alogger.loggers.factories is 
    procedure Init_Logger(Name : in String; Severity : in Severity_Level);
    function Get_Logger(Name : in String)
        return alogger.loggers.any_logger; 
    private
    package loggers_containers_package is
        new Ada.Containers.Ordered_Maps(Key_Type => Unbounded_String,
            Element_Type => alogger.loggers.Any_Logger); 
    subtype loggers_container is loggers_containers_package.Map; 
    type loggers_container_access is access all loggers_container; 

    protected application_loggers is 
        procedure Put(Name : in String; Logger : in any_logger);
        function Get(Name : in String) return Any_Logger;
        function Has_Logger(Name : in String) return Boolean;
    private
        handler : loggers_container_access := new loggers_container; 
    end application_loggers; 

end alogger.loggers.factories; 

