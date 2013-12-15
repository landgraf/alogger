with alogger.loggers;
with Ada.Containers.Ordered_Maps; use Ada.Containers;

package alogger.factories is 
    function Get_Logger(Name : in String)
        return alogger.loggers.any_logger; 
    procedure Put_Logger(Name : in String;
        Logger : alogger.loggers.any_logger); 
    private
    package loggers_containers_package is
        new Ada.Containers.Ordered_Maps(Key_Type => Unbounded_String,
            Element_Type => alogger.loggers.Any_Logger); 
    subtype loggers_container is loggers_containers_package.Map; 
    type loggers_container_access is access all loggers_container; 

end alogger.factories; 

