package body alogger.internal.message_buffers is 

    not overriding
    procedure Put(Self : in out message_buffer; Item : in Any_Message) is 
    begin
        Self.buf.Put(Item);
    end Put;

    not overriding
    procedure Get(Self : in out message_buffer; Item : out Any_Message) is 
    begin
        Self.buf.Get(Item);
    end Get;

    not overriding
    procedure Finish (Self : in out message_buffer) is 
    begin
        Self.buf.finish;
    end Finish;
end alogger.internal.message_buffers; 

