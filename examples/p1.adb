with alogger.loggers; use alogger.loggers;
with alogger.loggers.factories;
with gnat.source_info; use gnat.source_info;
package body p1 is 

    procedure Ptest is 
        logger : any_logger := alogger.loggers.factories.get_logger(
            "test");
    begin
        -- TODO add test for uninitialized logger
        if logger = null then
            raise CONSTRAINT_ERROR with "Null logger";
        end if;
        logger.error("mylog", file, line, enclosing_entity); 
    end Ptest;
end p1; 

