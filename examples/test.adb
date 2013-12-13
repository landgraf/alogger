with Alogger.loggers; 
use alogger.loggers;
with Gnat.Source_Info; use Gnat.Source_Info; 
with Ada.Command_Line;
with Ada.Directories;
procedure test is 
    use alogger;
    logger : alogger.loggers.any_logger := alogger.loggers.constructors.create(
        Name => Ada.Directories.Simple_Name(Ada.Command_Line.Command_name), 
        severity => error); 
    --  level should be configurable
    --  On_Panic - procedure to do on log panic (IO issue for example);
begin
    for I in 1..2**16 loop
        logger.debug("My message", File, Line, Enclosing_Entity); 
        logger.error("Error message", File, Line, Enclosing_Entity);
        logger.info("Info message", File, Line, Enclosing_Entity);
        logger.fatal("Info message", File, Line, Enclosing_Entity);
    end loop;
    stop(logger);
    --  gnat sources info could be added here 
end test; 

