with Ada.Containers.Vectors; use Ada.Containers;
with alogger.logger_facilities; use alogger.logger_facilities;
with Ada.Finalization; use Ada.Finalization;
with alogger.internal.messages; use alogger.internal.messages;
package alogger.logger_facilities_sets is 

    type facilities_set is new Limited_Controlled with private; 
    type facilities_set_access is access all facilities_set;

    procedure Attach (Self : in out facilities_set;
        Item : in out Any_logger_Facility); 

    procedure Write (Self : in out facilities_set; Message : Any_Message);

    private

    package facilities_vector_package is
        new Ada.Containers.Vectors(Index_Type => Natural, 
            Element_Type => any_logger_facility); 

    subtype facilities_vector is facilities_vector_package.Vector;
    type facilities_vector_access is access all facilities_vector;


    type facilities_set is new Limited_Controlled with record
        fac : facilities_vector_access := new facilities_vector;
    end record;

end alogger.logger_facilities_sets; 

