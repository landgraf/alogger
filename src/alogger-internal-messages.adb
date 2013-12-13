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

