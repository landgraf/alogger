with Alogger.loggers; 
use alogger.loggers;
procedure test is 
    use alogger;
    logger : alogger.loggers.any_logger := alogger.loggers.constructors.create(
        Name => "myapplication", 
        severity => debug); 
    --  level should be configurable
    --  On_Panic - procedure to do on log panic (IO issue for example);
begin
    -- logger.set_parameter("filename", "log/alogger.log"); 
    logger.debug("My message"); 
    logger.stop;
    --  gnat sources info could be added here 
end test; 

