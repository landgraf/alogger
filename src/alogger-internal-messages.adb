with GNAT.Calendar.Time_IO; 
use GNAT.Calendar.Time_IO;
package body alogger.internal.messages is 

    not overriding
    procedure Set_Text(Self : in out Message; Text : in String) is 
    begin
        Self.Text := To_Unbounded_String(Text);
    end Set_Text;

    not overriding
    function To_String(Self : in out Message) return String is 
        Picture : constant  picture_String := 
            "%Y-%m-%d %H:%M:%S.i";
        Result : constant String :=
            Image(Self.T, picture) & "::" & 
            To_String(Self.Severity) & "::" &
            To_String(Self.File) & "::" & 
            To_String(Self.Unit) & "::" & 
            To_String(Self.Text); 
    begin
        return Result;
    end To_String;
end alogger.internal.messages; 

