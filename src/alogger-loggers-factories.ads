with Ada.Containers.Ordered_Maps; use Ada.Containers;

package alogger.loggers.factories is 
    procedure Init_Logger(Name : in String; Severity : in Severity_Level);
    function Get_Logger(Name : in String)
        return alogger.loggers.any_logger; 
    private
    package loggers_containers_package is
        new Ada.Containers.Ordered_Maps(Key_Type => Unbounded_String,
            Element_Type => alogger.loggers.Any_Logger); 
    subtype loggers_container is loggers_containers_package.Map; 
    type loggers_container_access is access all loggers_container; 

    protected application_loggers is 
        procedure Put(Name : in String; Logger : in any_logger);
        function Get(Name : in String) return Any_Logger;
        function Has_Logger(Name : in String) return Boolean;
    private
        handler : loggers_container_access := new loggers_container; 
    end application_loggers; 

end alogger.loggers.factories; 

