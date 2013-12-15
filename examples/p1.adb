with alogger.loggers; use alogger.loggers;
with alogger.loggers.factories;
with gnat.source_info; use gnat.source_info;
with ada.Text_Io; use ada.text_IO;
package body p1 is 

    procedure Ptest is 
        logger : any_logger := alogger.loggers.factories.get_logger(
            "test");
    begin
        if logger = null then
            put_line("Null pointer"); 
            raise CONSTRAINT_ERROR with "Null logger";
        end if;
        put_line("f2");
        logger.error("mylog", file, line, enclosing_entity); 
        put_line("f3");
    end Ptest;
end p1; 

