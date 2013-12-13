------------------------------------------------------------------------------
--                              Adevlogs Log parser                         --
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
package body fifos is 

    protected body FIFO is 
        procedure Put(E : in Element_Type) is 
        begin
            handler(First) := E;
            First := (First mod Length) + 1;
        end Put; 
        entry Get(E : out Element_Type) when First /= Last or Finished is 
        begin
            if Finished and then First = Last then
                E := Null_Element; 
                return;
            end if;
            if First = Last and then not Finished then
                raise OVERFLOW_EXCEPTION;
            end if;
            E := handler(Last); 
            Last := (last mod Length) + 1;
        end Get;
        entry Finish when First = Last is 
        begin
            Finished := True;
        end Finish;
    end FIFO;
end fifos; 

