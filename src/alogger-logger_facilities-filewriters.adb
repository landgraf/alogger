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
with Ada.Directories; -- use Ada.Directories;
with Ada.Exceptions; use Ada.Exceptions;
package body alogger.logger_facilities.filewriters is 

    overriding
    procedure Write (Self : in out filewriter; Message : in Any_Message)
    is
    begin
        if not Self.Initialized or else Is_Open(Self.File) then
            Self.Init; 
        end if;
        Put_Line(Self.File, Message.To_String);
    exception
        when Error: others =>
            Put_Line(Standard_Error, "Exception in writer"); 
            Put_Line (Exception_Information(Error));
    end Write;

    overriding
    procedure Finalize(Self : in out filewriter) is 
    begin
        if Is_Open(Self.file) then
            Flush(Self.File);
            Close(Self.File);
        end if;
    end Finalize;

    overriding
    procedure Init(Self : in out filewriter) is 
    begin
        if not Ada.Directories.Exists(to_String(Self.Filename)) then
            Create(Self.File, Append_File, To_String(Self.Filename)); 
        else
            if not Is_Open(Self.File) then
                Open(Self.File, Append_File, To_String(Self.Filename));
            end if;
        end if;
    exception
        when USE_ERROR | Name_Error | Device_Error  => 
            Put_Line(Standard_Error, "Exception in writer"); 
            raise;
    end Init;

    package body Constructors is
        function Create(Filename : in String) return filewriter_access
        is
            result : filewriter_access := new filewriter;
        begin
            result.filename := To_Unbounded_String(Filename); 
            return result;
        end Create;
    end Constructors; 
end  alogger.logger_facilities.filewriters;

