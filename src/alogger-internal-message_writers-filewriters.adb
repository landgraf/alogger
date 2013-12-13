with Ada.Directories; -- use Ada.Directories;
with Ada.Exceptions; use Ada.Exceptions;
package body alogger.internal.message_writers.filewriters is 

    overriding
    procedure Write (Self : in out filewriter; Message : in out Any_Message)
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
        if not Ada.Directories.Exists(Self.Filename.all) then
            Create(Self.File, Append_File, Self.Filename.all); 
        else
            if not Is_Open(Self.File) then
                Open(Self.File, Append_File, Self.Filename.all);
            end if;
        end if;
    exception
        when USE_ERROR | Name_Error | Device_Error  => 
            Put_Line(Standard_Error, "Exception in writer"); 
            raise;
    end Init;
end alogger.internal.message_writers.filewriters; 

