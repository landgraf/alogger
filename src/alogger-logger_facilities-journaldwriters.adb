with Ada.Directories; -- use Ada.Directories;
with Ada.Exceptions; use Ada.Exceptions;
package body alogger.logger_facilities.journaldwriters is 


    overriding
    procedure Write (Self : in out jornaldwriter; Message : in Any_Message)
    is
    begin
        if not Self.Initialized then
            Self.Init; 
        end if;
        Put_Line(Standard_Output, Message.To_String);
    exception
        when Error: others =>
            Put_Line(Standard_Error, "Exception in writer"); 
            Put_Line (Exception_Information(Error));
    end Write;

    overriding
    procedure Finalize(Self : in out jornaldwriter) is 
    begin
        if Is_Open(Standard_Output) then
            Flush(Standard_Output);
        end if;
    end Finalize;

    package body Constructors is
        function Create return jornaldwriter_access is  (new jornaldwriter);
    end Constructors; 

end alogger.logger_facilities.journaldwriters; 

