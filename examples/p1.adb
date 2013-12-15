with alogger.loggers; use alogger.loggers;
with gnat.source_info; use gnat.source_info;
with ada.Text_Io; use ada.text_IO;
package body p1 is 

    procedure Ptest is 
        logger : any_logger := get_logger; 
    begin
        put_line("f2");
        logger.error("mylog", file, line, enclosing_entity); 
        put_line("f3");
    end Ptest;
end p1; 

