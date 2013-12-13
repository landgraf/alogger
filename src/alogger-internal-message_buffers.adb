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
end alogger.internal.message_buffers; 

