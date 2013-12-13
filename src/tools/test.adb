with Alogger.loggers; 
use alogger.loggers;
with Gnat.Source_Info; use Gnat.Source_Info; 
procedure test is 
    use alogger;
    logger : alogger.loggers.any_logger := alogger.loggers.constructors.create(
        Name => "myapplication", 
        severity => error); 
    --  level should be configurable
    --  On_Panic - procedure to do on log panic (IO issue for example);
begin
    logger.debug("My message", File, Line, Enclosing_Entity); 
    logger.error("Error message", File, Line, Enclosing_Entity);
    logger.info("Info message", File, Line, Enclosing_Entity);
    logger.fatal("Info message", File, Line, Enclosing_Entity);
    stop(logger);
    --  gnat sources info could be added here 
end test; 

