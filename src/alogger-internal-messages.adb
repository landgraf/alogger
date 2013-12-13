package body alogger.internal.messages is 

    not overriding
    procedure Set_Text(Self : in out Message; Text : in String) is 
    begin
        Self.Text := To_Unbounded_String(Text);
    end Set_Text;
end alogger.internal.messages; 

