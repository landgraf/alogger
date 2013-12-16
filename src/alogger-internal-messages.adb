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
with GNAT.Calendar.Time_IO; 
use GNAT.Calendar.Time_IO;
with Ada.Strings.Fixed;
package body alogger.internal.messages is 

    not overriding
    procedure Set_Text(Self : in out Message; Text : in String) is 
    begin
        Self.Text := To_Unbounded_String(Text);
    end Set_Text;

    not overriding
    procedure Set_Line(Self : in out Message; Line : in Natural) is
    begin
        Self.Line := Line;
    end Set_Line;

    not overriding
    procedure Set_File(Self : in out Message; File : in String) is 
    begin
        Self.File := To_Unbounded_String(File);
    end Set_File;

    not overriding
    procedure Set_Enclosing_Entity(Self : in out Message; Entity : in String) is
    begin
        Self.Unit := To_Unbounded_String(Entity);
    end Set_Enclosing_entity;

    not overriding
    procedure Set_Severity(Self : in out Message; Severity : in String) is 
    begin
        Self.Severity:= To_Unbounded_String(Severity);
    end Set_Severity;



    not overriding
    function To_String(Self : in out Message) return String is 
        Picture : constant  picture_String := 
            "%Y-%m-%d %H:%M:%S.%i";
        Result : constant String :=
            Image(Self.T, picture) & "::" & 
            To_String(Self.Severity) & "::" &
            To_String(Self.File) & "::" & 
            Ada.Strings.Fixed.Trim(Self.Line'Img, Ada.Strings.Both) & "::" & 
            To_String(Self.Unit) & "::" & 
            To_String(Self.Text); 
    begin
        return Result;
    end To_String;
end alogger.internal.messages; 

