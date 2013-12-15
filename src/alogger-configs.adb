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
        exception
            when others => 
                Result := To_Unbounded_String("Exception while loading config!");
        end Open;
    end config;
end alogger.configs; 

