with Alogger.loggers; use alogger.loggers;
with alogger.loggers.factories;
with Alogger.Logger_Facilities.Filewriters; 
use Alogger.Logger_Facilities.Filewriters;
with Gnat.Source_Info; use Gnat.Source_Info; 
with Ada.Command_Line;
with Ada.Directories;
with p1;
with Ada.Text_IO; use ada.text_IO;
with Ada.Exceptions; 
procedure test is 
    use alogger;
    use Alogger.Logger_Facilities;
    logger : alogger.loggers.any_logger; 
begin
    alogger.loggers.factories.init_logger("test", error);
    logger := alogger.loggers.factories.get_logger("test");
    declare
        Fac : Alogger.Logger_Facilities.any_logger_facility :=
            new  filewriter(new String'("/tmp/test.log"));
    begin
        logger.attach_facility(Fac);
    exception
        when E: others => 
            Put_Line(Ada.Exceptions.Exception_Message(E));
    end;
    logger.set_config("conf/test.conf");
    logger.debug("My message", File, Line, Enclosing_Entity); 
    logger.error("Error message", File, Line, Enclosing_Entity);
    logger.info("Info message", File, Line, Enclosing_Entity);
    p1.ptest;
    logger.fatal("Info message", File, Line, Enclosing_Entity);
    stop(logger);
    --  gnat sources info could be added here 
end test; 

