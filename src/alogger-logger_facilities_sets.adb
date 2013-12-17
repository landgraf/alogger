package body alogger.logger_facilities_sets is 

    procedure Attach (Self : in out facilities_set;
        Item : in out Any_logger_Facility) is 
    begin
        Self.Fac.Append(Item);
    end Attach; 

    procedure Write (Self : in out facilities_set; Message : in Any_Message) 
    is
    begin
        for F of Self.Fac.all loop
            F.write(message);
        end loop;
    end write;
end alogger.logger_facilities_sets; 

