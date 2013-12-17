with Alogger.loggers; use alogger.loggers;
with alogger.loggers.factories;
with Alogger.Logger_Facilities.Filewriters; 
use Alogger.Logger_Facilities.Filewriters;
with Gnat.Source_Info; use Gnat.Source_Info; 
with Ada.Command_Line;
with Ada.Directories;
with p1;
with Ada.Text_IO; use ada.text_IO;
procedure test is 
    use alogger;
    logger : alogger.loggers.any_logger; 
    -- logger : alogger.loggers.any_logger :=
    --     alogger.loggers.factories.init_logger(
    --         Name => Ada.Directories.Simple_Name(Ada.Command_Line.Command_name), 
    --         severity => error); 
    --  level should be configurable
    --  On_Panic - procedure to do on log panic (IO issue for example);
begin
    alogger.loggers.factories.init_logger("test", error);
    declare
        Fac : Alogger.Logger_Facilities.any_logger_facility :=
            new  filewriter(new String'("/tmp/test.log"));
    begin
        logger.attach_facility(Fac);
    end;
    logger := alogger.loggers.factories.get_logger("test");
    logger.set_config("conf/test.conf");
    logger.debug("My message", File, Line, Enclosing_Entity); 
    logger.error("Error message", File, Line, Enclosing_Entity);
    logger.info("Info message", File, Line, Enclosing_Entity);
    p1.ptest;
    logger.fatal("Info message", File, Line, Enclosing_Entity);
    stop(logger);
    --  gnat sources info could be added here 
end test; 

