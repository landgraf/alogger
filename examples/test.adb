with alogger.loggers.factories;
with Alogger.Logger_Facilities.Filewriters; 
use Alogger.Logger_Facilities.Filewriters;
with Gnat.Source_Info; use Gnat.Source_Info; 
with p1;
procedure test is 
    use alogger.loggers;
    logger : alogger.loggers.any_logger; 
begin
    alogger.loggers.factories.init_logger("test", error);
    logger := alogger.loggers.factories.get_logger("test");
    declare
        Fac : Alogger.Logger_Facilities.any_logger_facility :=
            Alogger.Logger_Facilities.any_logger_facility(
                Alogger.Logger_Facilities.Filewriters.Constructors.Create
                    (
                        "/tmp/test.log"
                    ));
    begin
        logger.attach_facility(Fac);
    end;
    logger.set_config("conf/test.conf");
    logger.debug("My message", File, Line, Enclosing_Entity); 
    logger.error("Error message", File, Line, Enclosing_Entity);
    logger.info("Info message", File, Line, Enclosing_Entity);
    p1.ptest;
    logger.fatal("Info message", File, Line, Enclosing_Entity);
    stop(logger);
end test; 

