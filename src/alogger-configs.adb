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
with Ada.Directories; 
package body alogger.configs is 

    protected body config is 
        function Has_Key(Key : String) return Boolean is 
        begin
            return has_key(handler, Key);
        end Has_Key;

        function Get_Value(Key : String) return String is 
        begin
            return Get_String(handler, Key); 
        end Get_Value;

        procedure Open(Filename : in String;
            Result : out Unbounded_String) is
        begin
            if not Ada.Directories.Exists(Filename) then
                Result := To_Unbounded_String("File not found!");
                return;
            end if;
            Load(handler, Filename);
            Opened := True;
        exception
            when others => 
                Result := To_Unbounded_String("Exception while loading config!");
        end Open;

        function Is_Open return Boolean is (Opened);

    end config;
end alogger.configs; 

