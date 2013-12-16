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
with Ada.Finalization; use Ada.Finalization;
with Ada.Calendar;
package alogger.internal.messages is 
    type message is new Limited_Controlled with private;
    type Any_Message is access all Message'Class; 

    not overriding
    procedure Set_Text(Self : in out Message; Text : in String); 

    not overriding
    procedure Set_Line(Self : in out Message; Line : in Natural); 

    not overriding
    procedure Set_File(Self : in out Message; File : in String); 

    not overriding
    procedure Set_Enclosing_Entity(Self : in out Message; Entity : in String); 

    not overriding
    procedure Set_Severity(Self : in out Message; Severity : in String);

    not overriding
    function To_String(Self : in out Message) return String;

    private
    type message is new Limited_Controlled with record
        Text : Unbounded_String := Null_Unbounded_String; 
        Severity : Unbounded_String := Null_Unbounded_String;
        T : Ada.Calendar.Time := Ada.Calendar.Clock; 
        File : Unbounded_String := Null_Unbounded_String; 
        Line : Natural := 0;
        Unit : Unbounded_String := Null_Unbounded_String; 
    end record;

end alogger.internal.messages; 

