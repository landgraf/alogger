with Ada.Finalization; use Ada.Finalization;
package alogger.logger_facilities is 
    type logger_facility is abstract new Limited_Controlled with private; 
    type any_logger_facility is access all logger_facility'Class;

    private
    type logger_facility is abstract new Limited_Controlled with
        null record;

end alogger.logger_facilities; 

