with Config_File; use Config_File;
package alogger.configs is 

    protected type config is 
        function Has_Key(Key : String) return Boolean; 
        function Get_Value(Key : String) return String;
        function Is_Open return Boolean;
        procedure Open(Filename : in String; Result : out Unbounded_String);
        -- Null string if success; 
        private
        handler : config_data; 
        Opened : Boolean := False;
    end config;

end alogger.configs; 

